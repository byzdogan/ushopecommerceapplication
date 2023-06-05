import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/inner_screens/product_details.dart';
import 'package:ushopecommerceapplication/models/wishlist_model.dart';
import 'package:ushopecommerceapplication/providers/cart_provider.dart';
import 'package:ushopecommerceapplication/providers/products_provider.dart';
import 'package:ushopecommerceapplication/providers/viewed_provider.dart';
import 'package:ushopecommerceapplication/providers/wishlist_provider.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/heart_btn.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final wishlistModel = Provider.of<WishlistModel>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrentProduct = productProvider.findProdById(wishlistModel.productId);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    bool? _isInWishlist = wishlistProvider.getWishlistItems.containsKey(getCurrentProduct.id);
    bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrentProduct.id);
    final viewedProdProvider = Provider.of<ViewedProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(15.0) ,
      child: GestureDetector(
        onTap: () {
          //GlobalMethods.navigateTo(ctx: context, routeName: ProductDetails.routeName);
          viewedProdProvider.addProductToHistory(productId: getCurrentProduct.id);
          Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: wishlistModel.productId);
        },
        child: Container(
          height: size.height * 0.25,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,// .withOpacity(0.5),
            border: Border.all(color: color, width: 1), //1
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(left: 8,),
                            //width: size.width * 0.2,
                            height: size.width * 0.25,
                            child: FancyShimmerImage(
                              imageUrl: getCurrentProduct.imageUrl,
                              boxFit: BoxFit.fill,
                            ),
                          ),
                        ),
                            Column(
                              children: [
                                HeartBTN(
                                  productId: getCurrentProduct.id,
                                  isInWishlist: _isInWishlist,),
                                IconButton( //BEN EKLEDİM
                                  onPressed: _isInCart
                                      ? null
                                      : () async{
                                    /*if(_isInCart) {
                                            return;
                                          }  bunu yapmak yerine üstte ? : yaptık. */
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
                                            productId: productModel.id,
                                            quantity: int.parse(_quantityTextController.text));*/
                                  },
                                  icon: Icon (
                                    _isInCart ? IconlyBold.bag : IconlyLight.bag,
                                    color: _isInCart ? Colors.cyan : color,),
                                ),
                              ],
                            )
                        //const PriceWidget(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,),
                    TextWidget(
                      text: getCurrentProduct.title,
                      color: color,
                      textSize: 20, //16
                      isTitle: true,),
                    const SizedBox(
                      height: 5,),
                    TextWidget(
                      text: "${usedPrice.toStringAsFixed(2)}₺",
                      textSize: 18,
                      maxLines: 1,
                      isTitle: true,
                      color: color,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
