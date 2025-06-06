import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:whoami_app/features/authentication/data/datasource/auth_datasource.dart';
import 'package:whoami_app/features/authentication/domain/repository/repository.dart';

@Injectable(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepository(this._authDatasource);

  @override
  Future<Either<Exception, void>> sendCode(String email) async {
    try {
      return Right(await _authDatasource.sendCode(email));
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, void>> verifyCode(String email, String code) async {
    try {
      return Right(await _authDatasource.verifyCode(email, code));
    } on Exception catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
