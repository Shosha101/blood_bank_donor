import 'package:blood_bank_donor/core/di/dependency_injection.dart';
import 'package:blood_bank_donor/core/routing/app_router.dart';
import 'package:blood_bank_donor/donor_app.dart';
import 'package:blood_bank_donor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  try {
await Future.wait([
  setupGetIt(),
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ),
  Future(() => ScreenUtil.ensureScreenSize()),
]);
  } finally {
    FlutterNativeSplash.remove();
  }

  FlutterError.onError = (details) {
    debugPrint('FlutterError: ${details.exceptionAsString()}\n${details.stack}');
    // Integrate with Sentry or similar for production
  };

  runApp(DonorApp(appRouter: AppRouter()));
}