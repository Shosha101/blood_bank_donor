

import 'package:blood_bank_donor/core/networking/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


part 'about_api_service.g.dart';

@RestApi(baseUrl : ApiConstants.apiBaseUrl)
abstract class AboutApiService {
  factory AboutApiService(Dio dio) = _AboutApiService;

  // @GET(HospitalsApiConstants.hospitals)
  // Future<HospitalsResponseModel> getHospitals();
}