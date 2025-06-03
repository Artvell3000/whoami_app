import 'package:flutter/material.dart';
import 'package:whoami_app/core/routing/router.dart';

late AppRouter appRouter;

class WhoAmIAPP extends StatelessWidget {
  const WhoAmIAPP({super.key});

  @override
  Widget build(BuildContext context) {
    appRouter = AppRouter();
    return MaterialApp.router(routerConfig: appRouter.config());
  }
}
