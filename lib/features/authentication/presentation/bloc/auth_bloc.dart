import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:whoami_app/core/error/domain_error.dart';
import 'package:whoami_app/features/authentication/domain/repository/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._iAuthRepository) : super(_Initial()) {
    on<_SendCode>(_sendCode);
    on<_VerifyCode>(_verifyCode);
  }

  final IAuthRepository _iAuthRepository;
  late final String _email;

  Future<void> _sendCode(_SendCode event, Emitter<AuthState> emit) async {
    emit(AuthState.sendingCode());
    final result = await _iAuthRepository.sendCode(event.email);
    result.fold(
      (e) {
        emit(AuthState.error(e));
      },
      (_) {
        _email = event.email;
        emit(AuthState.hasSendCode());
      },
    );
  }

  Future<void> _verifyCode(_VerifyCode event, Emitter<AuthState> emit) async {
    emit(AuthState.verifyingCode());
    final result = await _iAuthRepository.verifyCode(_email, event.code);
    result.fold(
      (e) {
        emit(AuthState.error(e));
      },
      (_) {
        emit(AuthState.successVerifyCode());
      },
    );
  }
}
