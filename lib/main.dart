import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/const/theme_data.dart';
import 'package:ushopecommerceapplication/inner_screens/category_screen.dart';
import 'package:ushopecommerceapplication/inner_screens/feed_screens.dart';
import 'package:ushopecommerceapplication/inner_screens/on_sale_screen.dart';
import 'package:ushopecommerceapplication/inner_screens/product_details.dart';
import 'package:ushopecommerceapplication/models/products_model.dart';
import 'package:ushopecommerceapplication/provider/dark_theme_provider.dart';
import 'package:ushopecommerceapplication/providers/cart_provider.dart';
import 'package:ushopecommerceapplication/providers/products_provider.dart';
import 'package:ushopecommerceapplication/providers/viewed_provider.dart';
import 'package:ushopecommerceapplication/providers/wishlist_provider.dart';
import 'package:ushopecommerceapplication/screens/auth/forget_pass.dart';
import 'package:ushopecommerceapplication/screens/auth/login.dart';
import 'package:ushopecommerceapplication/screens/auth/register.dart';
import 'package:ushopecommerceapplication/screens/orders/orders_screen.dart';
import 'package:ushopecommerceapplication/screens/viewed_recently/viewed_recently.dart';
import 'package:ushopecommerceapplication/screens/wishlist/wishlist_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_){
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewedProductProvider(),
        ),
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const LoginScreen(), //BottomBarScreen()
              routes: {
            OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
            FeedsScreen.routeName: (ctx) => const FeedsScreen(),
            ProductDetails.routeName: (ctx) => const ProductDetails(),
            WishlistScreen.routeName: (ctx) => const WishlistScreen(),
            OrdersScreen.routeName: (ctx) => const OrdersScreen(),
            ViewedRecentlyScreen.routeName: (ctx) => const ViewedRecentlyScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            RegisterScreen.routeName: (ctx) => const RegisterScreen(),
            ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),
            CategoryScreen.routeName: (ctx) => const CategoryScreen(),
              }
          );
      }
      ),
    );
  }
}




