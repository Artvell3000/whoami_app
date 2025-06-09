import 'package:injectable/injectable.dart';
import 'package:whoami_app/core/network/models/models.dart';
import 'package:whoami_app/core/network/service/token/token_api_service.dart';

@injectable
class AuthDatasource {
  final TokenApiService _apiService;

  AuthDatasource(this._apiService);

  Future<void> sendCode(String email) async =>
      await _apiService.login(LoginRequestModel(email: email));

  Future<void> verifyCode(String email, String code) async {
    await _apiService.confirmCode(VerifyRequestModel(email: email, code: code));
  }
}
