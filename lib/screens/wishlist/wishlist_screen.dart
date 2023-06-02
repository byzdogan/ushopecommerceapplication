import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/providers/wishlist_provider.dart';
import 'package:ushopecommerceapplication/screens/cart/cart_widget.dart';
import 'package:ushopecommerceapplication/screens/wishlist/wishlist_widget.dart';
import 'package:ushopecommerceapplication/services/global_methods.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/back_widget.dart';
import 'package:ushopecommerceapplication/widgets/empty_screen.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    //bool _isEmpty = true;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
    wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return wishlistItemsList.isEmpty //_isEmpty
        ? const EmptyScreen(
      title: "Your wish list is empty!",
      subtitle: " ",
      buttonText: 'Add a Wish',
      imagePath: 'assets/images/empty_screens/emptywishlist.png',
    )
        :Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: const BackWidget(),
            automaticallyImplyLeading: false,
            elevation: 1,
            backgroundColor: Theme
                .of(context)
                .scaffoldBackgroundColor,
            title: TextWidget(
              text: "Wishlist (${wishlistItemsList.length})",
              textSize: 22,
              isTitle: true,
              color: color,),
            actions: [
              IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                        title: "Empty your wishlist",
                        subtitle: "Are you sure?",
                        fct: () async{
                          await wishlistProvider.clearOnlineWishlist();
                          wishlistProvider.clearLocalWishlist();
                        },
                        context: context);
                  },
                  icon: Icon(
                    IconlyLight.delete, //IconlyBroken.delete,
                    color: color,
                  ))
            ],
          ),
          body: MasonryGridView.count(
            itemCount: wishlistItemsList.length,
            crossAxisCount: 2,
            //mainAxisSpacing: 16,
            //crossAxisSpacing: 20,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                  value: wishlistItemsList[index],
                  child: const WishlistWidget());
            },
          ),
        );
  }
  }