import 'package:blood_bank_donor/core/networking/api_result.dart';
import 'package:blood_bank_donor/features/about/data/repo/donor_repo.dart';
import 'package:blood_bank_donor/features/about/logic/donor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonorCubit extends Cubit<DonorState> {
  final DonorRepo _donorRepo;

  DonorCubit(this._donorRepo) : super(const DonorState.initial());

  void getDonorData() async {
    emit(const DonorState.loading());
    final result = await _donorRepo.getDonorData();
    result.when(
      success: (donor) => emit(DonorState.success(donor)),
      failure: (errorHandler) =>
          emit(DonorState.error(errorHandler.apiErrorModel)), // 👈 كده
    );
  }
}
