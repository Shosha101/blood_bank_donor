import 'package:blood_bank_donor/core/networking/api_error_handler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'requests_state.freezed.dart';

@freezed
class RequestsState with _$RequestsState {
  const factory RequestsState.initial() = _Initial;

  const factory RequestsState.requestsLoading() = RequestsStateLoading;
  // const factory HospitalsState.hospitalsSuccess(List<HospitalsData?>? specializationDataList) = HospitalsSuccess;
  const factory RequestsState.hospitalsError(ErrorHandler errorHandler) = RequestsStateError;

  // // Doctors
  // const factory HospitalsState.doctorsSuccess(List<Doctors?>? doctorsList) = DoctorsSuccess;
  // const factory HospitalsState.doctorsError(ErrorHandler errorHandler) = DoctorsError;
}