import 'package:blood_bank_donor/core/helpers/shared_preference.dart';
import 'package:blood_bank_donor/core/routing/app_router.dart';
import 'package:blood_bank_donor/core/routing/routes.dart';
import 'package:blood_bank_donor/features/login/logic/login_cubit.dart';
import 'package:blood_bank_donor/features/login/logic/login_state.dart';
import 'package:blood_bank_donor/features/login/ui/login_screen.dart';
import 'package:blood_bank_donor/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class DonorApp extends StatelessWidget {
  final AppRouter appRouter;
  const DonorApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: GetIt.I<LoginCubit>()),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          Size designSize;
          if (width < 600) {
            designSize = const Size(390, 844); // Mobile
          } else if (width < 900) {
            designSize = const Size(768, 1024); // Tablet
          } else {
            designSize = const Size(1280, 800); // Web
          }

          return ScreenUtilInit(
            designSize: designSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: 'Donor App',
                theme: ThemeData(
                  primaryColor: Colors.redAccent,
                  scaffoldBackgroundColor: Colors.white,
                  textTheme: TextTheme(
                    bodyMedium: TextStyle(fontSize: 16.sp),
                  ),
                ),
                debugShowCheckedModeBanner: false,
                home: FutureBuilder<Map<String, String?>>(
                  future: Future.wait([
                    SharedPrefHelper.getSecuredString('currentRoute'),
                    SharedPrefHelper.getSecuredString(SharedPrefKeys.phoneNumber),
                  ]).then((values) => {
                        'currentRoute': values[0],
                        'phoneNumber': values[1],
                      }),
                  builder: (context, snapshot) {
                    return BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginStateSuccess) {
                          final phoneNumber = state.phoneNumber ?? snapshot.data?['phoneNumber'] ?? 'unknown';
                          final route = snapshot.data?['currentRoute'] ?? Routes.mainScreen;
                          return Navigator(
                            initialRoute: route,
                            onGenerateRoute: (settings) {
                              if (settings.name == Routes.mainScreen) {
                                return MaterialPageRoute(
                                  builder: (context) => MainScreen(phoneNumber: phoneNumber),
                                  settings: settings,
                                );
                              }
                              return appRouter.generateRoute(settings);
                            },
                          );
                        } else if (state is LoginStateLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return LoginScreen(
                            onLogin: (context, phone) {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.mainScreen,
                                arguments: phone,
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
                onGenerateRoute: appRouter.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}