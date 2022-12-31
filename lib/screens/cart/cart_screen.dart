import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:ushopecommerceapplication/screens/cart/cart_widget.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Cart',
          textSize: 22,
          isTitle: true,
          color: color,),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                IconlyLight.delete, //IconlyBroken.delete,
                color: color,
              ))
        ],
      ),
      body: Column( //A listview that wrapped by column need a size or you can wrap it with an expanded widget
        children: [
          _checkout(ctx: context),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, index){
                return CartWidget();
              }),),
        ],
      ),
    );
  }

  Widget _checkout({required BuildContext ctx}) {
    final Color color = Utils(ctx).color;
    Size size = Utils(ctx).getScreenSize;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      //color: ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), //10
        child: Row(
          children: [
            Material(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: "ORDER NOW",
                    textSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
            FittedBox(
              child: TextWidget(
                text: "Total: 1000₺",
                color: color,
                textSize: 20,
                isTitle: true,),),
          ],
        ),
      ),
    );
  }
}