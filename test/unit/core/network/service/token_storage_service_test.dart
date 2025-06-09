import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:whoami_app/core/network/service/token/token_storage_service.dart';
import 'package:whoami_app/core/network/service/token_service_config.dart';
import 'mock_flutter_secure_storage.dart';

void main() {
  late TokenStorageService tokenStorageService;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    tokenStorageService = TokenStorageService(mockSecureStorage);
  });

  group('TokenStorageService Tests', () {
    test('jwt getter should return stored JWT', () {
      expect(tokenStorageService.jwt, isNull);
    });

    test('refreshToken getter should return stored refresh token', () async {
      // Arrange
      when(
        () => mockSecureStorage.read(key: TokenServiceConfig.refreshTokenKey),
      ).thenAnswer((_) async => 'test_refresh_token');

      // Act
      final result = await tokenStorageService.refreshToken;

      // Assert
      expect(result, equals('test_refresh_token'));
    });

    test('save should store JWT and refresh token', () async {
      // Arrange
      when(
        () => mockSecureStorage.write(
          key: TokenServiceConfig.refreshTokenKey,
          value: 'test_refresh',
        ),
      ).thenAnswer((_) async => {});

      // Act
      await tokenStorageService.save('test_jwt', 'test_refresh');

      // Assert
      expect(tokenStorageService.jwt, equals('test_jwt'));
      verify(
        () => mockSecureStorage.write(
          key: TokenServiceConfig.refreshTokenKey,
          value: 'test_refresh',
        ),
      ).called(1);
    });

    test('clear should remove stored tokens', () async {
      // Arrange
      when(
        () => mockSecureStorage.delete(key: TokenServiceConfig.refreshTokenKey),
      ).thenAnswer((_) async => {});

      // Act
      await tokenStorageService.clear();

      // Assert
      verify(
        () => mockSecureStorage.delete(key: TokenServiceConfig.refreshTokenKey),
      ).called(1);
    });
  });
}
