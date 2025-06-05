import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:whoami_app/core/routing/router.dart';
import 'package:whoami_app/features/authentication/presentation/auth_success/widgets/loading_widget.dart';
import 'package:whoami_app/gen_assets/assets.gen.dart';
import 'package:whoami_app/gen_locales/app_localizations.dart';

@RoutePage()
class AuthSuccessScreen extends StatelessWidget {
  const AuthSuccessScreen({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Assets.img.png.successAuth.keyName, height: 231),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 40),
                child: Text(
                  S.authSuccessTitle,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: scheme.primary,
                  ),
                ),
              ),
              AuthSuccessLoadingWidget(
                onComplete: () {
                  if (context.mounted) {
                    router.replace(UserRoute());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
