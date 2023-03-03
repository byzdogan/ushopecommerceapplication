import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/provider/dark_theme_provider.dart';
import 'package:ushopecommerceapplication/screens/auth/forget_pass.dart';
import 'package:ushopecommerceapplication/screens/auth/login.dart';
import 'package:ushopecommerceapplication/screens/orders/orders_screen.dart';
import 'package:ushopecommerceapplication/screens/viewed_recently/viewed_recently.dart';
import 'package:ushopecommerceapplication/screens/wishlist/wishlist_screen.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _adressTextController = TextEditingController(text: "");
  @override
  void dispose() {
    _adressTextController.dispose();
    super.dispose();
  }

  final User? user = authInstance.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    RichText(
                        text: TextSpan(
                        text: "Hi,  ",
                        style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "MyName",
                              style: TextStyle(
                                color: color,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                    ),
                    const SizedBox(height: 10),
                    TextWidget(
                      text: "email@email.com",
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(height: 20),
                    const Divider(thickness: 2),
                    const SizedBox(height: 20),
                    _listTiles(
                      title: "Adress",
                      icon: IconlyLight.location,
                      onPressed: () async{
                        await _showAdressDialog();
                      },
                      color: color,
                    ),
                    _listTiles(
                      title: "Orders",
                      icon: IconlyLight.bag,
                      onPressed: (){
                        GlobalMethods.navigateTo(ctx: context, routeName: OrdersScreen.routeName);
                      },
                      color: color,),
                    _listTiles(
                      title: "Wish List",
                      icon: IconlyLight.heart,
                      onPressed: (){
                        GlobalMethods.navigateTo(ctx: context, routeName: WishlistScreen.routeName);
                      },
                      color: color,),
                    _listTiles(
                      title: "Viewed",
                      icon: IconlyLight.time_circle,
                      onPressed: (){
                        GlobalMethods.navigateTo(ctx: context, routeName: ViewedRecentlyScreen.routeName);
                      },
                      color: color,),
                    _listTiles(
                      title: "Forget password",
                      icon: IconlyLight.unlock,
                      onPressed: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context)=> const ForgetPasswordScreen(),
                        ));
                      },
                      color: color,),
                    SwitchListTile(
                      title: TextWidget(
                        text: themeState.getDarkTheme ? "Dark mode" : "Light mode",
                        color: color,
                        textSize: 22,
                        isTitle: true,
                      ),
                      secondary: Icon(themeState.getDarkTheme
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined),
                      onChanged: (bool value){
                        setState(() {
                          themeState.setDarkTheme = value;
                        });
                        },
                      value: themeState.getDarkTheme,
                    ),
                    const SizedBox(height: 20),
                    _listTiles(
                      title: user == null ? "Login" : "Logout",
                      icon: user == null ? IconlyLight.login : IconlyLight.logout,
                      onPressed: (){
                        if(user == null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()
                          ),);
                          return;
                        }
                       GlobalMethods.warningDialog(
                           title: "Sign Out",
                           subtitle: "Do you want to sign out?",
                           fct: () async{
                             await authInstance.signOut();
                             Navigator.of(context).push(MaterialPageRoute(
                                 builder: (context) => const LoginScreen()
                             ),);
                           },
                           context: context);
                      },
                      color: color,),
                  ],
                ),
            ),
          ),
        ),
    );
  }



  Future<void> _showAdressDialog() async{
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update your adress"),
            content: TextField(
              //onChanged: (value){
                //print('_addressTextController.text ${_addressTextController.text}');
              //},
              controller: _adressTextController,
              maxLines: 5,
              decoration:
              InputDecoration(hintText: "Please, enter your adress here."),
            ),
            actions: [
              TextButton(onPressed: () {
                if(Navigator.canPop(context)){
                  Navigator.pop(context);
                }
              },
                  child: const Text("Update"))
            ],
          );

        });
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }){
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
        isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle == null ? "" : subtitle,
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrow_right_2),
      onTap: (){
        onPressed();
      },
    );
  }
}
