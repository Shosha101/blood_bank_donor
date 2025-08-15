import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_bank_donor/core/routing/app_router.dart';
import 'package:blood_bank_donor/core/routing/routes.dart';

class DonorApp extends StatelessWidget {
  final AppRouter appRouter;

  const DonorApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Blood Bank Donor',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          initialRoute: Routes.initialRoute,
          onGenerateRoute: appRouter.generateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}