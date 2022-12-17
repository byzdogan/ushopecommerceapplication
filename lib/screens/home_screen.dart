import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/provider/dark_theme_provider.dart';
import 'package:ushopecommerceapplication/services/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> _offerImages = [
    "assets/images/offers/uufoto3.png",
    "assets/images/offers/uufoto1.jpeg",
    "assets/images/offers/uufoto2.jpeg",
  ];
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final size = utils.getScreenSize;

    return Scaffold(
      body: SizedBox(
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
      )
    );
  }
}
