import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:whoami_app/core/network/models/auth_models/auth_models.dart';
import 'package:whoami_app/core/network/service/main/main_api_service.dart';

class MockMainApiService extends Mock implements MainApiService {}

void main() {
  late MockMainApiService mockMainApiService;

  setUp(() {
    mockMainApiService = MockMainApiService();
  });

  group('MainApiService Tests', () {
    test('getUserId should return AuthResponseModel', () async {
      // Arrange
      when(() => mockMainApiService.getUserId()).thenAnswer(
        (_) async => const AuthResponseModel(userId: 'test_user_id'),
      );

      // Act
      final result = await mockMainApiService.getUserId();

      // Assert
      expect(result, isA<AuthResponseModel>());
      expect(result.userId, equals('test_user_id'));
      verify(() => mockMainApiService.getUserId()).called(1);
    });
  });
}
