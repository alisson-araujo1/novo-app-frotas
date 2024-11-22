import 'package:app_frotas/app/app.dart';
import 'package:app_frotas/app/di/service_locator.dart';
import 'package:app_frotas/app/modules/auth/auth_module.dart';
import 'package:flutter/material.dart';

void main() {
  setupCoreDependencies();
  setupAuthDependencies();
  runApp(const MyApp());
}
