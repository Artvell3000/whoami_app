import 'package:dio/dio.dart';
import 'domain_error.dart';

extension DomainErrorMapper on Exception {
  DomainError toDomainError() {
    return switch (this) {
      DioException e => _mapDioError(e),
      _ => const DomainError.unknown(),
    };
  }

  DomainError _mapDioError(DioException error) {
    if (error.type == DioExceptionType.connectionError) {
      return const DomainError.noInternetConnection();
    }

    final statusCode = error.response?.statusCode;

    return switch (statusCode) {
      400 => const DomainError.badRequest(),
      401 => const DomainError.unauthorized(),
      500 => const DomainError.serverError(),
      _ => const DomainError.unknown(),
    };
  }
} 