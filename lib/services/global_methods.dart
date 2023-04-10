import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/screens/auth/login.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';
import 'package:uuid/uuid.dart';
class GlobalMethods {
  static navigateTo({required BuildContext ctx, required String routeName}){
    Navigator.pushNamed(ctx, routeName);
  }

  static Future<void> warningDialog(
    {
      required String title,
      required String subtitle,
      required Function fct,
      required BuildContext context,
    }
  ) async{
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(children: [
                Image.asset("assets/images/warning-sign.png",
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,),
                const SizedBox(width: 10),
                Text(title)
              ]),
              content: Text(subtitle),
              actions: [
                TextButton(
                  onPressed: (){
                    if(Navigator.canPop(context)){
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    color:  Colors.cyan,
                    text: "Cancel",
                    textSize: 18,
                  ),),
                TextButton(onPressed: (){
                  fct();
                  if(Navigator.canPop(context)){
                  Navigator.pop(context);
                  }
                  },
                  child: TextWidget(
                    color:  Colors.redAccent,
                    text: "OK",
                    textSize: 18,
                  ),
                ),
              ]
          );
        }
        );
  }

  static Future<void> errorDialog(
      {
        required String error,
        required BuildContext context,
      }
      ) async{
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(children: [
                Image.asset("assets/images/warning-sign.png",
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,),
                const SizedBox(width: 10),
                const Text("An error is occured!")
              ]),
              content: Text(error),
              actions: [
                TextButton(
                  onPressed: (){
                    if(Navigator.canPop(context)){
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    color:  Colors.cyan,
                    text: "OK",
                    textSize: 18,
                  ),
                ),
              ]
          );
        }
    );
  }

  static Future<void> informDialog(
      {
        required String subtitle,
        required Function fct,
        required BuildContext context,
      }
      ) async{
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
             backgroundColor: Colors.cyan.withOpacity(0.6),
              content: TextWidget(
                color:  Colors.white,
                text: subtitle,
                textSize: 18,
              ),
              actions: [
                TextButton(
                  onPressed: (){
                    fct();
                  },
                  child: TextWidget(
                    color:  Colors.white,
                    text: "OK",
                    textSize: 18,
                  ),),
              ]
          );
        }
    );
  }

  static Future<void> addToCart({
    required String productId,
    required int quantity,
    required BuildContext context,
  }) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final cartId = Uuid().v4();
    try{
      FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            "cartId": cartId,
            "productId": productId,
            "quantity": quantity,
          }
        ])
      });
      await Fluttertoast.showToast(
          msg: "The product has been added to your cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
      );
    }catch (error){
      errorDialog(
          error: error.toString(),
          context: context);
    }
  }

  static Future<void> addToWishlist({
    required String productId,
    required BuildContext context,
  }) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final wishlistId = Uuid().v4();
    try{
      FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            "wishlistId": wishlistId,
            "productId": productId,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "The product has been added to your wishlist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }catch (error){
      errorDialog(
          error: error.toString(),
          context: context);
    }
  }


}