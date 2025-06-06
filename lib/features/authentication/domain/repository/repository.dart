import 'package:fpdart/fpdart.dart';

abstract interface class IAuthRepository {
  Future<Either<Exception, void>> sendCode(String email);
  Future<Either<Exception, void>> verifyCode(String email, String code);
}
