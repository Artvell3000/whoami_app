import 'package:flutter/material.dart';
import 'package:whoami_app/core/error/domain_error.dart';
import 'package:whoami_app/core/error/domain_error_mapper_ui.dart';
import 'package:whoami_app/gen_assets/assets.gen.dart';

class ShowErrorFunc {
  Future<void> call(BuildContext context, DomainError e) async {
    final String errorMessage = e.toLocaleMessage(context);

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Assets.img.png.errorDialog.keyName, height: 230),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(errorMessage),
              ),
            ],
          ),
        );
      },
    );
  }
}
