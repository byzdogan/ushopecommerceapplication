import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/fetch_screen.dart';
import 'package:ushopecommerceapplication/providers/cart_provider.dart';
import 'package:ushopecommerceapplication/providers/orders_provider.dart';
import 'package:ushopecommerceapplication/providers/wishlist_provider.dart';
import 'package:ushopecommerceapplication/screens/btm_bar.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({Key? key}) : super(key: key);

  //bool _isLoading = false;
  Future<void> _googleSignIn(context) async{
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if(googleAccount != null){
      final googleAuth = await googleAccount.authentication;
      if(googleAuth.accessToken != null && googleAuth.idToken != null){
        try{//credential is acces token and id token
          final authResult = await authInstance.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,));
          if(authResult.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(authResult.user!.uid)
                .set({
              'id': authResult.user!.uid,
              'name': authResult.user!.displayName,
              'email': authResult.user!.email,
              'shipping-address': "",
              'userWish': [],
              'userCart': [],
              'createdAt': Timestamp.now(),
            });
          }
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context)=> const FetchScreen(),
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
              'assets/images/auth_photos/google1.png',
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