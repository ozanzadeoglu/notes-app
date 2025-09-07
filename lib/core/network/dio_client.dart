import 'package:dio/dio.dart';

class DioClient {
  static const _baseUrl = "http://127.0.0.1:5001/";
  static const _headerContentType = "Content-Type";
  static const _contentTypeJson = "application/json";


  static final Dio _dio = Dio(
    BaseOptions(

      baseUrl: _baseUrl,
      headers: {
        _headerContentType: _contentTypeJson,
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  DioClient._internal();

  static final DioClient instance = DioClient._internal();

  Dio get dio => _dio;


}