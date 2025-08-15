import 'package:blood_bank_donor/core/di/dependency_injection.dart';
import 'package:blood_bank_donor/core/routing/routes.dart';
import 'package:blood_bank_donor/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blood_bank_donor/features/login/logic/login_cubit.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_cubit.dart';
import 'package:blood_bank_donor/features/about/logic/about_cubit.dart';
import 'package:blood_bank_donor/features/login/ui/login_screen.dart';
import 'package:blood_bank_donor/features/requests/ui/requests_screen.dart';
import 'package:blood_bank_donor/features/about/ui/about_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: LoginScreen(
              onLogin: (context, phone) {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.mainScreen,
                  arguments: phone,
                );
              },
            ),
          ),
        );
      case Routes.mainScreen:
        return MaterialPageRoute(
          builder: (context) => MainScreen(phoneNumber: arguments as String),
        );
      case Routes.requestsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<RequestsCubit>(),
            child: RequestsScreen(phoneNumber: arguments as String?),
          ),
        );
      case Routes.aboutScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AboutCubit>(),
            child: const AboutScreen(),
          ),
        );
      default:
        return null;
    }
  }
}