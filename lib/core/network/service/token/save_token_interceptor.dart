import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:whoami_app/core/network/service/token/token_storage_service.dart';

class SaveTokenInterseptor extends Interceptor {
  SaveTokenInterseptor(this._storageService);

  final TokenStorageService _storageService;
  final _logger = Logger();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data is Map) {
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      String? jwt, refreshToken;

      // Проверяем наличие поля 'jwt'
      if (responseData.containsKey('jwt')) {
        jwt = responseData['jwt'];
      }

      // Проверяем наличие поля 'refresh_token'
      if (responseData.containsKey('refresh_token')) {
        refreshToken = responseData['refresh_token'];
      }

      // Сохраняем
      if (jwt != null && refreshToken != null) {
        await _storageService.save(jwt, refreshToken);
      }
    }

    _logger.d(
      '⬇️ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    _logger.d('Response: ${response.data}');

    super.onResponse(response, handler);
  }
}
