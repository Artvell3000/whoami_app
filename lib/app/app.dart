import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:whoami_app/app/theme/theme.dart';
import 'package:whoami_app/core/routing/router.dart';
import 'package:whoami_app/gen_locales/app_localizations.dart';

late AppRouter _router;

class WhoAmIApp extends StatelessWidget {
  const WhoAmIApp({super.key});

  @override
  Widget build(BuildContext context) {
    _router = AppRouter();

    return MaterialApp.router(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: whoAmIAppTheme,
      routerConfig: _router.config(),
    );
  }
}
