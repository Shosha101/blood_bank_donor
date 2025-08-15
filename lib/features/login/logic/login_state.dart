import 'package:blood_bank_donor/core/networking/api_error_handler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;

  const factory LoginState.hospitalsLoading() = LoginStateLoading;
  // const factory HospitalsState.hospitalsSuccess(List<HospitalsData?>? specializationDataList) = HospitalsSuccess;
  const factory LoginState.hospitalsError(ErrorHandler errorHandler) = LoginStateError;

  // // Doctors
  // const factory HospitalsState.doctorsSuccess(List<Doctors?>? doctorsList) = DoctorsSuccess;
  // const factory HospitalsState.doctorsError(ErrorHandler errorHandler) = DoctorsError;
}