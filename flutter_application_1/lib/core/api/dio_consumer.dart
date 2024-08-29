import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_application_1/core/api/api_interceptors.dart';
import 'package:flutter_application_1/core/api/end_points.dart';
import 'package:flutter_application_1/core/errors/exeeptions.dart';

class DioConsumer extends ApiConsumeras {
  final Dio dio;
  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.connectTimeout =
        const Duration(milliseconds: 100000); // 5000 milliseconds = 5 seconds
    dio.options.receiveTimeout =
        const Duration(milliseconds: 100000); // 3000 milliseconds = 3 seconds
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }
  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.delete(path,
          data: isFromData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.get(path,
          data: isFromData ? FormData.fromMap(data) : data,
          options: Options(headers: headers),
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.patch(path,
          data: isFromData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
    bool isData =true,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.put(path,
          data: isFromData ? FormData.fromMap(data) : data,
          options: Options(
            headers: headers,
          ),
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
