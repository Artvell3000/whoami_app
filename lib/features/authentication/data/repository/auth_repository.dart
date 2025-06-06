import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:whoami_app/core/error/domain_error.dart';
import 'package:whoami_app/core/error/domain_error_mapper.dart';
import 'package:whoami_app/features/authentication/data/datasource/auth_datasource.dart';
import 'package:whoami_app/features/authentication/domain/repository/repository.dart';

@Injectable(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepository(this._authDatasource);

  @override
  Future<Either<DomainError, void>> sendCode(String email) async {
    try {
      return Right(await _authDatasource.sendCode(email));
    } on Exception catch (e) {
      return Left(e.toDomainError());
    }
  }

  @override
  Future<Either<DomainError, void>> verifyCode(String email, String code) async {
    try {
      return Right(await _authDatasource.verifyCode(email, code));
    } on Exception catch (e) {
      return Left(e.toDomainError());
    }
  }
}
