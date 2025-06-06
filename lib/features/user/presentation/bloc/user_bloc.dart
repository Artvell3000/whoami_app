import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:whoami_app/core/error/domain_error.dart';
import 'package:whoami_app/features/user/domain/repository.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._iUserRepository) : super(UserState.loading()) {
    on<_Started>(_start);
    add(UserEvent.started());
  }

  final IUserRepository _iUserRepository;

  Future<void> _start(_Started event, Emitter<UserState> emit) async {
    final result = await _iUserRepository.getUser();

    result.fold(
      (e) {
        Logger().e(e.toString());
        e.maybeMap(
          orElse: () => emit(UserState.error(e)),
          unauthorized: (d) => emit(UserState.unauth()),
        );
      },
      (userId) {
        emit(UserState.loaded(userId));
      },
    );
  }
}
