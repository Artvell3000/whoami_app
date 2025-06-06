import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:whoami_app/core/network/models/models.dart';
import 'package:whoami_app/core/network/service/api_config.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiServiceConfig.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

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

  @GET("/auth")
  Future<AuthResponseModel> getUserId(@Header("Auth") String auth);
}
