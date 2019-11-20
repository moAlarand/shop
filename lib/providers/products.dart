import 'package:flutter/material.dart';
import 'package:shop/services/services_helper.dart';
import './product.dart';

class Products with ChangeNotifier {
  final servicesHelper = ServicesHelper();
  List<Product> _items = [];

  List<Product> get items {
    return _items;
  }

  Future<List<Product>> get fetchProducts async {
    var productsMap = await servicesHelper.getProducts();
    _items = [];
    if (productsMap != null)
      productsMap.forEach((key, value) {
        _items.insert(
            0,
            Product(
              id: key,
              desc: value.desc,
              imgUrl: value.imgUrl,
              name: value.name,
              price: value.price,
            ));
      });
    notifyListeners();

    return _items;
  }

  addProduct(Product prod) async {
    final key = await servicesHelper.createProduct(prod);
    _items.insert(
        0,
        Product(
          id: key.name,
          desc: prod.desc,
          imgUrl: prod.imgUrl,
          name: prod.name,
          price: prod.price,
        ));
    notifyListeners();
  }

  updateItem(String id, Product prod) async {
    final index = _items.indexWhere((item) => item.id == prod.id);
    if (index != -1) {
      await servicesHelper.editProduct(id, prod);
      _items[index] = prod;
      notifyListeners();
    }
  }

  removeItem(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    final item = _items[index];
    _items.removeAt(index);
    notifyListeners();
    try {
      await servicesHelper.removeProduct(id);
    } catch (error) {
      _items.insert(index, item);
      notifyListeners();
      throw error;
    }
  }

  Product findById(id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get favItems {
    return _items.where((prod) => prod.isFav);
  }
}
