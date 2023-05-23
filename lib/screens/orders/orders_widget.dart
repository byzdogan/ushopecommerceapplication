import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/inner_screens/product_details.dart';
import 'package:ushopecommerceapplication/models/orders_model.dart';
import 'package:ushopecommerceapplication/providers/products_provider.dart';
import 'package:ushopecommerceapplication/screens/orders/orders_screen.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;
  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrderModel>(context);
    var orderDate = ordersModel.orderDate.toDate();
    orderDateToShow = "${orderDate.day}/${orderDate.month}/${orderDate.year}";
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrderModel>(context);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct = productProvider.findProdById(ordersModel.productId);
    return ListTile(
      onTap: () {
      },
      leading:  FancyShimmerImage(
        height: size.width * 0.27,
        width: size.width * 0.24,//width: size.width * 0.2,
        imageUrl: getCurrentProduct.imageUrl,//ordersModel.imageUrl,
        boxFit: BoxFit.fill,
      ),

      title: TextWidget(
          isTitle: true,
          text: "${getCurrentProduct.title} x ${ordersModel.quantity}", //Title  x12
          color: color,
          textSize: 20),

      subtitle: TextWidget(
        isTitle: false,
        text: "Paid: ${double.parse(ordersModel.price).toStringAsFixed(2)}₺", //const Text("Paid: 200₺"), ${double.parse(ordersModel.price).toStringAsFixed(2)}₺ '${getCurrProduct.title}  x${ordersModel.quantity}',
        color: color,
        textSize: 18),

      trailing: TextWidget(
          text: orderDateToShow,
          color: color,
          textSize: 18),
    );
  }
}