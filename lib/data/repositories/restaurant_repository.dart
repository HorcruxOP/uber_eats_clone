import 'package:dio/dio.dart';
import 'package:uber_eats_clone/data/models/restaurant_model.dart';
import 'package:uber_eats_clone/core/api.dart';

class RestaurantRepository {
  final _api = Api();

  Future<List<RestaurantModel>> fetchRestaurant() async {
    try {
     Response response = await _api.sendRequest.get("/restaurant/restaurantList");
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if(!apiResponse.success){
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => RestaurantModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
