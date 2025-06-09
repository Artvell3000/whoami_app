import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:whoami_app/core/network/models/models.dart';
import 'package:whoami_app/core/network/service/api_config.dart';

part 'token_api_service.g.dart';

@RestApi(baseUrl: ApiServiceConfig.baseUrl)
abstract class TokenApiService {
  factory TokenApiService(Dio dio, {String? baseUrl}) = _TokenApiService;

  @Headers({"Content-Type": "application/json"})
  @POST("/login")
  Future<void> login(@Body() LoginRequestModel request);

  @Headers({"Content-Type": "application/json"})
  @POST("/confirm_code")
  Future<VerifyResponseModel> confirmCode(@Body() VerifyRequestModel request);

  @Headers({"Content-Type": "application/json"})
  @POST("/refresh_token")
  Future<RefreshJwtResponseModel> refreshToken(
    @Body() RefreshJwtRequestModel request,
  );
}
