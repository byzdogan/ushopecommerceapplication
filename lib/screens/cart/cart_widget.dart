import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ushopecommerceapplication/inner_screens/product_details.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/heart_btn.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = "1";
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;

    return GestureDetector(
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context,
            routeName: ProductDetails.routeName);
      },
      child: Row(
        children: [
          Expanded(//to make the container fit the whole width
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container( //to specify the color of each item
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 30,),
                    Container(
                      height: size.width*0.25,
                      width: size.width*0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: FancyShimmerImage(
                        imageUrl: "https://cdn.dsmcdn.com/ty644/product/media/images/20221213/11/235843656/154436277/1/1_org_zoom.jpg",
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: 'Title',
                          textSize: 22,
                          color: color,
                          isTitle: true,
                        ),
                        const SizedBox(height: 16.0,),
                        SizedBox(
                          width: size.width * 0.33,
                          child: Row(
                            children: [
                              _quantityController(
                                  fct: () {},
                                  icon: CupertinoIcons.minus,
                                  color: Colors.redAccent),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),),),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"),
                                    ),
                                  ],
                                  onChanged: (v) {
                                    setState(() {
                                      if (v.isEmpty) {
                                        _quantityTextController.text = '1';
                                      } else {
                                        return;
                                      }
                                    });
                                  },
                                ),
                              ),
                              _quantityController(
                                fct: () {},
                                icon: CupertinoIcons.plus,
                                color: Colors.cyan,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //const Spacer(),
                    const SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const HeartBTN(),
                              const SizedBox(width: 10,),
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  CupertinoIcons.cart_badge_minus,
                                  color: Colors.redAccent,
                                  size: 26,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          TextWidget(
                            text: "100₺",
                            color: color,
                            textSize: 20,
                            maxLines: 1,
                            isTitle: true,
                          ),
                        ],
                      ),
                    ),
                    //const SizedBox(width: 5,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _quantityController ({
    required Function fct,
    required IconData icon,
    required Color color,
}) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.black,
                size: 20,
                //color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
