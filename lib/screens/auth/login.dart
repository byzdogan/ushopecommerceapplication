import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ushopecommerceapplication/const/contss.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/fetch_screen.dart';
import 'package:ushopecommerceapplication/inner_screens/on_sale_screen.dart';
import 'package:ushopecommerceapplication/screens/auth/forget_pass.dart';
import 'package:ushopecommerceapplication/screens/auth/register.dart';
import 'package:ushopecommerceapplication/screens/btm_bar.dart';
import 'package:ushopecommerceapplication/screens/categories.dart';
import 'package:ushopecommerceapplication/screens/home_screen.dart';
import 'package:ushopecommerceapplication/screens/loading_manager.dart';
import 'package:ushopecommerceapplication/screens/user.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/widgets/auth_button.dart';
import 'package:ushopecommerceapplication/widgets/google_button.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
  /*void _submitFormOnLogin() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      print("The form is valid");
    }
  }*/

  bool _isLoading = false;
  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    /*setState(() {
      _isLoading = true;
    });*/
    if (isValid) {
      _formKey.currentState!.save(); //set statei buraya koymuş normalde üstteydi
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.signInWithEmailAndPassword(
          email: _emailTextController.text.toLowerCase().trim(), //trim is for removing spaces
          password: _passwordTextController.text.trim(),);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context)=> const FetchScreen(),
        ));
        print("Succesfully logged in!");
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            error: "${error.message}",
            context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(
            error: "$error",
            context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(children: [
          Swiper(
            duration: 800, //miliseconds
            autoplayDelay: 6000,
            itemBuilder: (BuildContext context,int index){
              return Image.asset(
                Constss.authImagePaths[index],
                fit: BoxFit.cover,);
            },
            autoplay: true,
            itemCount: Constss.offerImages.length,
            /*pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                color: Colors.white,
                activeColor: Colors.cyan,),
            ),*///control: const SwiperControl(color: Colors.blue), //resim kenarlarında ok
          ),
          Container(
            color: Colors.black.withOpacity(0.5), //0.7
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 120.0,
                  ),
                  TextWidget(
                    text: "Welcome to USHOP",
                    color: Colors.cyan,
                    textSize: 30,
                    isTitle: true,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextWidget(
                    text: "Sign in to continue",
                    color: Colors.white70,
                    textSize: 18,
                    isTitle: false,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        //Password

                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            _submitFormOnLogin();
                          },
                          controller: _passwordTextController,
                          focusNode: _passwordFocusNode,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return "Password has to more than 7 characters";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                )),
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white,),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ],

                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                        ctx: context,
                        routeName: ForgetPasswordScreen.routeName);
                            },
                      child: const Text(
                        'Forget password?',
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.cyan,
                            fontSize: 18,
                            fontWeight: FontWeight.w700 ,
                            fontStyle: FontStyle.normal,
                          //decoration: TextDecoration.underline,
                          ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthButton(
                    fct: _submitFormOnLogin,
                    buttonText: 'Login',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GoogleButton(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row( //OR satırı için
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextWidget(
                        text: 'OR',
                        color: Colors.white,
                        textSize: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthButton(
                    fct: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (ctx) => const FetchScreen(),
                      ));
                    },
                    buttonText: "Continue as a guest",
                    primary: Colors.black87,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "           Don\'t have an account?",
                          style:
                          const TextStyle(color: Colors.white, fontSize: 18),
                          children: [
                            TextSpan(
                                text: "  Sign up",
                                style: const TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  GlobalMethods.navigateTo(
                                      ctx: context,
                                      routeName: RegisterScreen.routeName);
                                }
                                ),
                          ]
                      )
                  )
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
