import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:ushopecommerceapplication/services/utils.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        IconlyLight.arrow_left,
        color: color,
      ),
    );
  }
}
