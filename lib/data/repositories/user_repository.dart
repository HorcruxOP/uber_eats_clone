import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:uber_eats_clone/data/models/user_model.dart';
import 'package:uber_eats_clone/core/api.dart';

class UserRepository {
  final _api = Api();

  Future<UserModel> createAccount({
    required String email,
    required String fullName,
    required String phoneNumber,
    String? address,
  }) async {
    try {
      Response response = await _api.sendRequest.post(
        '/user/createAccount',
        data: jsonEncode(
          {
            "email": email,
            "fullName": fullName,
            "phoneNumber": phoneNumber,
            "address": address,
          },
        ),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return UserModel.fromJson(apiResponse.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkUserExist({
    required String phoneNumber,
  }) async {
    try {
      Response response = await _api.sendRequest.post(
        '/user/checkUserExist',
        data: jsonEncode(
          {
            "phoneNumber": phoneNumber,
          },
        ),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (apiResponse.success==false) {
        return apiResponse.success;
      }else{
        return apiResponse.success;
      }
      
    } catch (e) {
      rethrow;
    }
  }
}
