import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/providers/cart_provider.dart';
import 'package:ushopecommerceapplication/providers/products_provider.dart';
import 'package:ushopecommerceapplication/screens/cart/cart_widget.dart';
import 'package:ushopecommerceapplication/widgets/empty_cart_screen.dart';
import 'package:ushopecommerceapplication/widgets/empty_screen.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    //bool _isEmpty = true;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList = cartProvider.getCartItems.values.toList().reversed.toList();
    //return _isEmpty
    return cartItemsList.isEmpty
        ? const EmptyCartScreen(
            title: 'Your cart is empty!',
            subtitle: 'Add something and make me happy :)',
            buttonText: 'Shop now',
            imagePath: 'assets/images/emptycart2.png',
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                text: "Cart (${cartItemsList.length})",
                textSize: 22,
                isTitle: true,
                color: color,),
              actions: [
                IconButton(
                    onPressed: () {
                      GlobalMethods.warningDialog(
                          title: "Empty your cart",
                          subtitle: "Are you sure?",
                          fct: () async{
                            await cartProvider.clearOnlineCart();
                            cartProvider.clearLocalCart();
                          },
                          context: context);
                    },
                    icon: Icon(
                      IconlyLight.delete, //IconlyBroken.delete,
                      color: color,
                    ))
              ],),
            body: Column(//A listview that wrapped by column need a size or you can wrap it with an expanded widget
                    children: [
                      _checkout(ctx: context),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartItemsList.length,
                          itemBuilder: (ctx, index){
                            return ChangeNotifierProvider.value(
                              value: cartItemsList[index],
                              child: CartWidget(
                                q: cartItemsList[index].quantity,
                              ),
                            ) ;
                          }),),
                    ],
            ),
          );
  }

  Widget _checkout({required BuildContext ctx}) {
    final Color color = Utils(ctx).color;
    Size size = Utils(ctx).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(ctx);
    final productProvider = Provider.of<ProductsProvider>(ctx);
    double totalPrice = 0.0;
    cartProvider.getCartItems.forEach((key, value) { // reading the cart map and looping it
      // with this value we can access everything in out cart model
      final getCurrentProduct = productProvider.findProdById(value.productId);
      totalPrice += (getCurrentProduct.isOnSale
              ? getCurrentProduct.salePrice
              : getCurrentProduct.price) * value.quantity;
    });
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      //color: ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), //10
        child: Row(
          children: [
            Material(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: "ORDER NOW",
                    textSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
            FittedBox(
              child: TextWidget(
                text: "Total: ${totalPrice.toStringAsFixed(2)}₺",
                color: color,
                textSize: 20,
                isTitle: true,),),
          ],
        ),
      ),
    );
  }
}