import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:whoami_app/core/network/models/refresh_jwt_models/refresh_jwt_models.dart';
import 'package:whoami_app/core/network/service/api_service.dart';
import 'package:whoami_app/core/network/service/token_service.dart';

@injectable
class UserDatasourse {
  final ApiService _apiService;
  final TokenService _tokenService;

  UserDatasourse(this._apiService, this._tokenService);

  Future<String> getUser() async {
    var token = _tokenService.accessToken;
    if (token == null) {
      final rt = await _tokenService.refreshToken;
      Logger().i('refresh token : $rt');
      final response = await _apiService.refreshToken(
        RefreshJwtRequestModel(token: rt ?? ''),
      );
      await _tokenService.saveTokens(response.jwt, response.refreshToken);
      token = response.jwt;
    }

    final response = await _apiService.getUserId('Bearer $token');
    return response.userId;
  }
}
