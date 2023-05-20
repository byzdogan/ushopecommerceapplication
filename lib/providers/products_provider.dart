import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ushopecommerceapplication/models/products_model.dart';

class ProductsProvider with ChangeNotifier {

  static List<ProductModel> _productsList = [];

  List<ProductModel> get getProducts { //for accessing to ChangeNotifier
    return _productsList;
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance.collection("products").get().then((
        QuerySnapshot productSnapshot) {
          _productsList = []; //_productsList.clear();
          productSnapshot.docs.forEach((element) {
            _productsList.insert(
                0,
                ProductModel(
                    id: element.get("id"),
                    title: element.get("title"),
                    imageUrl: element.get("imageUrl"),
                    productCategoryName: element.get("productCategoryName"),
                    price: double.parse(element.get("price"),),
                    salePrice: (element.get("salePrice")).toDouble(),
                    isOnSale: element.get("isOnSale"), ));
          });
    }); // tüm ürünleri göstermek istediğimiz için id eklemedik kullanıcada öyle değildi.
    notifyListeners();
  }

  ProductModel findProdById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> _categoryList = _productsList
        .where((element) => element.productCategoryName
        .toLowerCase()
        .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> _searchList = _productsList
        .where((element) => element.title
        .toLowerCase()
        .contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }

  /*static final List<ProductModel> _productsList = [
    ProductModel(
      id: "Sweatshirt",
      title: "Sweatshirt",
      price: 250,
      salePrice: 200,
      imageUrl:   "https://cdn.dsmcdn.com/ty644/product/media/images/20221213/11/235843656/154436277/1/1_org_zoom.jpg",
      productCategoryName: "Clothes",
      isOnSale: true,
    ),
    ProductModel(
      id: "Notebook",
      title: "Notebook",
      price: 50,
      salePrice: 40,
      imageUrl: "https://i.pinimg.com/564x/c0/b4/52/c0b452086de352f2282d260936d18214.jpg",
      productCategoryName: "Stationeries",
      isOnSale: false,
    ),
    ProductModel(
      id: "Mug",
      title: "Mug",
      price: 65,
      salePrice: 60,
      imageUrl: "https://ayb.akinoncdn.com/products/2023/01/10/2286150/da6766ba-8b92-44bc-901a-afaf2a28509b_size780x780_quality60_cropCenter.jpg",
      productCategoryName: "Others",
      isOnSale: true,
    ),
    ProductModel(
      id: "Bag",
      title: "Bag",
      price: 150,
      salePrice: 110,
      imageUrl: "https://bezden.com.tr/wp-content/uploads/2022/02/bezden-natural-shopper-kanvas-bez-canta.jpg",
      productCategoryName: "Accessories",
      isOnSale: false,
    ),
    ProductModel(
      id: "Phone Case",
      title: "Phone case",
      price: 70,
      salePrice: 55,
      imageUrl: "https://i.pinimg.com/564x/09/c5/e9/09c5e95db9c33d612d4ee261401b1d1f.jpg",
      productCategoryName: "Accessories",
      isOnSale: true,
    ),
    ProductModel(
      id: "Wallet",
      title: "Wallet",
      price: 180,
      salePrice: 165,
      imageUrl: "https://i.pinimg.com/564x/ba/95/eb/ba95eb04c1e3120f42a402751378f602.jpg",
      productCategoryName: "Accessories",
      isOnSale: true,
    ),
    ProductModel(
      id: "Beanie",
      title: "Beanie",
      price: 90,
      salePrice: 75,
      imageUrl: "https://i.pinimg.com/564x/57/31/12/573112f04df1eadde42faab83483dad9.jpg",
      productCategoryName: "Clothes",
      isOnSale: false,
    ),
    ProductModel(
      id: "Hat",
      title: "Hat",
      price: 85,
      salePrice: 70,
      imageUrl: "https://cdn.dsmcdn.com/mnresize/128/192/ty113/product/media/images/20210507/19/86734910/172188280/0/0_org_zoom.jpg",
      productCategoryName: "Clothes",
      isOnSale: true,
    ),
    ProductModel(
      id: "Fountain Pen",
      title: "Fountain Pen",
      price: 280,
      salePrice: 210,
      imageUrl: "https://www.montblanc.com/variants/images/34480784411799068/A/w534.jpg",
      productCategoryName: "Stationeries",
      isOnSale: true,
    ),
    ProductModel(
      id: "T-shirt",
      title: "T-shirt",
      price: 105,
      salePrice: 90,
      imageUrl: "https://i.pinimg.com/564x/92/1b/39/921b39168f39a6ece4516c43652d71b1.jpg",
      productCategoryName: "Clothes",
      isOnSale: false,
    ),

    ProductModel(
      id: "Pencil Case",
      title: "Pencil Case",
      price: 60,
      salePrice: 40,
      imageUrl: "https://i.pinimg.com/564x/69/54/72/6954727bcf8fc9732a2ce5f5dbc3a055.jpg",
      productCategoryName: "Stationeries",
      isOnSale: false,
    ),
    ProductModel(
      id: "Ring",
      title: "Silver Ring",
      price: 280,
      salePrice: 260,
      imageUrl: "https://i.pinimg.com/564x/f7/e7/1b/f7e71b0f75cc420c1f290fd26bc90ced.jpg",
      productCategoryName: "Accessories",
      isOnSale: false,
    ),
  ];*/
}