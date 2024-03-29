import 'package:flutter/material.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';
import 'package:shop/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('sapa7 elfol'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('shop'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ProductOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('orders'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OrderScreen.routName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('manage orders'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, UserProductScreen.routName);
            },
          )
        ],
      ),
    );
  }
}
