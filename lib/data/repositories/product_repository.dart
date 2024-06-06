import 'package:dio/dio.dart';
import 'package:uber_eats_clone/core/api.dart';
import 'package:uber_eats_clone/data/models/product_model.dart';

class ProductRepository {
  final _api = Api();

  Future<List<ProductModel>> fetchProductList(String restaurantId) async {
    try {
      Response response = await _api.sendRequest.get("/dish/$restaurantId");
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
