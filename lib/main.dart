import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:whoami_app/app/app.dart';
import 'package:whoami_app/core/di/di.dart';
import 'package:whoami_app/network/service/auth_interceptor.dart';

void main() {
  configureDependencies();

  getIt<Dio>().interceptors.add(getIt<AuthInterceptor>());

  runApp(const WhoAmIApp());
}
