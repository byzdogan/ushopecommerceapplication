import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:ushopecommerceapplication/inner_screens/feed_screens.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/back_widget.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {Key? key,
        required this.imagePath,
        required this.title,
        required this.subtitle,
        required this.buttonText})
      : super(key: key);
  final String imagePath, title, subtitle, buttonText;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackWidget(),
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        title: TextWidget(
          text: "Go back",
          textSize: 22,
          isTitle: false,
          color: color,),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*SizedBox(
                      height: size.height * 0.1,
                  ),*/
                  Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: size.height * 0.4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Whoops!',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 40,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                      text: title,
                      color: Colors.cyan,
                      textSize: 20),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                      text: subtitle,
                      color: Colors.cyan,
                      textSize: 18),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0), //8.0
                        side: BorderSide(
                          color: color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      // onPrimary: color,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    ),
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: FeedsScreen.routeName);
                    },
                    child: TextWidget(
                      text: buttonText,
                      textSize: 20,
                      color:
                      themeState ? Colors.grey.shade300 : Colors.grey.shade800,
                      isTitle: true,
                    ),
                  ),
                ]),
          )),
    );
  }
}
