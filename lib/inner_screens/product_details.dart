import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/widgets/heart_btn.dart';
import '../services/global_methods.dart';
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

    return Scaffold(
        appBar: AppBar(
            leading: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () =>
              Navigator.canPop(context) ? Navigator.pop(context) : null,
              child: Icon(
                IconlyLight.arrow_left_2,
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
              imageUrl: "https://cdn.dsmcdn.com/ty644/product/media/images/20221213/11/235843656/154436277/1/1_org_zoom.jpg",
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
                            text: "title",
                            color: color,
                            textSize: 25,
                            isTitle: true,
                          ),
                        ),
                        const HeartBTN(),
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
                          text: "200₺",
                          color: Colors.green,
                          textSize: 25,
                          isTitle: true,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Visibility(
                          visible: true,
                          child: Text(
                            "250₺",
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
                        fct: () {}, //for quantity control
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
                        fct: () {},
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
                                      text: 'Total',
                                      color: Colors.red.shade300,
                                      textSize: 22,
                                      isTitle: true,
                                    ),
                                    const SizedBox(width: 10,),
                                    TextWidget(
                                      text: "200₺",
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
                                text: "Quantity : 1",
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
                              onTap: () {},
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextWidget(
                                      text: "Add to cart",
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
        ]),
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