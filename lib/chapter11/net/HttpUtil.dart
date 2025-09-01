import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../entiy/ApiResponse.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  late Dio dio;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://api.yourdomain.com/api',
      // 替换为你的 API 基础 URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    // 添加拦截器
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 在请求发送前添加请求头，例如：token
          // options.headers['Authorization'] = 'Bearer your_token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // 在响应返回前处理数据，例如：对非业务成功的 code 统一处理
          if (kDebugMode) {
            print('--- 请求成功 Response ---');
            print(response.data);
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // 统一处理 Dio 异常，例如：网络错误、超时等
          if (kDebugMode) {
            print('--- 请求错误 Error ---');
            print(e.message);
          }
          return handler.next(e);
        },
      ),
    );
  }

  // GET 请求
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(Object? json) fromJsonT,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return ApiResponse.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      // 捕获并封装 Dio 异常
      return ApiResponse(code: -1, message: _handleDioError(e));
    } catch (e) {
      return ApiResponse(code: -2, message: '未知错误：$e');
    }
  }

  // POST 请求
  Future<ApiResponse<T>> post<T>(
    String path, {
    Object? data,
    required T Function(Object? json) fromJsonT,
  }) async {
    try {
      final response = await dio.post(path, data: data);
      return ApiResponse.fromJson(response.data, fromJsonT);
    } on DioException catch (e) {
      return ApiResponse(code: -1, message: _handleDioError(e));
    } catch (e) {
      return ApiResponse(code: -2, message: '未知错误：$e');
    }
  }

  // 封装 Dio 异常处理
  String _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return '网络请求超时';
    } else if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 404) {
        return '请求地址不存在';
      } else if (statusCode == 500) {
        return '服务器内部错误';
      }
    }
    return e.message ?? '网络请求失败';
  }
}
