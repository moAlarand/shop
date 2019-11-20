import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart' show Cart;
import 'package:shop/providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  void _onOrderNow(
    BuildContext context,
    cartProducts,
    double totalCost,
  ) {
    final orders = Provider.of<Orders>(context, listen: false);
    orders.addOrder(cartProducts, totalCost);
  }

  Widget _buildTotalCost(context, Cart cart) {
    final totalCost = cart.totalPrice;

    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Text(
              'Total',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Spacer(),
            Chip(
              backgroundColor: Theme.of(context).accentColor,
              label: Text('\$${totalCost.toStringAsFixed(2)}'),
            ),
            SizedBox(
              width: 2,
            ),
            FlatButton(
                child: Text(
                  'ORDER NOW',
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  _onOrderNow(context, cart.items.values.toList(), totalCost);
                  cart.clear();
                })
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('cart'),
      ),
      body: Column(
        children: <Widget>[
          _buildTotalCost(context, cart),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (_, int index) =>
                  CartItem(cartItems[index].productId),
            ),
          )
        ],
      ),
    );
  }
}
