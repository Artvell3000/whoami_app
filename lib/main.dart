import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:whoami_app/app/app.dart';
import 'package:whoami_app/core/di/di.dart';
import 'package:whoami_app/core/network/service/token_service.dart';
import 'package:whoami_app/core/routing/router_start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    configureDependencies();

    final token = await TokenService().refreshToken;
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
