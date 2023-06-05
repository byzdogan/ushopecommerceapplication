import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/inner_screens/product_details.dart';
import 'package:ushopecommerceapplication/models/viewed_model.dart';
import 'package:ushopecommerceapplication/providers/cart_provider.dart';
import 'package:ushopecommerceapplication/providers/products_provider.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyWidgetState createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final viewedProductModel = Provider.of<ViewedProductModel>(context);

    final getCurrentProduct =
        productProvider.findProdById(viewedProductModel.productId);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;

    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrentProduct.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  GestureDetector(
        onTap: () {
          //GlobalMethods.navigateTo(
          //    ctx: context, routeName: ProductDetails.routeName);
          Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: viewedProductModel.productId);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FancyShimmerImage(
              imageUrl: getCurrentProduct.imageUrl,
              boxFit: BoxFit.fill,
              height: size.width * 0.27,
              width: size.width * 0.25,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                TextWidget(
                  text: getCurrentProduct.title,
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextWidget(
                  text: "${usedPrice.toStringAsFixed(2)}",
                  color: color,
                  textSize: 20,
                  isTitle: false,
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: Colors.cyan,
                child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _isInCart
                        ? null
                        : () async{
                      final User? user = authInstance.currentUser;
                      //print("USER ID IS ${user!.uid}");
                      if(user == null) {
                        GlobalMethods.errorDialog(
                            error: "You need to login first!",
                            context: context);
                        return;
                      }
                      await GlobalMethods.addToCart(
                              productId: getCurrentProduct.id,
                              quantity: 1,
                              context: context);
                      await cartProvider.fetchCart();
                      /*cartProvider.addProductsToCart(
                          productId: getCurrentProduct.id,
                          quantity: 1);*/
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        _isInCart ? Icons.check : CupertinoIcons.cart_badge_plus,
                        size: 30,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),

    );
  }
}