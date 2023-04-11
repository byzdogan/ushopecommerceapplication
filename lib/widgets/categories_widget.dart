import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/inner_screens/category_screen.dart';
import 'package:ushopecommerceapplication/providers/dark_theme_provider.dart';
import 'package:ushopecommerceapplication/screens/categories.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key,
    required this.catText,
    required this.imgPath,
    required this.passedColor,}) : super(key: key);
  final String catText, imgPath;
  final Color passedColor;

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size; //kutu boyutunu ayarlama yöntem2
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    double _screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: (){
          Navigator.pushNamed(context, CategoryScreen.routeName,
              arguments: catText);
        },
        child:Container(
          decoration: BoxDecoration(
          color: passedColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20), //for corners
          border: Border.all(color: passedColor.withOpacity(0.9),width: 2),
          ),
          child: Column (children: [
            Container(
              height: _screenWidth*0.3,
              width: _screenWidth*0.3,
              decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(
                  imgPath,
              ),
                  fit: BoxFit.fill)),
            ),
            TextWidget(
              text: catText,
              color: color,
              textSize: 24,
              isTitle: true,
        ),
      ],),
    ),
        );

  }
}

