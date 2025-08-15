


import 'package:blood_bank_donor/features/about/data/api/about_api_service.dart';

class AboutRepo {
  final AboutApiService _aboutApiService;

AboutRepo(this._aboutApiService);

  // Future<ApiResult<HospitalsResponseModel>> getSpecialization() async {
  //   try {
  //     final response = await _hospitalsApiService.getHospitals();
  //     return ApiResult.success(response);
  //   } catch (error) {
  //     return ApiResult.failure(ErrorHandler.handle(error));
  //   }
  // }
}
