import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecom_app/data/models/category/category_model.dart';

import '../../core/api.dart';
import '../models/user/user_model.dart';

class CategoryRepository {
  final Api _api = Api();

  Future<List<CategoryModel>> FetchAllCategories() async {
    try {
      Response response = await _api.sendRequest.get("/category");
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
