import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/provider/dark_theme_provider.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
                      subtitle: "Enter your adress",
                      icon: IconlyLight.location,
                      onPressed: (){},
                      color: color,),
                    _listTiles(
                      title: "Orders",
                      icon: IconlyLight.bag,
                      onPressed: (){},
                      color: color,),
                    _listTiles(
                      title: "Wish List",
                      icon: IconlyLight.heart,
                      onPressed: (){},
                      color: color,),
                    _listTiles(
                      title: "Forget password",
                      icon: IconlyLight.unlock,
                      onPressed: (){},
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
                    _listTiles(
                      title: "Logout",
                      icon: IconlyLight.logout,
                      onPressed: (){},
                      color: color,),
                  ],
                ),
            ),
          ),
        ),
    );
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
