import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String BASE_URL = "http://192.168.1.4:5000/api";
const Map<String,dynamic> DEFAULT_HEADERS = {
  'content-Type':'application/json'
};

class Api {
  final Dio _dio = Dio();
  //interceptors

  Api(){
    _dio.options.baseUrl = BASE_URL;
    _dio.options.headers = DEFAULT_HEADERS;
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true
    ));
  }
  Dio get sendRequest => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;
  ApiResponse({
    required this.success,
    this.data,
    this.message,
  });
  factory ApiResponse.fromResponse(Response response){

    final data = response.data as Map<String,dynamic>;
    return ApiResponse(
    success:data["success"] ,
    data:  data["data"] ,
    message: data["message"] ??"unexpected error"
    
    );

  }
}
