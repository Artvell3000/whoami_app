import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whoami_app/core/network/service/token_service_config.dart';

class TokenStorageService {
  TokenStorageService([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  static String? _jwt;
  static String? _refreshToken;
  final String _refreshTokenKey = TokenServiceConfig.refreshTokenKey;
  final FlutterSecureStorage _storage;

  String? get jwt => _jwt;

  Future<String?> get refreshToken async {
    if (_refreshToken != null) {
      return _refreshToken;
    }

    _refreshToken = await _storage.read(key: _refreshTokenKey);
    return _refreshToken;
  }

  Future<void> save(String jwt, String refreshToken) async {
    _jwt = jwt;
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<void> clear() async => await _storage.delete(key: _refreshTokenKey);
}
