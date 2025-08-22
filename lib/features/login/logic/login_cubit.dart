import 'dart:io';
import 'package:blood_bank_donor/core/helpers/shared_preference.dart';
import 'package:blood_bank_donor/core/networking/api_constants.dart';
import 'package:blood_bank_donor/core/networking/api_error_handler.dart';
import 'package:blood_bank_donor/core/networking/api_result.dart';
import 'package:blood_bank_donor/core/networking/dio_factory.dart';
import 'package:blood_bank_donor/features/login/data/model/login_request_body.dart';
import 'package:blood_bank_donor/features/login/data/model/login_response.dart';
import 'package:blood_bank_donor/features/login/data/repo/login_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(const LoginState.initial()) {
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    emit(const LoginState.loading());
    final userId = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userId);
    final phoneNumber = await SharedPrefHelper.getSecuredString(SharedPrefKeys.phoneNumber);
    final authCookie = await SharedPrefHelper.getSecuredString(SharedPrefKeys.authCookie);
    debugPrint('Restoring session: userId=$userId, phoneNumber=$phoneNumber, authCookie=$authCookie');
    if (userId != null && int.tryParse(userId) != null && phoneNumber != null) {
      try {
        final dio = await DioFactory.getDio();
        // Use stored cookie or rely on browser cookies
        if (kIsWeb && authCookie != null && authCookie.isNotEmpty) {
          dio.options.headers['Cookie'] = '.AspNetCore.Cookies=$authCookie';
          debugPrint('Sending Cookie: .AspNetCore.Cookies=$authCookie');
        } else if (kIsWeb) {
          debugPrint('No stored authCookie, relying on browser cookies');
        }
        // Use /donor instead of /DonationRequest/donor/available-requests
        final response = await dio.get('/donor');
        if (response.statusCode == 200) {
          emit(LoginState.success(LoginResponse(
            userId: int.parse(userId),
            message: 'Session restored',
            token: authCookie ?? '',
          )));
          debugPrint('Session restored successfully for userId: $userId, phoneNumber: $phoneNumber');
        } else if (response.statusCode == 401) {
          await SharedPrefHelper.clearAllSecuredData();
          debugPrint('Session invalid (401), cleared SharedPreferences');
          emit(const LoginState.initial());
        } else {
          debugPrint('Session validation failed: ${response.statusCode}');
          emit(const LoginState.initial());
        }
      } catch (e) {
        debugPrint('Session restoration failed: $e');
        emit(const LoginState.initial());
      }
    } else {
      debugPrint('No valid session data found: userId=$userId, phoneNumber=$phoneNumber');
      emit(const LoginState.initial());
    }
  }

  Future<void> login(String phoneNumber, String password) async {
    emit(const LoginState.loading());
    try {
      final response = await _loginRepo.login(
        LoginRequestBody(phoneNumber: phoneNumber, password: password),
      );
      response.when(
        success: (loginResponse) async {
          debugPrint('Login response: $loginResponse');
          if (loginResponse.userId != null) {
            await SharedPrefHelper.setSecuredString(
              SharedPrefKeys.userId,
              loginResponse.userId.toString(),
            );
            await SharedPrefHelper.setSecuredString(
              SharedPrefKeys.phoneNumber,
              phoneNumber,
            );
            debugPrint('Stored phoneNumber: $phoneNumber');
          }
          // Store cookie for web
          String? cookieValue;
          if (kIsWeb) {
            final dio = await DioFactory.getDio();
            final response = await dio.post(
              '/user/login',
              data: LoginRequestBody(phoneNumber: phoneNumber, password: password).toJson(),
            );
            final cookies = response.headers['set-cookie'];
            final authCookie = cookies?.firstWhere(
              (cookie) => cookie.contains('.AspNetCore.Cookies'),
              orElse: () => '',
            );
            if (authCookie != null && authCookie.isNotEmpty) {
              cookieValue = authCookie.split(';').first.split('=').last;
              await SharedPrefHelper.setSecuredString(
                SharedPrefKeys.authCookie,
                cookieValue,
              );
              debugPrint('Stored .AspNetCore.Cookies: $cookieValue');
            } else {
              debugPrint('No set-cookie header in /user/login response');
            }
          } else if (DioFactory.cookieJar != null) {
            final cookies = await DioFactory.cookieJar!.loadForRequest(
              Uri.parse(ApiConstants.apiBaseUrl),
            );
            final authCookie = cookies.firstWhere(
              (cookie) => cookie.name == '.AspNetCore.Cookies',
              orElse: () => Cookie('.AspNetCore.Cookies', ''),
            );
            if (authCookie.value.isNotEmpty) {
              cookieValue = authCookie.value;
              debugPrint('Stored .AspNetCore.Cookies: $cookieValue');
              await SharedPrefHelper.setSecuredString(
                SharedPrefKeys.userToken,
                cookieValue,
              );
            }
          }
          emit(LoginState.success(loginResponse.copyWith(token: cookieValue)));
        },
        failure: (error) {
          debugPrint('Login error: ${error.apiErrorModel.message}');
          emit(LoginState.error(error));
        },
      );
    } catch (e) {
      debugPrint('Unexpected login error: $e');
      emit(LoginState.error(ErrorHandler.handle(e.toString())));
    }
  }

  Future<void> logout() async {
    emit(const LoginState.loading());
    try {
      debugPrint('Processing logout');
      final response = await _loginRepo.logout();
      response.when(
        success: (message) async {
          debugPrint('Logout successful: $message');
          await SharedPrefHelper.clearAllSecuredData();
          DioFactory.resetDio();
          if (!kIsWeb && DioFactory.cookieJar != null) {
            debugPrint('Deleting cookies');
            await DioFactory.cookieJar!.deleteAll();
          }
          emit(const LoginState.logoutSuccess());
        },
        failure: (error) {
          debugPrint('Logout error: ${error.apiErrorModel.message}');
          emit(LoginState.error(error));
        },
      );
    } catch (e) {
      debugPrint('Unexpected logout error: $e');
      emit(LoginState.error(ErrorHandler.handle(e.toString())));
    }
  }
}