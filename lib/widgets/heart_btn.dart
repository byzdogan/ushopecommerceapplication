import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/models/products_model.dart';
import 'package:ushopecommerceapplication/providers/products_provider.dart';
import 'package:ushopecommerceapplication/providers/wishlist_provider.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/services/utils.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({Key? key, required this.productId, this.isInWishlist = false})
      : super(key: key);
  final String productId;
  final bool? isInWishlist; //adding null is okay because it has already initislized as a false in the heart button widget.

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct = productProvider.findProdById(productId);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () async{
        try{
          final User? user = authInstance.currentUser;
          if(user == null) {
            GlobalMethods.errorDialog(
                error: "You need to login first!",
                context: context);
            return;
        }
          if(isInWishlist == false && isInWishlist != null) {
            await GlobalMethods.addToWishlist(
                    productId: productId,
                    context: context);
          }else {
            wishlistProvider.removeOneItem(
                wishlistId: wishlistProvider.getWishlistItems[getCurrentProduct.id]!.id,
                productId: productId);
          }
          await wishlistProvider.fetchWishlist();
        }catch(error) {
          GlobalMethods.errorDialog(
              error: "$error",
              context: context);
        }finally{}

        /*final User? user = authInstance.currentUser;
        if(user == null) {
          GlobalMethods.errorDialog(
              error: "You need to login first!",
              context: context);
          return;
        }
        wishlistProvider.addRemoveProductToWishlist(
            productId: productId); firebaseden önceki versiyon*/
      },
      child: Icon(
        isInWishlist != null && isInWishlist == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: 22,
        color: isInWishlist != null && isInWishlist == true
            ? Colors.redAccent
            : color,
      ),
    );
  }
}
