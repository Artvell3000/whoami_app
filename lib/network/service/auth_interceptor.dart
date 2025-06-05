import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:whoami_app/network/models/refresh_jwt_models/refresh_jwt_models.dart';
import 'package:whoami_app/network/service/api_service.dart';
import 'package:whoami_app/network/service/token_service.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenService tokenManager;
  final ApiService authApiService;

  AuthInterceptor(this.dio, this.tokenManager, this.authApiService);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final RequestOptions options = err.response!.requestOptions;
      final refreshToken = await tokenManager.refreshToken;

      if (refreshToken == null) {
        await tokenManager.clearTokens();
        return handler.next(err);
      }

      try {
        final refreshResponse = await authApiService.refreshToken(
          RefreshJwtRequestModel(refreshToken: refreshToken),
        );

        await tokenManager.saveTokens(
          refreshResponse.jwt,
          refreshResponse.refreshToken,
        );

        options.headers['Auth'] = 'Bearer ${refreshResponse.jwt}}';
        return handler.resolve(await dio.fetch(options));
      } on DioException catch (refreshError) {
        await tokenManager.clearTokens();
        return handler.next(refreshError);
      }
    }
    super.onError(err, handler);
  }
}
