import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:whoami_app/core/network/models/models.dart';
import 'package:whoami_app/core/network/service/token/token_api_service.dart';

class MockTokenApiService extends Mock implements TokenApiService {}

void main() {
  late MockTokenApiService mockTokenApiService;

  setUp(() {
    mockTokenApiService = MockTokenApiService();
  });

  group('TokenApiService Tests', () {
    test('login should complete successfully', () async {
      // Arrange
      final loginRequest = LoginRequestModel(email: 'test@example.com');
      when(
        () => mockTokenApiService.login(loginRequest),
      ).thenAnswer((_) async => {});

      // Act & Assert
      expect(() => mockTokenApiService.login(loginRequest), completes);
    });

    test('confirmCode should return VerifyResponseModel', () async {
      // Arrange
      final verifyRequest = VerifyRequestModel(
        email: 'test@example.com',
        code: '123456',
      );
      when(() => mockTokenApiService.confirmCode(verifyRequest)).thenAnswer(
        (_) async => const VerifyResponseModel(
          jwt: 'test_jwt',
          refreshToken: 'test_refresh_token',
        ),
      );

      // Act
      final result = await mockTokenApiService.confirmCode(verifyRequest);

      // Assert
      expect(result, isA<VerifyResponseModel>());
      expect(result.jwt, equals('test_jwt'));
      expect(result.refreshToken, equals('test_refresh_token'));
      verify(() => mockTokenApiService.confirmCode(verifyRequest)).called(1);
    });

    test('refreshToken should return RefreshJwtResponseModel', () async {
      // Arrange
      final refreshRequest = RefreshJwtRequestModel(token: 'old_refresh_token');
      when(() => mockTokenApiService.refreshToken(refreshRequest)).thenAnswer(
        (_) async => const RefreshJwtResponseModel(
          jwt: 'new_jwt',
          refreshToken: 'new_refresh_token',
        ),
      );

      // Act
      final result = await mockTokenApiService.refreshToken(refreshRequest);

      // Assert
      expect(result, isA<RefreshJwtResponseModel>());
      expect(result.jwt, equals('new_jwt'));
      expect(result.refreshToken, equals('new_refresh_token'));
      verify(() => mockTokenApiService.refreshToken(refreshRequest)).called(1);
    });
  });
}
