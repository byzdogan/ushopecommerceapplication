import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/providers/dark_theme_provider.dart';
import 'package:ushopecommerceapplication/providers/cart_provider.dart';
import 'package:ushopecommerceapplication/screens/cart/cart_screen.dart';
import 'package:ushopecommerceapplication/screens/categories.dart';
import 'package:ushopecommerceapplication/screens/home_screen.dart';
import 'package:ushopecommerceapplication/screens/user.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';


class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0; //HomeScreen main page olduğu için
  final List _pages = [
    const HomeScreen(),
    CategoriesScreen(),
    const CartScreen(),
    const UserScreen(),
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
}

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    //final cartProvider = Provider.of<CartProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.cyan[50], //bottomBar arka plan rengi
        type: BottomNavigationBarType.fixed, //bottomBar sabitleme
        showSelectedLabels: false, //selected label hide
        showUnselectedLabels: false, //unselected hide
        currentIndex: _selectedIndex,
        unselectedItemColor: _isDark ? Colors.white : Colors.black,
        selectedItemColor: _isDark ? Colors.cyan : Colors.cyan, //left for dartTheme
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1 ? IconlyBold.category : IconlyLight.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Consumer<CartProvider>(
              builder: (_, myCart, ch) {
                return Badge(
                  toAnimate: true,
                  shape: BadgeShape.circle,
                  badgeColor: Colors.cyan,
                  borderRadius: BorderRadius.circular(8),
                  position: BadgePosition.topEnd(top: -12, end: -10),
                  badgeContent: FittedBox(
                      child: TextWidget(
                          text: myCart.getCartItems.length.toString(),
                          color: Colors.white,
                          textSize: 15)
                  ),
                  child: Icon(
                      _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),);
              }
            ),

            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 3 ? IconlyBold.profile : IconlyLight.profile),
            label: "User",
          ),
        ],
      ),
    );
  }
}
