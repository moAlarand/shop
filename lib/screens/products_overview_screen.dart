import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/widgets/AppDrawer.dart';
import 'package:shop/widgets/badge.dart';
import 'package:shop/widgets/product-gird-List.dart';

enum FilterOpitions { Fav, All }

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = "/";
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showIsFav = false;

  Widget _buildAppBar() {
    return AppBar(
      title: Text("shop"),
      actions: <Widget>[
        Consumer<Cart>(
          builder: (_, cart, child) => Badge(
            child: child,
            value: cart.itemCount.toString(),
          ),
          child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () =>
                {Navigator.pushNamed(context, CartScreen.routeName)},
          ),
        ),
        PopupMenuButton(
          onSelected: (value) {
            setState(() {
              if (value == FilterOpitions.Fav) {
                _showIsFav = true;
              } else {
                _showIsFav = false;
              }
            });
          },
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: Text("Fav"),
              value: FilterOpitions.Fav,
            ),
            PopupMenuItem(
              child: Text("All"),
              value: FilterOpitions.All,
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ProductsGridList(_showIsFav),
      drawer: AppDrawer(),
    );
  }
}
