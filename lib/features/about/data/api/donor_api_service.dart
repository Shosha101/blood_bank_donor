
import 'package:blood_bank_donor/core/networking/api_constants.dart';
import 'package:blood_bank_donor/features/about/data/model/donor_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'donor_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class DonorApiService {
  factory DonorApiService(Dio dio) = _DonorApiService;

  @GET('donor')
  Future<DonorModel> getDonorData();
}