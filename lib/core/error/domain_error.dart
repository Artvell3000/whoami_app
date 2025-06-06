import 'package:freezed_annotation/freezed_annotation.dart';

part 'domain_error.freezed.dart';

@freezed
sealed class DomainError with _$DomainError {
  const factory DomainError.badRequest() = _BadRequest;
  const factory DomainError.unauthorized() = _Unauthorized;
  const factory DomainError.serverError() = _ServerError;
  const factory DomainError.unknown() = _Unknown;
  const factory DomainError.noInternetConnection() = _NoInternetConnection;
}
