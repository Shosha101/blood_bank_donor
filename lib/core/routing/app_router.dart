import 'package:blood_bank_donor/core/di/dependency_injection.dart';
import 'package:blood_bank_donor/core/helpers/shared_preference.dart';
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

    // Store the current route
    _saveCurrentRoute(settings.name, arguments);

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
        return MaterialPageRoute(
          builder: (context) => FutureBuilder<String?>(
            future: SharedPrefHelper.getSecuredString(SharedPrefKeys.phoneNumber),
            builder: (context, snapshot) {
              final phoneNumber = arguments is String ? arguments : snapshot.data ?? 'unknown';
              return MainScreen(phoneNumber: phoneNumber);
            },
          ),
        );
      case Routes.requestsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<RequestsCubit>(),
            child: const RequestsScreen(),
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

  Future<void> _saveCurrentRoute(String? routeName, dynamic arguments) async {
    if (routeName != null && routeName != Routes.initialRoute) {
      await SharedPrefHelper.setSecuredString('currentRoute', routeName);
      debugPrint('Stored currentRoute: $routeName');
      // Map route to selectedIndex
      int selectedIndex;
      switch (routeName) {
        case Routes.aboutScreen:
          selectedIndex = 1;
          break;
        case Routes.requestsScreen:
        case Routes.mainScreen:
        default:
          selectedIndex = 0;
          break;
      }
      await SharedPrefHelper.setSecuredInt(SharedPrefKeys.selectedIndex, selectedIndex);
      debugPrint('Mapped route $routeName to selectedIndex: $selectedIndex');
      // Store phoneNumber if provided
      if (routeName == Routes.mainScreen && arguments is String) {
        await SharedPrefHelper.setSecuredString(SharedPrefKeys.phoneNumber, arguments);
        debugPrint('Stored phoneNumber: $arguments');
      }
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