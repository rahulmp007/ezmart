import 'dart:developer';

import 'package:dio/dio.dart';

class ApiClient {
  static ApiClient? _singleton;
  late final Dio _dio;

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Logging Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('URL: ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('✅ [RESPONSE]');
          log('Status Code: ${response.statusCode}');
          log('Data: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          log('❌ [ERROR]');
          log('Message: ${error.message}');
          log('Response: ${error.response}');
          return handler.next(error);
        },
      ),
    );
  }

  factory ApiClient() => _singleton ??= ApiClient._internal();

  /// GET with optional cancel token
  Future get({required String url}) async {
    try {
      final response = await _dio.get(url);

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  /// POST with optional cancel token
  Future post({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  /// PUT with optional cancel token
  Future put({
    required String url,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  /// Dispose Singleton
  void dispose() {
    _singleton = null;
  }
}
