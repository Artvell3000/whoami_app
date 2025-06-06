import 'package:flutter/material.dart';
import 'package:whoami_app/core/error/domain_error.dart';
import 'package:whoami_app/core/error/domain_error_mapper_ui.dart';

class ShowErrorFunc {
  Future<void> call(BuildContext context, DomainError e) async {
    final String errorMessage = e.toLocaleMessage(context);

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(content: Text(errorMessage));
      },
    );
  }
}
