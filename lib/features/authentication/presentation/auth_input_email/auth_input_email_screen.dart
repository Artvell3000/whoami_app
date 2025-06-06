import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whoami_app/core/routing/router.dart';
import 'package:whoami_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:whoami_app/features/shared/show_error_func.dart';
import 'package:whoami_app/gen_assets/assets.gen.dart';
import 'package:whoami_app/gen_locales/app_localizations.dart';

@RoutePage()
class AuthInputEmailScreen extends StatefulWidget {
  const AuthInputEmailScreen({super.key});

  @override
  State<AuthInputEmailScreen> createState() => _AuthInputEmailScreenState();
}

class _AuthInputEmailScreenState extends State<AuthInputEmailScreen> {
  final showError = ShowErrorFunc();
  final _loginFormKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final S = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final router = AutoRouter.of(context);
    final bloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.mapOrNull(
          error: (d) {
            showError(context, d.e);
          },
          hasSendCode: (d) {
            if (context.mounted) {
              router.replace(AuthInputCodeRoute());
            }
          },
        );
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Assets.img.png.inputEmail.keyName, height: 231),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 40),
                  child: Text(
                    S.authEmailTitle,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: scheme.primary,
                    ),
                  ),
                ),
                Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(hintText: S.authEmailHint),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.authEmailEmptyError;
                          }
                          if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          ).hasMatch(value)) {
                            return S.authEmailInvalidError;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 35),
                      ElevatedButton(
                        onPressed: () {
                          if (_loginFormKey.currentState!.validate()) {
                            bloc.add(AuthEvent.sendCode(_controller.text));
                          }
                        },
                        child: Center(
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state.mapOrNull(sendingCode: (d) => true) ??
                                  false) {
                                return SizedBox(
                                  height: 23,
                                  width: 23,
                                  child: CircularProgressIndicator(
                                    color: scheme.onPrimary,
                                  ),
                                );
                              }
                              return Text(S.authEmailButtonText);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
