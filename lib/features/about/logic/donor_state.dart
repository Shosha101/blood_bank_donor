
import 'package:blood_bank_donor/core/networking/api_error_model.dart';
import 'package:blood_bank_donor/features/about/data/model/donor_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'donor_state.freezed.dart';

@freezed
class DonorState with _$DonorState {
  const factory DonorState.initial() = _Initial;
  const factory DonorState.loading() = DonorStateLoading;
  const factory DonorState.success(DonorModel donor) = DonorStateSuccess;
  const factory DonorState.error(ApiErrorModel error) = DonorStateError;
}