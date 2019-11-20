import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final Product _product;
  UserProductItem(this._product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_product.imgUrl),
      ),
      title: Text(_product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName,
                    arguments: _product.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () async {
                try {
                await  Provider.of<Products>(context, listen: false)
                      .removeItem(_product.id);
                } catch (error) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("deleted Fail"),
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
