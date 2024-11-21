import 'package:app_frotas/app/modules/auth/presentation/cubits/splash_cubit.dart';
import 'package:app_frotas/app/modules/auth/presentation/pages/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> mainRoutes = [
  GoRoute(
    path: '/splash',
    builder: (context, state) {
      return BlocProvider(
        create: (context) => SplashCubit(),
        child: const SplashPage(),
      );
    },
  )
];
