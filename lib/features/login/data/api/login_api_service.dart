

import 'package:blood_bank_donor/core/networking/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


part 'login_api_service.g.dart';

@RestApi(baseUrl : ApiConstants.apiBaseUrl)
abstract class LoginApiService {
  factory LoginApiService(Dio dio) = _LoginApiService;

  // @GET(HospitalsApiConstants.hospitals)
  // Future<HospitalsResponseModel> getHospitals();
}