import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_models.freezed.dart';
part 'verify_models.g.dart';

@freezed
abstract class VerifyResponseModel with _$VerifyResponseModel {
  const factory VerifyResponseModel({
    required String jwt,
    required String refreshToken,
  }) = _VerifyResponseModel;

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyResponseModelFromJson(json);
}

@freezed
abstract class VerifyRequestModel with _$VerifyRequestModel {
  const factory VerifyRequestModel({
    required String email,
    required String code,
  }) = _VerifyRequestModel;

  factory VerifyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyRequestModelFromJson(json);
}
