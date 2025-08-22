import 'package:blood_bank_donor/core/networking/api_error_handler.dart';
import 'package:blood_bank_donor/features/login/data/model/login_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = LoginStateLoading;
  const factory LoginState.success(LoginResponse loginResponse, {String? phoneNumber}) = LoginStateSuccess;
  const factory LoginState.logoutSuccess() = LoginStateLogoutSuccess;
  const factory LoginState.error(ErrorHandler errorHandler) = LoginStateError;
}