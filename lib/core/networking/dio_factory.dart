import 'package:blood_bank_donor/core/constants/keys/constants.dart';
import 'package:blood_bank_donor/core/helpers/shared_preference.dart' as pref;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Future<Dio> getDio() async {
    const timeOut = Duration(seconds: 15);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      await addDioHeaders();
      addDioInterceptor();
      return dio!;
    }
    return dio!;
  }

  static Future<void> addDioHeaders() async {
    try {
      String? token = await pref.SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
      debugPrint('Token: $token');
      dio?.options.headers = {
        'Accept': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      };
    } catch (e, stackTrace) {
      debugPrint('Error setting Dio headers: $e\n$stackTrace');
    }
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    debugPrint('Setting token after login: $token');
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static void addDioInterceptor() {
    if (!const bool.fromEnvironment('dart.vm.product')) {
      dio?.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
          logPrint: (message) => debugPrint(message.toString()),
        ),
      );
    }
  }
}