import 'package:flutter/material.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white, // blue
      child: InkWell(
        onTap: () {},
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/google1.png',
              width: 40.0,
            ),
          ),
          const SizedBox(
            width: 55,
          ),
          TextWidget(
              isTitle: true,
              text: 'Sign in with Google',
              color: Colors.black,
              textSize: 18)
        ]),
      ),
    );
  }
}