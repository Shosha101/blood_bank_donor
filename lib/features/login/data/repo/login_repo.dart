
import 'package:blood_bank_donor/core/networking/api_error_handler.dart';
import 'package:blood_bank_donor/core/networking/api_result.dart';
import 'package:blood_bank_donor/features/login/data/api/login_api_service.dart';
import 'package:blood_bank_donor/features/login/data/model/login_request_body.dart';
import 'package:blood_bank_donor/features/login/data/model/login_response.dart';
import 'package:blood_bank_donor/features/login/data/model/logout_response.dart';
import 'package:dio/dio.dart';

class LoginRepo {
  final LoginApiService _loginApiService;

  LoginRepo(this._loginApiService, Dio dio);

  Future<ApiResult<LoginResponse>> login(LoginRequestBody loginRequestBody) async {
    try {
      final response = await _loginApiService.login(loginRequestBody);
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<LogoutResponse>> logout() async {
    try {
      final response = await _loginApiService.logout();
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}