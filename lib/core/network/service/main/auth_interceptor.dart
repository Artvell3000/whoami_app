// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:whoami_app/core/network/models/refresh_jwt_models/refresh_jwt_models.dart';
import 'package:whoami_app/core/network/service/token/token_api_service.dart';

import 'package:whoami_app/core/network/service/token/token_storage_service.dart';

class AuthInterseptor extends Interceptor {
  AuthInterseptor(this._tokenStorageService, this._tokenApiService);

  final _logger = Logger();
  final TokenStorageService _tokenStorageService;
  final TokenApiService _tokenApiService;

  Future<String?> _refreshJwt() async {
    final refreshToken = await _tokenStorageService.refreshToken;
    if (refreshToken == null) {
      return null;
    } else {
      final response = await _tokenApiService.refreshToken(
        RefreshJwtRequestModel(token: refreshToken),
      );
      return response.jwt;
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? jwt = _tokenStorageService.jwt;
    jwt ??= await _refreshJwt();

    if (jwt == null) {
      _logger.e('Authentication failed: JWT is null after refresh attempt.');
      final dioException = DioException.badResponse(
        requestOptions: options,
        statusCode: 401,
        response: Response(
          requestOptions: options,
          statusCode: 401,
          statusMessage:
              'Unauthorized: Authentication token is missing or invalid.',
          data: {'message': 'Authentication Required'},
        ),
      );
      return handler.reject(dioException);
    } else {
      _logger.i('⬆️ REQUEST[${options.method}] => PATH: ${options.path}');
      _logger.d('Headers: ${options.headers}');
      _logger.d('Data: ${options.data}');

      options.headers['Auth'] = 'Bearer $jwt';

      return handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(
      '⬇️ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    _logger.d('Response: ${response.data}');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      '❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    _logger.e('Error message: ${err.message}');
    _logger.e('Error response: ${err.response?.data}');

    handler.next(err);
  }
}
