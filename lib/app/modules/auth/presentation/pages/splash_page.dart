import 'package:app_frotas/app/modules/auth/presentation/cubits/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashErrorState) {
          context.go('/login');
        }
      },
      child: const Scaffold(
        body: Center(
          child: Text(
            'Splash Page',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}