import 'package:flutter/material.dart';
import 'package:whoami_app/app/theme/theme.dart';
import 'package:whoami_app/core/routing/router.dart';

late final AppRouter _appRouter;

class WhoAmIApp extends StatelessWidget {
  const WhoAmIApp({super.key});

  @override
  Widget build(BuildContext context) {
    _appRouter = AppRouter();
    return MaterialApp.router(
      theme: whoAmIAppTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
