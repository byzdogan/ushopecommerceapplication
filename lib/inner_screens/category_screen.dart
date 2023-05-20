import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/const/contss.dart';
import 'package:ushopecommerceapplication/inner_screens/feed_screens.dart';
import 'package:ushopecommerceapplication/models/products_model.dart';
import 'package:ushopecommerceapplication/providers/products_provider.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/widgets/back_widget.dart';
import 'package:ushopecommerceapplication/widgets/empty_products_widget.dart';
import '../services/utils.dart';
import '../widgets/feed_items.dart';
import '../widgets/text_widget.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "/CategoryScreenState";
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ProductModel> listProductSearch = [];
  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    final catText = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> productsByCategory =
        productProviders.findByCategory(catText); //catName
    return Scaffold(
      appBar: AppBar(
        leading: BackWidget(),
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: catText,
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      body: productsByCategory.isEmpty
          ? const EmptyProductsWidget(
        text: "There is not any products in this category yet!",
      )
          : SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
                  child: SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: TextField(
                      focusNode: _searchTextFocusNode,
                      controller: _searchTextController,
                      onChanged: (valuee) {
                        setState(() {
                          listProductSearch = productProviders.searchQuery(valuee);
                        });
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          const BorderSide(color: Colors.cyan, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          const BorderSide(color: Colors.cyan, width: 1),
                        ),
                        hintText: "Search in UShop",
                        prefixIcon: const Icon(Icons.search),
                        suffix: IconButton(
                          onPressed: () {
                            _searchTextController!.clear();
                            _searchTextFocusNode.unfocus();
                          },
                          icon: Icon(
                            Icons.close,
                            color: _searchTextFocusNode.hasFocus ? Colors.cyan : color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _searchTextController!.text.isNotEmpty && listProductSearch.isEmpty
                    ? const EmptyProductsWidget(
                        text: "The product that you searched can not be found. Please try another keyword! ")
                    : GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        padding: EdgeInsets.zero,
                        // crossAxisSpacing: 10,
                        childAspectRatio: size.width / (size.height * 0.76), //0,69
                        children: List.generate(
                            _searchTextController!.text.isNotEmpty
                                ? listProductSearch.length
                                : productsByCategory.length, (index) { //productsByCategory
                            return ChangeNotifierProvider.value(
                              value: _searchTextController!.text.isNotEmpty
                                  ? listProductSearch[index]
                                  : productsByCategory[index],
                              child: const FeedsWidget(),
                          ) ;
                        }),
                      ),
              ]),
      ),
    );
  }
}