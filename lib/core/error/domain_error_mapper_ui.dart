import 'package:flutter/material.dart';
import 'package:whoami_app/gen_locales/app_localizations.dart';
import 'domain_error.dart';

extension DomainErrorUI on DomainError {
  String toLocaleMessage(BuildContext context) {
    final S = AppLocalizations.of(context);

    return when(
      authCodeExpired: () => S.errorAuthCodeExpired,
      noInternetConnection: () => S.errorNoInternetConnection,
      badRequest: () => S.errorBadRequest,
      unauthorized: () => S.errorUnauthorized,
      serverError: () => S.errorServer,
      unknown: (e) => S.errorUnknown,
    );
  }
}
