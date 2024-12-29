import 'package:dio/dio.dart';
import 'package:collab_stake/interceptors/request_interceptor.dart';

class CustomDio{ 
  static CustomDio? _instance;
  Dio _dio;

  CustomDio._internal() : _dio = Dio() {
    _dio.interceptors.add(RequestInterceptor());
  }

  factory CustomDio() {
    _instance ??= CustomDio._internal(); 
    return _instance!;
  }

  Dio get dioInstance => _dio;
}