import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/heart_btn.dart';
import 'package:ushopecommerceapplication/widgets/price_widget.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';


class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

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
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children:[
                FancyShimmerImage(
                  imageUrl: "https://cdn.dsmcdn.com/ty644/product/media/images/20221213/11/235843656/154436277/1/1_org_zoom.jpg",
                  height: size.width*0.21,
                  width: size.width*0.2,
                  boxFit: BoxFit.fill,
                ),
                const SizedBox(height: 5,),
                TextWidget(
                  text: "Title",
                  color: color,
                  textSize: 20,
                  isTitle: true,
                ),
                const SizedBox(height: 5,),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        //vertical: 10
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const PriceWidget(),
                      const HeartBTN(),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              FittedBox(
                                child: TextWidget(
                                  text: "Quantity:",
                                  color: color,
                                  textSize: 20,
                                  isTitle: true,
                                ),
                              ),
                              Flexible(
                                child: TextFormField(
                                  controller: _quantityTextController,
                                  key: const ValueKey("10"),
                                  style: TextStyle(color: color, fontSize: 18,),
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  //cursorColor: Colors.green,
                                  enabled: true,
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
                      onPressed: () {},
                      child: TextWidget(
                        text: "Add to cart",
                        maxLines: 1,
                        color: color,
                        textSize: 20,
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

              ],),
          ),
        ),
    );
  }
}
