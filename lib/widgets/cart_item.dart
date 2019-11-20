import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

class CartItem extends StatelessWidget {
  final productId;
  CartItem(this.productId);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final cartItem = cart.findByProductId(productId);
    return Dismissible(
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove the item from cart ?'),
            actions: <Widget>[
              FlatButton(
                child: Text('no'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              FlatButton(
                child: Text('yes'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => cart.removeItem(productId),
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        color: Theme.of(context).errorColor,
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        alignment: Alignment.centerRight,
      ),
      key: ValueKey(cartItem.id),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  "\$${cartItem.price}",
                ),
              ),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text(
            'TotalPrice: \$${cartItem.quantity * cartItem.price}',
          ),
          trailing: Text('${cartItem.quantity} x'),
        ),
      ),
    );
  }
}
