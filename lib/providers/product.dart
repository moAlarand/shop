import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shop/services/services_helper.dart';

part 'product.g.dart';

@JsonSerializable()
class Product with ChangeNotifier {
  final servicesHelper = ServicesHelper();

  final String id;
  final String name;
  final String desc;
  final String imgUrl;
  final double price;
  bool isFav;

  Product({
    @required this.id,
    @required this.name,
    @required this.desc,
    @required this.imgUrl,
    @required this.price,
    this.isFav = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  toggleFav() async {
    isFav = !isFav;
    notifyListeners();
    try {
      if (isFav)
        await servicesHelper.addToFav(id);
      else
        await servicesHelper.unFav(id);
    } catch (error) {
      isFav = !isFav;
      notifyListeners();
      throw error;
    }
  }
}
