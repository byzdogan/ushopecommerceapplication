import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/providers/cart_provider.dart';
import 'package:ushopecommerceapplication/providers/orders_provider.dart';
import 'package:ushopecommerceapplication/providers/products_provider.dart';
import 'package:ushopecommerceapplication/providers/viewed_provider.dart';
import 'package:ushopecommerceapplication/providers/wishlist_provider.dart';
import 'package:ushopecommerceapplication/screens/btm_bar.dart';
import 'package:ushopecommerceapplication/services/utils.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 3), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider =
          Provider.of<CartProvider>(context, listen: false);
      final wishlistProvider =
      Provider.of<WishlistProvider>(context, listen: false);
      final orderProvider =
      Provider.of<OrdersProvider>(context, listen: false);
      final viewedProvider =
      Provider.of<ViewedProductProvider>(context, listen:false);

      final User? user = authInstance.currentUser;
      if(user == null){
        await productsProvider.fetchProducts();
        cartProvider.clearLocalCart();
        wishlistProvider.clearLocalWishlist();
        orderProvider.clearLocalOrders();
        viewedProvider.clearHistory();
      }
      else{
        cartProvider.clearLocalCart();
        wishlistProvider.clearLocalWishlist();
        orderProvider.clearLocalOrders();
        viewedProvider.clearHistory();
        await productsProvider.fetchProducts();
        await  cartProvider.fetchCart();
        await wishlistProvider.fetchWishlist();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => const BottomBarScreen(),
      ));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/ushoplogo.png',
              fit: BoxFit.fitWidth,
              height: size.width ,
            ),
          ),
          /*const Center(
            child: SpinKitCircle(
              color: Colors.cyan,
            ),
          )*/
        ],
      ),
    );
  }
}
