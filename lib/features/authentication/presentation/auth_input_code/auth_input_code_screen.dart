import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whoami_app/core/routing/router.dart';
import 'package:whoami_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:whoami_app/features/shared/show_error_func.dart';
import 'package:whoami_app/gen_assets/assets.gen.dart';
import 'package:whoami_app/gen_locales/app_localizations.dart';

@RoutePage()
class AuthInputCodeScreen extends StatefulWidget {
  const AuthInputCodeScreen({super.key});

  @override
  State<AuthInputCodeScreen> createState() => _AuthInputCodeScreenState();
}

class _AuthInputCodeScreenState extends State<AuthInputCodeScreen> {
  final _showError = ShowErrorFunc();
  final _controller = TextEditingController();
  final _verifyFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final S = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final router = AutoRouter.of(context);
    final bloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.mapOrNull(
          successVerifyCode: (d) {
            if (context.mounted) {
              router.replace(AuthSuccessRoute());
            }
          },
          unsuccessVerifyCode: (d) {
            if (context.mounted) {
              router.replace(AuthInputEmailRoute());
            }
          },
          error: (d) {
            if (context.mounted) {
              _showError(context, d.e);
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
                Form(
                  key: _verifyFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: true,
                        controller: _controller,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(hintText: S.authCodeHint),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.authCodeEmptyError;
                          }
                          if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                            return S.authCodeInvalidError;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 35),
                      ElevatedButton(
                        onPressed: () {
                          bloc.add(AuthEvent.verifyCode(_controller.text));
                        },

                        child: Center(
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state.mapOrNull(verifyingCode: (d) => true) ??
                                  false) {
                                return SizedBox(
                                  height: 23,
                                  width: 23,
                                  child: CircularProgressIndicator(
                                    color: scheme.onPrimary,
                                  ),
                                );
                              }

                              return Text(S.authCodeButtonText);
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
