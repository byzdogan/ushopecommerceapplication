import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/inner_screens/product_details.dart';
import 'package:ushopecommerceapplication/models/products_model.dart';
import 'package:ushopecommerceapplication/providers/cart_provider.dart';
import 'package:ushopecommerceapplication/providers/viewed_provider.dart';
import 'package:ushopecommerceapplication/providers/wishlist_provider.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/heart_btn.dart';
import 'package:ushopecommerceapplication/widgets/price_widget.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final viewedProdProvider = Provider.of<ViewedProductProvider>(context);

    bool? _isInWishlist = wishlistProvider.getWishlistItems.containsKey(productModel.id);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);

    return Padding(
      padding: const EdgeInsets.all(6.0), //7 //8
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            viewedProdProvider.addProductToHistory(productId: productModel.id);
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
            /*GlobalMethods.navigateTo(
                ctx: context,
                routeName: ProductDetails.routeName);*/
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(3.0,6.0,3.0,3.0), //8
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: productModel.imageUrl,
                      height: size.width*0.22,
                      width: size.width*0.22,
                      boxFit: BoxFit.fill,
                    ),
                    GestureDetector(
                          onTap: _isInCart
                              ? null
                              : () async {
                            final User? user = authInstance.currentUser;
                            if(user == null) {
                              GlobalMethods.errorDialog(
                                  error: "You need to login first!",
                                  context: context);
                              return;
                            }
                            await GlobalMethods.addToCart(
                                    productId: productModel.id,
                                    quantity: 1,
                                    context: context);
                            await cartProvider.fetchCart();
                            /*cartProvider.addProductsToCart(
                                productId: productModel.id,
                                quantity: 1); artık sepete ekleme global methods ile*/
                          },
                          child: Icon(
                            _isInCart ? IconlyBold.bag : IconlyLight.bag,
                            size: 22,
                            color: _isInCart ? Colors.cyan : color,
                          ),
                        ),
                    HeartBTN(
                      productId: productModel.id,
                      isInWishlist: _isInWishlist,)
                        //const PriceWidget(),
                      ],
                ),
                const SizedBox(
                  height: 5,),
                TextWidget(
                  text: productModel.title,
                  color: color,
                  textSize: 18, //16
                  isTitle: true,),
                const SizedBox(
                  height: 5,),
                PriceWidget(
                  salePrice: productModel.salePrice,
                  price: productModel.price,
                  textPrice: "1",
                  isOnSale: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}