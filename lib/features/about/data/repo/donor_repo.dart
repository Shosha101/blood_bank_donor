import 'package:blood_bank_donor/core/networking/api_error_handler.dart';
import 'package:blood_bank_donor/core/networking/api_result.dart';
import 'package:blood_bank_donor/features/about/data/api/donor_api_service.dart';
import 'package:blood_bank_donor/features/about/data/model/donor_model.dart';

class DonorRepo {
  final DonorApiService _donorApiService;

  DonorRepo(this._donorApiService);

  Future<ApiResult<DonorModel>> getDonorData() async {
    try {
      final donor = await _donorApiService.getDonorData();
      return ApiResult.success(donor);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error).apiErrorModel);
    }
  }
}
