import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: "https://cdn.dsmcdn.com/ty644/product/media/images/20221213/11/235843656/154436277/1/1_org_zoom.jpg",
                      height: size.width*0.22,
                      width: size.width*0.22,
                      boxFit: BoxFit.fill,
                    ),
                    Column(children: [
                      //TextWidget(text: '', color: color, textSize: 22, isTitle: true,),
                      //const SizedBox(height: 6,),
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            print("add to cart is pressed");
                          },
                          child: Icon(
                            IconlyLight.bag,
                            size: 22,
                            color: color,
                          ),
                        ),
                        HeartBTN(),
                        //const PriceWidget(),
                      ],
                      ),
                    ],
                    ),
                  ],
                ),
                const PriceWidget(),
                const SizedBox(

                  height: 5,),
                TextWidget(
                  text: "Sweatshirt",
                  color: color,
                  textSize: 16,
                  isTitle: true,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}