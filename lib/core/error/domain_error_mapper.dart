import 'dart:convert';
import 'package:dio/dio.dart';
import 'domain_error.dart';

extension DomainErrorMapper on Exception {
  DomainError toDomainError() {
    return switch (this) {
      DioException e => _mapDioError(e),
      _ => DomainError.unknown(toString()),
    };
  }

  DomainError _mapDioError(DioException error) {
    if (error.type == DioExceptionType.connectionError) {
      return const DomainError.noInternetConnection();
    }

    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;

    if (statusCode == 400 && responseData != null) {
      final Map<String, dynamic> data = responseData is String
          ? json.decode(responseData)
          : responseData;

      if (data['error'] == 'Code is expired') {
        return const DomainError.authCodeExpired();
      }
    }

    return switch (statusCode) {
      400 => const DomainError.badRequest(),
      401 => const DomainError.unauthorized(),
      500 => const DomainError.serverError(),
      _ => DomainError.unknown(error.toString()),
    };
  }
}
