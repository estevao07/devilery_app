import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'package:delivery_app/app/core/rest_client/interceptors/auth_interceptors.dart';

import '../config/env/env.dart';

class CustomDio extends DioForNative {
  late AuthInterceptor _authInterceptor;

  CustomDio()
      : super(
          BaseOptions(
            baseUrl: Env.i['backend_base_url'] ?? '',
            connectTimeout: const Duration(seconds: 5000),
            receiveTimeout: const Duration(seconds: 60000),
          ),
        ) {
    interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    _authInterceptor = AuthInterceptor(this);
  }

  CustomDio auth() {
    interceptors.add(_authInterceptor);
    return this;
  }

  CustomDio unauth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
