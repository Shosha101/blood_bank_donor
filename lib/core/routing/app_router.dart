import 'package:blood_bank_donor/core/di/dependency_injection.dart';
import 'package:blood_bank_donor/core/routing/routes.dart';
import 'package:blood_bank_donor/features/about/logic/donor_cubit.dart';
import 'package:blood_bank_donor/features/about/ui/about_screen.dart';
import 'package:blood_bank_donor/features/login/logic/login_cubit.dart';
import 'package:blood_bank_donor/features/login/ui/login_screen.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_cubit.dart';
import 'package:blood_bank_donor/features/requests/ui/requests_screen.dart';
import 'package:blood_bank_donor/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<LoginCubit>(),
            child: LoginScreen(
              onLogin: (context, phone) {
                try {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.mainScreen,
                    arguments: phone,
                  );
                } catch (e, stackTrace) {
                  debugPrint('Error navigating to MainScreen: $e\n$stackTrace');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Navigation failed: $e'),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ),
        );
      case Routes.mainScreen:
        if (arguments is String) {
          return MaterialPageRoute(
            builder: (context) => MainScreen(phoneNumber: arguments),
          );
        }
        return _errorRoute('Invalid arguments for MainScreen');
      case Routes.requestsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<RequestsCubit>(),
            child: RequestsScreen(),
          ),
        );
      case Routes.aboutScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<DonorCubit>(),
            child: const AboutScreen(),
          ),
        );
      default:
        return _errorRoute('Route not found: ${settings.name}');
    }
  }

  MaterialPageRoute _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(child: Text(message)),
      ),
    );
  }
}