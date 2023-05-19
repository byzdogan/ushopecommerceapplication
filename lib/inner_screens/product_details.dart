import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/providers/cart_provider.dart';
import 'package:ushopecommerceapplication/providers/products_provider.dart';
import 'package:ushopecommerceapplication/providers/viewed_provider.dart';
import 'package:ushopecommerceapplication/providers/wishlist_provider.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/widgets/heart_btn.dart';
import '../services/utils.dart';
import '../widgets/text_widget.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _quantityTextController = TextEditingController(text: '1');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;

    final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrentProduct = productProvider.findProdById(productId);

    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;

    double totalPrice = usedPrice * int.parse(_quantityTextController.text);

    bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrentProduct.id);
    bool? _isInWishlist = wishlistProvider.getWishlistItems.containsKey(getCurrentProduct.id);

    final viewedProdProvider = Provider.of<ViewedProductProvider>(context);
    return WillPopScope(
      onWillPop: () async{
        //viewedProdProvider.addProductToHistory(productId: productId);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
              leading: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () =>
                Navigator.canPop(context) ? Navigator.pop(context) : null,
                child: Icon(
                  IconlyLight.arrow_left,
                  color: color,
                  size: 24,
                ),
              ),
              elevation: 1,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor),
          body: Column(
              children: [
                Flexible(
                  flex: 5, //2//picture height(size)
                  child: FancyShimmerImage(
                    imageUrl: getCurrentProduct.imageUrl,
                    boxFit: BoxFit.scaleDown,
                    width: size.width,
                    // height: screenHeight * .4,
                  ),
                ),
                Flexible(
                  flex: 7, //3
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor, //.backgroundColor, resmin altındaki alanı renksizleştirmek için
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: TextWidget(
                                  text: getCurrentProduct.title,
                                  color: color,
                                  textSize: 25,
                                  isTitle: true,
                                ),
                              ),
                              HeartBTN(
                                productId: getCurrentProduct.id,
                                isInWishlist: _isInWishlist,),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextWidget(
                                text: "${usedPrice.toStringAsFixed(2)}₺",
                                color: Colors.green,
                                textSize: 25,
                                isTitle: true,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Visibility(
                                visible: getCurrentProduct.isOnSale ? true : false,
                                child: Text(
                                  "${getCurrentProduct.price.toStringAsFixed(2)}₺",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: color,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(10, 178, 176, 1.0),
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextWidget(
                                  text: 'Free delivery',
                                  color: Colors.white,
                                  textSize: 20,
                                  isTitle: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              /*TextWidget(
                          text: "Quantity",
                          color: color,
                          textSize: 22,
                          isTitle: false,
                        ),
                        const SizedBox(
                          width: 10,
                        ),*/
                            quantityControl(
                              fct: () {
                                if(_quantityTextController.text == "1") {
                                  return;
                                }else{
                                  setState(() {
                                    _quantityTextController.text =
                                        (int.parse(_quantityTextController.text) -1).toString();
                                  });
                                }

                              }, //for quantity control
                              icon: CupertinoIcons.minus,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                controller: _quantityTextController,
                                key: const ValueKey('quantity'),
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                ),
                                textAlign: TextAlign.center,
                                cursorColor: Colors.blue,
                                enabled: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    if (value.isEmpty) {
                                      _quantityTextController.text = '1';
                                    } else {}
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            quantityControl(
                              fct: () {
                                setState(() {
                                  _quantityTextController.text = (int.parse(_quantityTextController.text) +1).toString();
                                });
                              },
                              icon: CupertinoIcons.plus,
                              color: Colors.cyan,
                            ),
                          ],
                        ),
                        const Spacer(), //to push the last widget end of the screen
                        Container(
                          width: double.infinity, //size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Row(
                                        children: [
                                          TextWidget(
                                            text: "Total:",
                                            color: Colors.red.shade300,
                                            textSize: 22,
                                            isTitle: true,
                                          ),
                                          const SizedBox(width: 10,),
                                          TextWidget(
                                            text: "${totalPrice.toStringAsFixed(2)}₺",
                                            color: color,
                                            textSize: 20,
                                            isTitle: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextWidget(
                                      text: "Quantity : ${_quantityTextController.text}",
                                      color: color,
                                      textSize: 20,
                                      isTitle: true,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Material(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                    onTap: _isInCart
                                        ? null
                                        : () async{
                                      final User? user = authInstance.currentUser;
                                      if(user == null) {
                                        GlobalMethods.errorDialog(
                                            error: "You need to login first!",
                                            context: context);
                                        return;
                                      }
                                      await GlobalMethods.addToCart(
                                              productId: getCurrentProduct.id,
                                              quantity: int.parse(_quantityTextController.text),
                                              context: context);
                                      await cartProvider.fetchCart();
                                      /*cartProvider.addProductsToCart(
                                          productId: getCurrentProduct.id,
                                          quantity: int.parse(_quantityTextController.text));*/
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: TextWidget(
                                            text: _isInCart ? "In Cart" : "Add to cart",
                                            color: Colors.white,
                                            textSize: 18)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]
          ),
        ),
    );
  }

  Widget quantityControl(
      {required Function fct, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: color,
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            )),
      ),
    );
  }
}