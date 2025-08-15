

import 'package:blood_bank_donor/core/networking/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


part 'requests_api_service.g.dart';

@RestApi(baseUrl : ApiConstants.apiBaseUrl)
abstract class RequestsApiService {
  factory RequestsApiService(Dio dio) = _RequestsApiService;

  // @GET(HospitalsApiConstants.hospitals)
  // Future<HospitalsResponseModel> getHospitals();
}