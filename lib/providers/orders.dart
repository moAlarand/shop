import 'package:flutter/material.dart';
import './cart.dart';

class Order {
  String id;
  double amount;
  DateTime dateTime;
  List<CartItem> products;

  Order({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  addOrder(List<CartItem> cartProducts, double amount) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        products: cartProducts,
        amount: amount,
        dateTime: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  Order findOrderById(String id) {
    return _orders.firstWhere((order) => order.id == id);
  }
}
