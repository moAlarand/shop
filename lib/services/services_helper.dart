import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/key.dart';
import 'package:shop/providers/product.dart';
part 'services_helper.g.dart';

@RestApi(baseUrl: "https://shop-8ea4f.firebaseio.com")
abstract class ServicesHelper {
  static final dio = Dio();
  factory ServicesHelper() {
    return _ServicesHelper(dio);
  }

  @POST("/products.json")
  Future<Key> createProduct(@Body() Product product);

  @GET("/products.json")
  Future<Map<String, Product>> getProducts();

  @PUT("/products/{key}.json")
  Future<Key> editProduct(@Path() String key, @Body() Product product);

  @DELETE("/products/{key}.json")
  Future<void> removeProduct(@Path() String key);

  @PATCH("/products/{key}.json")
  Future<void> toggleFav(@Path() String key, @Body() Product product);

  @POST("/cart/{key}.json")
  Future<Key> addItemToCart(@Path() String key, @Body() CartItem cartItem);

  @GET("/cart.json")
  Future<Map<String, CartItem>> getCart();

  @DELETE("/cart/{key}.json")
  Future<void> deleteCart(@Path() String key);

  @PATCH("/cart/{key}.json")
  Future<void> addProductToCartItem(
      @Path() String key, @Body() Product product);
}
