import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:whoami_app/core/network/service/api_service.dart';

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
  Dio get dio => Dio();

  @singleton
  ApiService get apiService => ApiService(dio);
}
