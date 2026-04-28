import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_endpoints.dart';

class DioClient {
  static const String _apiBase = ApiEndpoints.baseUrl;
  static const String _corsProxy = 'https://corsproxy.io/?url=';

  late final Dio _dio;

  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _apiBase,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Rewrite requests through CORS proxy when running on web
    if (kIsWeb) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final base = options.baseUrl.endsWith('/')
                ? options.baseUrl.substring(0, options.baseUrl.length - 1)
                : options.baseUrl;
            final path = options.path.startsWith('/')
                ? options.path
                : '/${options.path}';
            final targetUrl = '$base$path';

            options.baseUrl = '';
            options.path =
                '$_corsProxy${Uri.encodeQueryComponent(targetUrl)}';
            options.queryParameters = {};
            handler.next(options);
          },
        ),
      );
    }

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: false,
          logPrint: (obj) => debugPrint('[DIO] $obj'),
        ),
      );
    }
  }

  Dio get dio => _dio;
}
