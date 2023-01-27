import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:ushopecommerceapplication/inner_screens/product_details.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return ListTile(
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetails.routeName);
      },
      leading:  FancyShimmerImage(
        height: size.width * 0.27,
        width: size.width * 0.25,//width: size.width * 0.2,
        imageUrl: "https://cdn.dsmcdn.com/ty644/product/media/images/20221213/11/235843656/154436277/1/1_org_zoom.jpg",
        boxFit: BoxFit.fill,
      ),

      title: TextWidget(
          isTitle: true,
          text: "Title", //Title  x12
          color: color,
          textSize: 20),

      subtitle: TextWidget(
        isTitle: false,
        text: "Paid: 200₺", //const Text("Paid: 200₺"),
        color: color,
        textSize: 18),

      trailing: TextWidget(
          text: "27/01/2023",
          color: color,
          textSize: 18),
    );
  }
}