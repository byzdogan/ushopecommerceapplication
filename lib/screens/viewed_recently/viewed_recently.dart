import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/providers/viewed_provider.dart';
import 'package:ushopecommerceapplication/screens/viewed_recently/viewed_widget.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/back_widget.dart';
import 'package:ushopecommerceapplication/widgets/empty_screen.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen';
  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyScreenState createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    //bool _isEmpty = true;
    final viewedProdProvider = Provider.of<ViewedProductProvider>(context);
    final viewedProdItemsList = viewedProdProvider.getViewedProdlistItems.values
        .toList()
        .reversed
        .toList();

      if (viewedProdItemsList.isEmpty == true) { // _isEmpty == true
        return const EmptyScreen(
          title: "Your history is empty!",
          subtitle: "You have not viewed any USHOP product yet!",
          buttonText: 'Shop now',
          imagePath: 'assets/images/empty_screens/emptyhistory2.jpg',
        );
      }else{
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  GlobalMethods.warningDialog(
                      title: 'Empty your history?',
                      subtitle: 'Are you sure?',
                      fct: () {
                        viewedProdProvider.clearHistory();
                      },
                      context: context);
                },
                icon: Icon(
                  IconlyLight.delete,
                  color: color,
                ),
              )
            ],
            leading: const BackWidget(),
            automaticallyImplyLeading: false,
            elevation: 1,
            centerTitle: true,
            title: TextWidget(
              isTitle: true,
              text: 'History',
              color: color,
              textSize: 24.0,
            ),
            backgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
          ),
          body: ListView.builder(
              itemCount: viewedProdItemsList.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: ChangeNotifierProvider.value(
                      value: viewedProdItemsList[index],
                      child: const ViewedRecentlyWidget()
                  ),
                );
              }),
        );
      }
  }
}