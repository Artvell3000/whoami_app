import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whoami_app/core/di/di.dart';
import 'package:whoami_app/features/shared/app_bar.dart';
import 'package:whoami_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:whoami_app/gen_assets/assets.gen.dart';
import 'package:whoami_app/gen_locales/app_localizations.dart';

@RoutePage()
class AuthShellScreen extends StatelessWidget {
  const AuthShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final S = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Scaffold(
        appBar: WhoAmIAppBar(
          title: S.authAppBarTitle,
          label: S.authAppBarLabel,
          imgProvider: Assets.img.svg.user.keyName,
        ),
        body: AutoRouter(),
      ),
    );
  }
}
