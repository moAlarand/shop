import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'package:shop/widgets/product-list-item.dart';

class ProductsGridList extends StatelessWidget {
  final _showFav;
  ProductsGridList(this._showFav);
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: FutureBuilder(
          future: Provider.of<Products>(context, listen: false).fetchProducts,
          builder: (_, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapShot.error != null) {
              return Center(
                child: Text(snapShot.error.toString()),
              );
            }
            return Consumer<Products>(
              builder: (_, productsProvider, __) {
                final products = _showFav
                    ? productsProvider.favItems
                    : productsProvider.items;
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: products.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                    value: products[i],
                    child: ProductListItem(),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                );
              },
            );
          }),
      onRefresh: () =>
          Provider.of<Products>(context, listen: false).fetchProducts,
    );
  }
}
