import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/api.dart';
import '../models/user/user_model.dart';

class UserRepository {
  final Api _api = Api();

  Future<UserModel> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.sendRequest.post("/user/createAccount",
          data: jsonEncode({
            "email": email,
            "password": password,
          }));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      //convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

//repo for signIn
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.sendRequest.post("/user/signIn",
          data: jsonEncode({
            "email": email,
            "password": password,
          }));

      log("api" + response.data.toString());
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      //convert raw data to model
      // log("api"+apiResponse.data.toString());
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> updatedUser(UserModel userModel) async {
    try {
      Response response = await _api.sendRequest
          .put("/user/${userModel.sId}", data: jsonEncode(userModel.toJson()));

      log("api" + response.data.toString());
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      //convert raw data to model
      // log("api"+apiResponse.data.toString());
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
