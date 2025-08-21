
import 'package:blood_bank_donor/core/networking/api_constants.dart';
import 'package:blood_bank_donor/features/login/data/model/login_request_body.dart';
import 'package:blood_bank_donor/features/login/data/model/login_response.dart';
import 'package:blood_bank_donor/features/login/data/model/logout_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'login_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class LoginApiService {
  factory LoginApiService(Dio dio, {String? baseUrl}) = _LoginApiService;

  @POST('/user/login')
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);

  @POST('/user/logout')
  Future<LogoutResponse> logout();
}