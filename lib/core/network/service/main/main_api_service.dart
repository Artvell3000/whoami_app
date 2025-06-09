import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:whoami_app/core/network/models/models.dart';
import 'package:whoami_app/core/network/service/api_config.dart';

part 'main_api_service.g.dart';

@RestApi(baseUrl: ApiServiceConfig.baseUrl)
abstract class MainApiService {
  factory MainApiService(Dio dio, {String? baseUrl}) = _MainApiService;

  @GET("/auth")
  Future<AuthResponseModel> getUserId();
}
