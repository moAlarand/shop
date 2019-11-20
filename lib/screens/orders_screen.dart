import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/AppDrawer.dart';
import 'package:shop/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routName = "/order-screen";
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("my orders"),
      ),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (_, index) => OrderItem(orders.orders[index].id),
      ),
      drawer: AppDrawer(),
    );
  }
}
