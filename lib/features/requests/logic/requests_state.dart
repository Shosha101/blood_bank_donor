import 'package:blood_bank_donor/core/networking/api_error_handler.dart';
import 'package:blood_bank_donor/core/networking/api_error_model.dart';
import 'package:blood_bank_donor/features/requests/data/model/request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'requests_state.freezed.dart';

@freezed
class RequestsState with _$RequestsState {
  const factory RequestsState.initial() = _Initial;
  const factory RequestsState.loading() = RequestsStateLoading;
  const factory RequestsState.success(List<RequestModel> requests) = RequestsStateSuccess;
  const factory RequestsState.error(ErrorHandler error) = RequestsStateError;
}