part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.sendingCode() = _SendingCode;

  const factory AuthState.verifyingCode() = _VerifyingCode;

  const factory AuthState.hasSendCode() = _HasSendCode;

  const factory AuthState.successVerifyCode() = _SuccessVerifyCode;

  const factory AuthState.unsuccessVerifyCode() = _UnsuccessVerifyCode;

  const factory AuthState.error(DomainError e) = _Error;
}
