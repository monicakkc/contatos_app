import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:contatosapp/repositories/back_dio_interceptor.dart';

class BackCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  BackCustomDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
    _dio.interceptors.add(BackDioInterceptor());
  }
}
