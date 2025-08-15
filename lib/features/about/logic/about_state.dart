import 'package:blood_bank_donor/core/networking/api_error_handler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_state.freezed.dart';

@freezed
class AboutState with _$AboutState {
  const factory AboutState.initial() = _Initial;

  const factory AboutState.hospitalsLoading() = AboutStateStateLoading;
  // const factory HospitalsState.hospitalsSuccess(List<HospitalsData?>? specializationDataList) = HospitalsSuccess;
  const factory AboutState.aboutError(ErrorHandler errorHandler) = AboutStateStateError;

  // // Doctors
  // const factory HospitalsState.doctorsSuccess(List<Doctors?>? doctorsList) = DoctorsSuccess;
  // const factory HospitalsState.doctorsError(ErrorHandler errorHandler) = DoctorsError;
}