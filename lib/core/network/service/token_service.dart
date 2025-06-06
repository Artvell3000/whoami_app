import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:whoami_app/core/network/service/token_service_config.dart';

@injectable
class TokenService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static String? _accessToken;
  static const String _refreshTokenKey = TokenServiceConfig.refreshTokenKey;

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    _accessToken = accessToken;
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  String? get accessToken => _accessToken;

  Future<String?> get refreshToken async =>
      await _storage.read(key: _refreshTokenKey);

  Future<void> clearTokens() async {
    _accessToken = null;
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<bool> hasTokens() async {
    final refreshToken = await _storage.read(key: _refreshTokenKey);
    return _accessToken != null && refreshToken != null;
  }
}
