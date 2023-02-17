import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/inner_screens/product_details.dart';
import 'package:ushopecommerceapplication/models/wishlist_model.dart';
import 'package:ushopecommerceapplication/providers/cart_provider.dart';
import 'package:ushopecommerceapplication/providers/products_provider.dart';
import 'package:ushopecommerceapplication/providers/wishlist_provider.dart';
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

    return Padding(
        padding: const EdgeInsets.all(8.0) ,
        child: GestureDetector(
          onTap: () {
            //GlobalMethods.navigateTo(ctx: context, routeName: ProductDetails.routeName);
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: wishlistModel.productId);
          },
          child: Container(
            height: size.height * 0.2,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,// .withOpacity(0.5),
              border: Border.all(color: color, width: 2), //1
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
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
                Flexible(
                  flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            children: [
                              IconButton(onPressed: () {
                                //ben ekledim
                                cartProvider.addProductsToCart(
                                    productId: getCurrentProduct.id,
                                    quantity: 1);
                              },
                                icon: Icon (
                                  _isInCart ? IconlyBold.bag : IconlyLight.bag,
                                  color: _isInCart ? Colors.cyan : color,),
                              ),
                              HeartBTN(
                                productId: getCurrentProduct.id,
                                isInWishlist: _isInWishlist,),
                            ],
                          ),
                        Flexible(
                            flex: 3,
                            child: TextWidget(
                              text: getCurrentProduct.title,
                              textSize: 20,
                              maxLines: 1,
                              isTitle: true,
                              color: color,)),
                        const SizedBox(height: 5,),
                        TextWidget(
                          text: "${usedPrice.toStringAsFixed(2)}₺",
                          textSize: 18,
                          maxLines: 1,
                          isTitle: true,
                          color: color,),
                      ],
                    ),),

              ],
            ),
          ),
        ),
    );
  }
}
