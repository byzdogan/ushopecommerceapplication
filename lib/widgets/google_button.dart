import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/screens/btm_bar.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({Key? key}) : super(key: key);

  bool _isLoading = false;
  Future<void> _googleSignIn(context) async{
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if(googleAccount != null){
      final googleAuth = await googleAccount.authentication;
      if(googleAuth.accessToken != null && googleAuth.idToken != null){
        try{//credential is acces token and id token
          await authInstance.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,));
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context)=> const BottomBarScreen(),
          ));
        }on FirebaseException catch (error){
          GlobalMethods.errorDialog(
              error: "${error.message}",
              context: context);
        }catch(error){
          GlobalMethods.errorDialog(
              error: "$error",
              context: context);
        }finally{
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white, // blue
      child: InkWell(
        onTap: () {
          _googleSignIn(context);
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/google1.png',
              width: 40.0,
            ),
          ),
          const SizedBox(
            width: 55,
          ),
          TextWidget(
              isTitle: true,
              text: 'Sign in with Google',
              color: Colors.black,
              textSize: 18)
        ]),
      ),
    );
  }
}