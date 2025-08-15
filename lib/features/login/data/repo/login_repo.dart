


import 'package:blood_bank_donor/features/login/data/api/login_api_service.dart';

class LoginRepo {
  final LoginApiService _loginApiService;

LoginRepo(this._loginApiService);

  // Future<ApiResult<HospitalsResponseModel>> getSpecialization() async {
  //   try {
  //     final response = await _hospitalsApiService.getHospitals();
  //     return ApiResult.success(response);
  //   } catch (error) {
  //     return ApiResult.failure(ErrorHandler.handle(error));
  //   }
  // }
}
