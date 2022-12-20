import 'package:flutter/material.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return FittedBox(


      child: Row(
        children: [
          TextWidget(
            text: "200 ₺",
            color: Colors.green,
            textSize: 22,),
          SizedBox(

            width: 5,
          ),
          Text(
            "250",
            style: TextStyle(
              fontSize: 15,
              color: color,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ) ,
    );
  }
}