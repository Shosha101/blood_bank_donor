import 'package:blood_bank_donor/core/di/dependency_injection.dart';
import 'package:blood_bank_donor/core/routing/app_router.dart';
import 'package:blood_bank_donor/donor_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize dependency injection
  await setupGetIt();
  // Initialize screen util
  await ScreenUtil.ensureScreenSize();
  // Remove splash screen
  FlutterNativeSplash.remove();

  runApp(DonorApp(
    appRouter: AppRouter(),
  ));
}