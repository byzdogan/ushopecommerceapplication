import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/models/orders_model.dart';

class OrdersProvider with ChangeNotifier {

  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders { //for accessing to ChangeNotifier
    return _orders;
  }

  Future<void> fetchOrders() async {
    User? user = authInstance.currentUser;
    await FirebaseFirestore.instance
        .collection("orders")
        .where("userId", isEqualTo: user!.uid,)
        .get()
        .then((QuerySnapshot orderSnapshot) {
      _orders = []; //_orders.clear();
      orderSnapshot.docs.forEach((element) {
        _orders.insert(
            0,
            OrderModel(
                orderId: element.get("orderId"),
                userId: element.get("userId"),
                productId: element.get("productId"),
                userName: element.get("userName"),
                price: element.get("price").toString(),
                imageUrl: element.get("imageUrl"),
                quantity:element.get("quantity").toString(),
                orderDate: element.get("orderDate"),)
        );
      });
    }); // tüm ürünleri göstermek istediğimiz için id eklemedik kullanıcada öyle değildi.
    notifyListeners();
  }

  void clearLocalOrders() {
    _orders.clear();
    notifyListeners();
  }
}