import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecom_app/data/models/category/category_model.dart';
import 'package:ecom_app/data/models/products/products_model.dart';

import '../../core/api.dart';
import '../models/user/user_model.dart';

class ProductRepository {
  final Api _api = Api();

  Future<List<ProductModel>> FetchAllProducts() async {
    try {
      Response response = await _api.sendRequest.get("/products");
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
  Future<List<ProductModel>> FetchProductsByCategory(String categoryId) async {
    try {
      Response response = await _api.sendRequest.get("/products/category/$categoryId");
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
