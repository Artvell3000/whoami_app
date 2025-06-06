import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:whoami_app/core/error/domain_error.dart';
import 'package:whoami_app/core/error/domain_error_mapper.dart';
import 'package:whoami_app/features/user/data/datasourse/user_datasourse.dart';
import 'package:whoami_app/features/user/domain/repository.dart';

@Injectable(as: IUserRepository)
class UserRepository implements IUserRepository {
  UserRepository(this._userDatasourse);

  final UserDatasourse _userDatasourse;

  @override
  Future<Either<DomainError, String>> getUser() async {
    try {
      return Right(await _userDatasourse.getUser());
    } on Exception catch (e) {
      return Left(e.toDomainError());
    }
  }
}
