part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;

  const factory UserState.loading() = _Loding;

  const factory UserState.loaded(String userId) = _Loaded;

  const factory UserState.unauth() = _Unauth;

  const factory UserState.error(DomainError e) = _Error;
}
