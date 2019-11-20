import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
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

  @PATCH("/products/{key}/isFav.json")
  Future<Key> addToFav(@Path() String key, {@Body() bool isFav = true});

  @PATCH("/products/{key}/isFav.json")
  Future<Key> unFav(@Path() String key, {@Body() bool isFav = false});
}
