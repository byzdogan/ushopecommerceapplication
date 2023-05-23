import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ushopecommerceapplication/const/firebase_const.dart';
import 'package:ushopecommerceapplication/models/orders_model.dart';

class OrdersProvider with ChangeNotifier {
/*Map<String, OrderModel> _orders = {};
  Map<String, OrderModel> get getOrders {
    return _orders;
  }*/
  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders { //for accessing to ChangeNotifier
    return _orders;
  }

  /*final userCollection = FirebaseFirestore.instance.collection('users');
  Future<void> fetchOrders() async {
    final User? user = authInstance.currentUser;
    final DocumentSnapshot userDoc =
    await userCollection.doc(user!.uid).get();
    if (userDoc == null) {
      return;
    }
    final leng = userDoc.get("userOrder").length;
    for (int i = 0; i < leng; i++){
      _orders.putIfAbsent(
          userDoc.get("userOrder")[i]["productId"],
              () => OrderModel(
            id: userDoc.get("userOrder")[i]["orderId"],
            productId: userDoc.get("userOrder")[i]["productId"],
            userId: userDoc.get("userOrder")[i]["userId"],
            userName: userDoc.get("userOrder")[i]["userName"],
            imageUrl: userDoc.get("userOrder")[i]["imageUrl"],
            quantity: userDoc.get("userOrder")[i]["quantity"],
            price: userDoc.get("userOrder")[i]["price"],
            orderDate: userDoc.get("userOrder")[i]["orderDate"]
          ));
    }
    notifyListeners();
  }*/

  Future<void> fetchOrders() async {
    User? user = authInstance.currentUser;
    await FirebaseFirestore.instance
        .collection("orders")
        .where("userId", isEqualTo: user!.uid,)
        .orderBy("orderDate", descending: false)
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

  /*Future<void> fetchOrders() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _orders = [];
      // _orders.clear();
      ordersSnapshot.docs.forEach((element) {
        _orders.insert(
          0,
          OrderModel(
            orderId: element.get('orderId'),
            userId: element.get('userId'),
            productId: element.get('productId'),
            userName: element.get('userName'),
            price: element.get('price').toString(),
            imageUrl: element.get('imageUrl'),
            quantity: element.get('quantity').toString(),
            orderDate: element.get('orderDate'),
          ),
        );
      });
    });
    notifyListeners();
  }*/

  void clearLocalOrders() {
    _orders.clear();
    notifyListeners();
  }
}