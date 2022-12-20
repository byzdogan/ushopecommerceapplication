import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/provider/dark_theme_provider.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/on_sale_widget.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> _offerImages = [
    "assets/images/offers/uufoto3.jpeg",
    "assets/images/offers/uufoto1.jpeg",
    "assets/images/offers/uufoto2.jpeg",
  ];
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final size = utils.getScreenSize;

    return Scaffold(
      body: Column(
        children: [SizedBox(
          height: size.height * 0.33,
          child: Swiper(
            itemBuilder: (BuildContext context,int index){
              return Image.asset(
                _offerImages[index],
                fit: BoxFit.fill,);
            },
            autoplay: true,
            itemCount: _offerImages.length,
            pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                color: Colors.white,
                activeColor: Colors.cyan,),
            ),
            //control: const SwiperControl(color: Colors.blue), //resim kenarlarında ok
          ),
        ),
          const SizedBox(
            height: 4, //6
          ),
          TextButton(onPressed: () {
            print("View All button iis pressed");
          },
            child: TextWidget(
              text: "View All",
              textSize: 20,
              maxLines: 1,
              color: Colors.cyan,
            ),
          ),
          const SizedBox(
            height: 4, //6
          ),
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              RotatedBox(
                quarterTurns: -1,
                child: Row(
                  children: [
                    TextWidget(
                      text: "On Sale".toUpperCase(),
                      color: Colors.redAccent,
                      textSize: 22,
                      isTitle: true,),
                    const Icon(
                      IconlyLight.discount,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Flexible(
                child: SizedBox(
                  height: size.height*0.21, //0.24
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return const OnSaleWidget();
                    },
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}
