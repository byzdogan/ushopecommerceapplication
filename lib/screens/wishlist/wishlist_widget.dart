import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:ushopecommerceapplication/inner_screens/product_details.dart';
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
    return Padding(
        padding: const EdgeInsets.all(8.0) ,
        child: GestureDetector(
          onTap: () {
            GlobalMethods.navigateTo(ctx: context, routeName: ProductDetails.routeName);
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
                Container(
                  margin: const EdgeInsets.only(left: 8,),
                  width: size.width * 0.2,
                  height: size.width * 0.25,
                  child: FancyShimmerImage(
                    imageUrl: "https://cdn.dsmcdn.com/ty644/product/media/images/20221213/11/235843656/154436277/1/1_org_zoom.jpg",
                    boxFit: BoxFit.fill,
                  ),
                ),
                Column(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          IconButton(onPressed: () {},
                            icon: Icon (IconlyLight.bag),),
                          HeartBTN(),
                        ],
                      ),
                    ),
                    Flexible(
                        child: TextWidget(
                          text: "Title",
                          textSize: 20,
                          maxLines: 2,
                          isTitle: true,
                          color: color,)),
                    const SizedBox(height: 5,),
                    TextWidget(
                      text: "200₺",
                      textSize: 18,
                      maxLines: 1,
                      isTitle: true,
                      color: color,),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
