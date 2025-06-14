import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:whoami_app/app/app.dart';
import 'package:whoami_app/core/di/di.dart';
import 'package:whoami_app/core/network/service/token/token_storage_service.dart';
import 'package:whoami_app/core/routing/router_start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String withAuthFlag = String.fromEnvironment(
    'WITH_AUTH',
    defaultValue: 'false',
  );

  if (withAuthFlag == 'true') {
    await getIt<TokenStorageService>().clear();
  }

  try {
    configureDependencies();

    final token = await getIt<TokenStorageService>().refreshToken;
    if (token == null) {
      RouterStart.startWithAuth = true;
    }

    runApp(const WhoAmIApp());
  } catch (e, stackTrace) {
    Logger().e('Ошибка при инициализации: $e');
    Logger().e('Stack trace: $stackTrace');
    rethrow;
  }
}
