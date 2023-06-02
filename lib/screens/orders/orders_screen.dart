import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushopecommerceapplication/providers/orders_provider.dart';
import 'package:ushopecommerceapplication/screens/orders/orders_widget.dart';
import 'package:ushopecommerceapplication/services/utils.dart';
import 'package:ushopecommerceapplication/widgets/back_widget.dart';
import 'package:ushopecommerceapplication/widgets/empty_screen.dart';
import 'package:ushopecommerceapplication/widgets/text_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    //bool _isEmpty = true;
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final ordersList = ordersProvider.getOrders;
    // Size size = Utils(context).getScreenSize;
    return FutureBuilder(
        future: ordersProvider.fetchOrders(),
        builder: (context, snapshot)
        {
          return ordersList.isEmpty
              ? const EmptyScreen(
            title: 'You have not ordered anything yet!',
            subtitle: " ",
            buttonText: 'Shop now',
            imagePath: 'assets/images/empty_screens/emptyorder1.png',
          )
              : Scaffold(
              appBar: AppBar(
                leading: const BackWidget(),
                elevation: 1, //0
                centerTitle: true,
                title: TextWidget(
                  text: "Your Orders (${ordersList.length})", //Your orders (2)
                  color: color,
                  textSize: 24.0,
                  isTitle: true,
                ),
                backgroundColor:
                Theme.of(context).scaffoldBackgroundColor, //.withOpacity(0.9)
              ),
              body: ListView.separated(
                itemCount: ordersList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    child: ChangeNotifierProvider.value(
                        value: ordersList[index],
                        child: const OrderWidget()),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: color,
                    thickness: 1,
                  );
                },
              ));
        }
    );
  }
}