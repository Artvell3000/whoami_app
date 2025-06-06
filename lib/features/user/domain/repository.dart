import 'package:fpdart/fpdart.dart';
import 'package:whoami_app/core/error/domain_error.dart';

abstract interface class IUserRepository {
  Future<Either<DomainError, String>> getUser();
}
