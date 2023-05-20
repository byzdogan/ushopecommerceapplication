import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/const/contss.dart';
import 'package:ushopecommerceapplication/inner_screens/feed_screens.dart';
import 'package:ushopecommerceapplication/inner_screens/on_sale_screen.dart';
import 'package:ushopecommerceapplication/models/products_model.dart';
import 'package:ushopecommerceapplication/providers/dark_theme_provider.dart';
import 'package:ushopecommerceapplication/providers/products_provider.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/feed_items.dart';
import 'package:ushopecommerceapplication/widgets/on_sale_widget.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final size = utils.getScreenSize;
    final Color color = Utils(context).color;

    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [SizedBox(
            height: size.height * 0.28, //0.33
            child: Swiper(
              itemBuilder: (BuildContext context,int index){
                return Image.asset(
                  Constss.offerImages[index],
                  fit: BoxFit.fill,);
              },
              autoplay: true,
              itemCount: Constss.offerImages.length,
              pagination: const SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                  color: Colors.white,
                  activeColor: Colors.cyan,),
              ),
             control: const SwiperControl(color: Colors.cyan), //resim kenarlarında ok
            ),
          ),
            /*const SizedBox(
              height: 2, //6
            ),*/
            TextButton(
              onPressed: () {
                GlobalMethods.navigateTo(
                    ctx: context, routeName: OnSaleScreen.routeName);
              },
              child: TextWidget(
                text: "View All",
                textSize: 20,
                maxLines: 1,
                color: Colors.cyan,
                isTitle: true,
              ),
            ),
            /*const SizedBox(
              height: 1, //6
            ),*/
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
                    height: size.height*0.24, //0.24 //0,21
                    child: ListView.builder(
                      itemCount: productsOnSale.length < 10
                          ? productsOnSale.length
                          : 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return ChangeNotifierProvider.value(
                          value: productsOnSale[index],
                          child: const OnSaleWidget(),
                        ) ;
                      },
                    ),
                  ),
                ),
              ],
            ),
            //const SizedBox(height: 1,), //10
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Our Products",
                    color: color,
                    textSize: 22,
                    isTitle: true,),
                  //const Spacer(),
                  TextButton(
                    onPressed: () {
                      GlobalMethods.navigateTo(ctx: context, routeName: FeedsScreen.routeName);
                    },
                    child: TextWidget(
                      text: "Browse all",
                      textSize: 20,
                      maxLines: 1,
                      color: Colors.cyan,
                      isTitle: true,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true, //
              physics: const NeverScrollableScrollPhysics(), //not be scrollable anymore
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              crossAxisSpacing: 10,
              childAspectRatio: size.width / (size.height * 0.78), //0.59 //0.65
              children: List.generate(
                  allProducts.length < 4
                      ? allProducts.length // length 3
                      : 4, (index) {
                return ChangeNotifierProvider.value(
                  value: allProducts[index],
                  child: const FeedsWidget(),
                ) ;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
