import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whoami_app/core/di/di.dart';
import 'package:whoami_app/core/routing/router.dart';
import 'package:whoami_app/features/shared/app_bar.dart';
import 'package:whoami_app/features/shared/show_error_func.dart';
import 'package:whoami_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:whoami_app/gen_assets/assets.gen.dart';
import 'package:whoami_app/gen_locales/app_localizations.dart';
//import 'package:whoami_app/gen_locales/app_localizations.dart';

@RoutePage()
class UserScreen extends StatelessWidget {
  UserScreen({super.key});
  final showError = ShowErrorFunc();

  @override
  Widget build(BuildContext context) {
    final S = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final router = AutoRouter.of(context);

    return BlocProvider(
      create: (context) => getIt<UserBloc>(),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          state.mapOrNull(
            error: (d) => showError(context, d.e),
            unauth: (d) => router.replace(AuthInputEmailRoute()),
          );
        },
        child: Scaffold(
          appBar: WhoAmIAppBar(
            title: S.userAppBarTitle,
            label: S.userAppBarLabel,
            imgProvider: Assets.img.svg.user.keyName,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(Assets.img.png.userPage.keyName, height: 231),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 40),
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        final userId = state.mapOrNull(loaded: (d) => d.userId);

                        if (userId != null) {
                          return Text(
                            "Hello, user $userId!",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: scheme.primary,
                            ),
                          );
                        }

                        return CircularProgressIndicator(color: scheme.primary);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
