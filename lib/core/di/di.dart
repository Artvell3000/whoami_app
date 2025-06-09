import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:whoami_app/core/network/service/main/auth_interceptor.dart';
import 'package:whoami_app/core/network/service/main/main_api_service.dart';
import 'package:whoami_app/core/network/service/token/save_token_interceptor.dart';
import 'package:whoami_app/core/network/service/token/token_api_service.dart';
import 'package:whoami_app/core/network/service/token/token_storage_service.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() {
  init(getIt);
}

@module
abstract class NetworkModule {
  @singleton
  TokenApiService get tokenApiService => TokenApiService(
    Dio()..interceptors.add(SaveTokenInterseptor(tokenStorageService)),
  );

  @singleton
  TokenStorageService get tokenStorageService => TokenStorageService();

  @singleton
  MainApiService get mainApoService => MainApiService(
    Dio()
      ..interceptors.add(AuthInterseptor(tokenStorageService, tokenApiService)),
  );
}
