import 'package:injectable/injectable.dart';
import 'package:whoami_app/core/network/models/models.dart';
import 'package:whoami_app/core/network/service/api_service.dart';
import 'package:whoami_app/core/network/service/token_service.dart';

@injectable
class AuthDatasource {
  final ApiService _apiService;
  final TokenService _tokenService;

  AuthDatasource(this._apiService, this._tokenService);

  Future<void> sendCode(String email) async =>
      await _apiService.login(LoginRequestModel(email: email));

  Future<void> verifyCode(String email, String code) async {
    final response = await _apiService.confirmCode(
      VerifyRequestModel(email: email, code: code),
    );
    await _tokenService.saveTokens(response.jwt, response.refreshToken);
  }
}
