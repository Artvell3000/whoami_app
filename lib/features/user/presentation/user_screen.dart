import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:whoami_app/gen_assets/assets.gen.dart';
//import 'package:whoami_app/gen_locales/app_localizations.dart';

@RoutePage()
class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final S = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

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
                  "Hello, user 123!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: scheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
