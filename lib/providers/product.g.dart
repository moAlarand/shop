// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as String,
    name: json['name'] as String,
    desc: json['desc'] as String,
    imgUrl: json['imgUrl'] as String,
    price: (json['price'] as num)?.toDouble(),
    isFav: json['isFav'] as bool,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'imgUrl': instance.imgUrl,
      'price': instance.price,
      'isFav': instance.isFav,
    };
