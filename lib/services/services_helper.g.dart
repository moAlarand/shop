// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_helper.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ServicesHelper implements ServicesHelper {
  _ServicesHelper(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://shop-8ea4f.firebaseio.com';
  }

  final Dio _dio;

  String baseUrl;

  @override
  createProduct(product) async {
    ArgumentError.checkNotNull(product, 'product');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(product.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/products.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Key.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getProducts() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/products.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data.map((k, dynamic v) =>
        MapEntry(k, Product.fromJson(v as Map<String, dynamic>)));

    return Future.value(value);
  }

  @override
  editProduct(key, product) async {
    ArgumentError.checkNotNull(key, 'key');
    ArgumentError.checkNotNull(product, 'product');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(product.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/products/$key.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Key.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  removeProduct(key) async {
    ArgumentError.checkNotNull(key, 'key');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/products/$key.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }

  @override
  toggleFav(key, product) async {
    ArgumentError.checkNotNull(key, 'key');
    ArgumentError.checkNotNull(product, 'product');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(product.toJson() ?? <String, dynamic>{});
    await _dio.request<void>('/products/$key.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PATCH',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }

  @override
  addItemToCart(key, cartItem) async {
    ArgumentError.checkNotNull(key, 'key');
    ArgumentError.checkNotNull(cartItem, 'cartItem');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(cartItem.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/cart/$key.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Key.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getCart() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/cart.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data.map((k, dynamic v) =>
        MapEntry(k, CartItem.fromJson(v as Map<String, dynamic>)));

    return Future.value(value);
  }

  @override
  deleteCart(key) async {
    ArgumentError.checkNotNull(key, 'key');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/cart/$key.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }

  @override
  addProductToCartItem(key, product) async {
    ArgumentError.checkNotNull(key, 'key');
    ArgumentError.checkNotNull(product, 'product');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(product.toJson() ?? <String, dynamic>{});
    await _dio.request<void>('/cart/$key.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PATCH',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }
}
