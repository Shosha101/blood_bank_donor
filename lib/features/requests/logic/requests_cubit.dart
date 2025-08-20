import 'package:blood_bank_donor/core/networking/api_result.dart';
import 'package:blood_bank_donor/features/requests/data/repo/requests_repo.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsCubit extends Cubit<RequestsState> {
  final RequestsRepo _requestsRepo;

  RequestsCubit(this._requestsRepo) : super(const RequestsState.initial());

  void getDonationRequests() async {
    emit(const RequestsState.loading());
    final result = await _requestsRepo.getDonationRequests();
    result.when(
      success: (requests) => emit(RequestsState.success(requests)),
      failure: (error) => emit(RequestsState.error(error)),
    );
  }

  void approveDonationRequest(int requestId) async {
    emit(const RequestsState.loading());
    final result = await _requestsRepo.approveDonationRequest(requestId);
    result.when(
      success: (_) => getDonationRequests(),
      failure: (error) => emit(RequestsState.error(error)),
    );
  }

  void rejectDonationRequest(int requestId) async {
    emit(const RequestsState.loading());
    final result = await _requestsRepo.rejectDonationRequest(requestId);
    result.when(
      success: (_) => getDonationRequests(),
      failure: (error) => emit(RequestsState.error(error)),
    );
  }
}