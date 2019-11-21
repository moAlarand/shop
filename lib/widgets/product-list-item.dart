import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/screens/product_details_screens.dart';
import '../providers/product.dart';

class ProductListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            ProductDetailsScreen.routeName,
            arguments: productProvider.id,
          ),
          child: Image.network(
            productProvider.imgUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            productProvider.name,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(
                product.isFav ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () async {
                try {
                  await product.toggleFav();
                } catch (error) {
                  print(error.response);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("added item to fav faild!! + ${error.response}"),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
            ),
          ),
          trailing: Consumer<Cart>(
            builder: (_, cart, child) => IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                cart.addItem(
                  productProvider.id,
                  productProvider.name,
                  productProvider.price,
                );

                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("added item to cart!!"),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cart.removeSingleProduct(productProvider.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
