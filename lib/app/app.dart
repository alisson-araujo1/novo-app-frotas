import 'package:app_frotas/app/routes/main_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _goRouter = GoRouter(
    initialLocation: '/splash',
    routes: [
      ...mainRoutes,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'App Frotas',
      routerConfig: _goRouter,
    );
  }
}
