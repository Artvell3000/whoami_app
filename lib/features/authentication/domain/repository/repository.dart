import 'package:fpdart/fpdart.dart';
import 'package:whoami_app/core/error/domain_error.dart';

abstract interface class IAuthRepository {
  Future<Either<DomainError, void>> sendCode(String email);
  Future<Either<DomainError, void>> verifyCode(String email, String code);
}
