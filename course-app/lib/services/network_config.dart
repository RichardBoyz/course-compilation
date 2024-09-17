import 'package:dio/dio.dart';

import '../cache/cache.dart';

class NetworkConfig {
  static const String baseUrl = 'http://127.0.0.1:8000/api/';

  static const Duration sendTimeout = Duration(milliseconds: 8000);

  static const Duration connectTimeout = Duration(milliseconds: 8000);

  static const Duration receiveTimeout = Duration(milliseconds: 8000);
}

class NetworkIntercept extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token = AppCache.token;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }
}

class Network {
  final Dio dio;

  Network._({required this.dio});

  factory Network._create(Dio dio) => Network._(dio: dio);

  static Network? _client;

  static void init([token = '']) {
    if (_client == null) {
      final BaseOptions options = BaseOptions(
        baseUrl: NetworkConfig.baseUrl,
        sendTimeout: NetworkConfig.sendTimeout,
        connectTimeout: NetworkConfig.connectTimeout,
        receiveTimeout: NetworkConfig.receiveTimeout,
      );

      final Dio dio = Dio(options);

      dio.interceptors.add(NetworkIntercept());

      _client = Network._create(dio);
    }
  }

  static Dio get instance => _client!.dio;
}
