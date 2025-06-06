import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_jwt_models.freezed.dart';
part 'refresh_jwt_models.g.dart';

@freezed
abstract class RefreshJwtResponseModel with _$RefreshJwtResponseModel {
  const factory RefreshJwtResponseModel({
    required String jwt,
    required String refreshToken,
  }) = _RefreshJwtResponseModel;

  factory RefreshJwtResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshJwtResponseModelFromJson(json);
}

@freezed
abstract class RefreshJwtRequestModel with _$RefreshJwtRequestModel {
  const factory RefreshJwtRequestModel({required String token}) =
      _RefreshJwtRequestModel;

  factory RefreshJwtRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshJwtRequestModelFromJson(json);
}
