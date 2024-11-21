import 'package:app_frotas/app/modules/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:app_frotas/app/modules/auth/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final authRoutes = <GoRoute>[
  GoRoute(
    path: '/login',
    builder: (context, state) {
      return BlocProvider(
        create: (_) => LoginCubit(),
        child: const LoginPage(),
      );
    },
  )
];
