import 'package:flutter/material.dart';
import 'package:ushopecommerceapplication/services/utils.dart';

class EmptyProductsWidget extends StatelessWidget {
  const EmptyProductsWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                "assets/images/empty_screens/box.png",),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
