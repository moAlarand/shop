import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/widgets/AppDrawer.dart';
import 'package:shop/widgets/user_product_item.dart';
import 'package:shop/screens/edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routName = "/user_product_screen";

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("my Products"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => products.fetchProducts,
        child: Container(
          margin: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (_, index) => UserProductItem(products.items[index]),
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
