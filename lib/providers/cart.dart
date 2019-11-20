import 'package:flutter/foundation.dart';

class CartItem {
  String id;
  String productId;
  String name;
  double price;
  int quantity;

  CartItem({
    @required this.id,
    @required this.productId,
    @required this.name,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalPrice {
    var totalPrice = 0.0;
    _items.values.forEach((item) {
      totalPrice += item.quantity * item.price;
    });
    return totalPrice;
  }

  CartItem findByProductId(productId) {
    return _items[productId];
  }

  addItem(productId, name, price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (cartItem) => CartItem(
          productId: cartItem.productId,
          id: cartItem.id,
          name: cartItem.name,
          price: cartItem.price,
          quantity: ++cartItem.quantity,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          productId: productId,
          id: DateTime.now().toString(),
          name: name,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  bool removeItem(productId) {
    bool isRemoved = _items.remove(productId) != null;
    if (isRemoved) {
      notifyListeners();
    }
    return isRemoved;
  }

  bool removeSingleProduct(productId) {
    if (!_items.containsKey(productId)) {
      return false;
    }

    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (cartItem) => CartItem(
          productId: cartItem.productId,
          id: cartItem.id,
          name: cartItem.name,
          price: cartItem.price,
          quantity: --cartItem.quantity,
        ),
      );
    } else {
      _items.remove(productId);
    }

    notifyListeners();
    return true;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
