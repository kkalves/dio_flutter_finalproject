import 'package:dio/dio.dart';
import 'package:dio_flutter_finalproject/page/back4app/cep_dio_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CepCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  CepCustomDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
    _dio.interceptors.add(Back4AppDioInterceptor());
  }
}