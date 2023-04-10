import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  /*void addProductsToCart({
    required String productId,
    required int quantity,
  }) {
    _cartItems.putIfAbsent(
        productId,
            () => CartModel(
          id: DateTime.now().toString(),
          productId: productId,
          quantity: quantity,
        ));
    notifyListeners();
  }*/

  /*if(_cartItems.containsKey(productId)){
      removeOneItem(productId);
    }else{ butona bastığında sepetten çıkması için ama Add Cart buttonda işe yaramıyor feed_itemse gidip değiştirmek gerek*/

  Future<void> fetchCart()async {
    final User? user = authInstance.currentUser;
    String _uid = user!.uid;

    final DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc == null) {
      return;
    }
    final leng = userDoc.get("userCart").length;
    for (int i = 0; i < leng; i++){
      _cartItems.putIfAbsent(
          userDoc.get("userCart")[i]["productId"],
              () => CartModel(
                    id: userDoc.get("userCart")[i]["cartId"],
                    productId: userDoc.get("userCart")[i]["productId"],
                    quantity: userDoc.get("userCart")[i]["quantity"],
              ));
    }
    notifyListeners();
  }

  void reduceQuantityByOne(String productId) {
    _cartItems.update(
      productId,
          (value) =>
          CartModel( //this value contains everything about the cartModel related to the this Id.
            id: value.id,
            productId: productId, //value.productId
            quantity: value.quantity - 1,
          ),
    );
    notifyListeners();
  }


  void increaseQuantityByOne(String productId) {
    _cartItems.update(
      productId,
          (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity + 1,
      ),
    );
    notifyListeners();
  }

  void removeOneItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners(); // Bu satır olmadan screen değiştirmediğim sürece silme işlemini göremem.
  }
}