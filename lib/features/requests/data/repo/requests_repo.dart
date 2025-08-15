


import 'package:blood_bank_donor/features/requests/data/api/requests_api_service.dart';

class RequestsRepo {
  final RequestsApiService _requestsApiService;

RequestsRepo(this._requestsApiService);

  // Future<ApiResult<HospitalsResponseModel>> getSpecialization() async {
  //   try {
  //     final response = await _hospitalsApiService.getHospitals();
  //     return ApiResult.success(response);
  //   } catch (error) {
  //     return ApiResult.failure(ErrorHandler.handle(error));
  //   }
  // }
}
