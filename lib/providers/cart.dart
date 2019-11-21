import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shop/services/services_helper.dart';

part 'cart.g.dart';

@JsonSerializable()
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

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

class Cart with ChangeNotifier {
  final servicesHelper = ServicesHelper();
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

  addItem(productId, name, price) async {
    if (_items.containsKey(productId)) {
      await servicesHelper.addProductToCartItem(productId, newCart);
      _items.update(
        productId,
        (cartItem) => CartItem(
          productId: cartItem.productId,
          id: productId,
          name: cartItem.name,
          price: cartItem.price,
          quantity: ++cartItem.quantity,
        ),
      );
    } else {
      final newCart = CartItem(
        productId: productId,
        id: productId,
        name: name,
        price: price,
        quantity: 1,
      );
      await servicesHelper.addItemToCart(productId, newCart);
      _items.putIfAbsent(
        productId,
        () => newCart,
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
