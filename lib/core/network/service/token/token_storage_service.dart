import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  static String? _jwt;
  static String? _refreshToken;
  String _refreshTokenKey = '******';
  final _storage = FlutterSecureStorage();

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
}
