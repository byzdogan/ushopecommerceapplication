import 'package:flutter/material.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/categories_widget.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  List<Color> gridColors = [
    const Color(0xff0ab2b0),
    const Color(0xff808080),
    const Color(0xff808080),
    const Color(0xff0ab2b0),
  ];

  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/images/cat/clothes2.png',
      'catText': 'Clothes',
    },
    {
      'imgPath': 'assets/images/cat/accessories.png',
      'catText': 'Accessories',
    },
    {
      'imgPath': 'assets/images/cat/stationeries.png',
      'catText': 'Stationeries',
    },
    {
      'imgPath': 'assets/images/cat/other2.png',
      'catText': 'Other',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: "Categories",
          textSize: 24,
          color: color,
          isTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2, //column number
          childAspectRatio: 240/240,
          crossAxisSpacing: 10, //Vertical Spacing
          mainAxisSpacing: 10, //Horizontal Spacing
          children: List.generate(4, (index){
            return CategoriesWidget(
              catText: catInfo[index]["catText"],
              imgPath: catInfo[index]["imgPath"],
              passedColor: gridColors[index],
            );
          }),
        ),
      ),
    );
  }
}
