import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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


class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key,}) : super(key: key);

  //final String imageUrl, title;

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text="1";
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final theme = Utils(context).getTheme;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    bool? _isInWishlist = wishlistProvider.getWishlistItems.containsKey(productModel.id);
    final viewedProdProvider = Provider.of<ViewedProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            viewedProdProvider.addProductToHistory(productId: productModel.id);
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
            /*GlobalMethods.navigateTo(
                ctx: context,
                routeName: ProductDetails.routeName);*/
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children:[
              const SizedBox(height: 4,), //ben ekledim
              FancyShimmerImage(
                imageUrl: productModel.imageUrl,
                height: size.width*0.21,
                width: size.width*0.2,
                boxFit: BoxFit.fill,
              ),
              const SizedBox(height: 6,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex:3,
                      child: TextWidget(
                        maxLines: 1,
                        text: productModel.title,
                        color: color,
                        textSize: 20,
                        isTitle: true,
                      ),
                    ),
                    //Spacer(),
                    //const SizedBox(width: 30,),
                    Flexible(
                        flex:1,
                      child: HeartBTN(
                        productId: productModel.id,
                        isInWishlist: _isInWishlist,)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6,), //6
              Flexible(
                flex: 4, //2
                child: PriceWidget(
                  salePrice: productModel.salePrice,
                  price: productModel.price,
                  textPrice: _quantityTextController.text,
                  isOnSale: productModel.isOnSale,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0), //5
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 6,
                      child: Row(
                        children: [
                          FittedBox(
                            child: TextWidget(
                              text: "Quantity:", //productModel.isPiece ? "Piece" : "KG",
                              color: color,
                              textSize: 20,
                              isTitle: true,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: TextFormField(
                              controller: _quantityTextController,
                              key: const ValueKey("10"),
                              style: TextStyle(color: color, fontSize: 18,),
                              keyboardType: TextInputType.number,
                              //validator: (value) {
                              //if (value!.isEmpty) {
                              //return 'Quantity is missed';
                              //}
                              //return null;
                              //},
                              maxLines: 1,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              textAlign: TextAlign.center,
                              //cursorColor: Colors.green,
                              enabled: true,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    _quantityTextController.text = '1';
                                  } else {
                                    // total = usedPrice *
                                    //     int.parse(_quantityTextController.text);
                                  }
                                  onSaved: (value) {};
                                });
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
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
                              productId: productModel.id,
                              quantity: int.parse(_quantityTextController.text),
                              context: context);
                      await cartProvider.fetchCart();

                      /*cartProvider.addProductsToCart(
                          productId: productModel.id,
                          quantity: int.parse(_quantityTextController.text));*/
                    },
                    child: TextWidget(
                      text: _isInCart ? "In Cart" : "Add to cart",
                      maxLines: 1,
                      color: color,
                      textSize: 20,
                      isTitle: false,
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).cardColor), //text button background color için
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                          ),
                        )),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
