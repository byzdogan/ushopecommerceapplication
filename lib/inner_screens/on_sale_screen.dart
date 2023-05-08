import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/models/products_model.dart';
import 'package:ushopecommerceapplication/providers/products_provider.dart';
import 'package:ushopecommerceapplication/widgets/back_widget.dart';
import 'package:ushopecommerceapplication/widgets/empty_products_widget.dart';
import 'package:ushopecommerceapplication/widgets/on_sale_widget.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

import '../services/utils.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //bool _isEmpty = false; //true olduğu zaman product yok ekranı çıkar
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
        leading: BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Products on sale',
          color: color,
          textSize: 24.0,
          isTitle: true,
        ),
      ),
      body: productsOnSale.isEmpty//_isEmpty
          ? const EmptyProductsWidget(
        text: "No products on sale yet!\nStay tuned!")
          : GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.zero,
        // crossAxisSpacing: 10,
        childAspectRatio: size.width / (size.height * 0.5), //0.47
        children: List.generate(productsOnSale.length, (index) {
          return ChangeNotifierProvider.value(
            value: productsOnSale[index],
            child: const OnSaleWidget(),
          ) ;
        }),
      ),
    );
  }
}
