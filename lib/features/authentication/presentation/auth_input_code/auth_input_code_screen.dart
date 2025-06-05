import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:whoami_app/core/routing/router.dart';
import 'package:whoami_app/gen_assets/assets.gen.dart';
import 'package:whoami_app/gen_locales/app_localizations.dart';

@RoutePage()
class AuthInputCodeScreen extends StatelessWidget {
  const AuthInputCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final S = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final router = AutoRouter.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Assets.img.png.inputCode.keyName, height: 231),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 40),
                child: Text(
                  S.authCodeTitle,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: scheme.primary,
                  ),
                ),
              ),
              TextField(decoration: InputDecoration(hintText: S.authCodeHint)),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 11, bottom: 35),
                  child: Text(
                    'error',
                    style: TextStyle(fontSize: 12, color: scheme.error),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  router.replace(AuthSuccessRoute());
                },
                child: Center(child: Text('Verify')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
