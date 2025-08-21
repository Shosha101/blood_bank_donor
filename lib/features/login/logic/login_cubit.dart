import 'dart:io';

import 'package:blood_bank_donor/core/helpers/shared_preference.dart';
import 'package:blood_bank_donor/core/networking/api_constants.dart';
import 'package:blood_bank_donor/core/networking/api_error_handler.dart';
import 'package:blood_bank_donor/core/networking/api_result.dart';
import 'package:blood_bank_donor/core/networking/dio_factory.dart';
import 'package:blood_bank_donor/features/login/data/model/login_request_body.dart';
import 'package:blood_bank_donor/features/login/data/repo/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(const LoginState.initial());

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
            await SharedPrefHelper.setSecuredString('userId', loginResponse.userId.toString());
          }

          try {
            final dio = await DioFactory.getDio();
            final profileResponse = await dio.get('/user/profile');
            final hospitalId = profileResponse.data['id']?.toString();
            if (hospitalId != null) {
              await SharedPrefHelper.setSecuredString('hospitalId', hospitalId);
              debugPrint('Stored hospitalId: $hospitalId');
            }
          } catch (e) {
            debugPrint('Error fetching hospitalId: $e');
          }

          if (!kIsWeb && DioFactory.cookieJar != null) {
            final cookies = await DioFactory.cookieJar!.loadForRequest(
              Uri.parse('http://hemolink.runasp.net/api'),
            );
            final authCookie = cookies.firstWhere(
              (cookie) => cookie.name == '.AspNetCore.Cookies',
              orElse: () => Cookie('.AspNetCore.Cookies', ''),
            );
            if (authCookie.value.isNotEmpty) {
              debugPrint('Stored .AspNetCore.Cookies: ${authCookie.value}');
              await SharedPrefHelper.setSecuredString(
                SharedPrefKeys.userToken,
                authCookie.value,
              );
            }
          }

          emit(LoginState.success(loginResponse));
        },
        failure: (error) {
          debugPrint('Login error: ${error.apiErrorModel.message}');
          emit(LoginState.error(error));
        },
      );
    } catch (e) {
      debugPrint('Unexpected login error: $e');
      emit(LoginState.error(ErrorHandler.handle( e.toString())));
    }
  }

  Future<void> logout() async {
    emit(const LoginState.loading());
    try {
      debugPrint('Sending logout request to: ${ApiConstants.apiBaseUrl}user/logout');
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
      emit(LoginState.error(ErrorHandler.handle( e.toString())));
    }
  }
}