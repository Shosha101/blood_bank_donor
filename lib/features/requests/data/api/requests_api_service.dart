import 'package:blood_bank_donor/core/networking/api_constants.dart';
import 'package:blood_bank_donor/features/requests/data/model/request_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'requests_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class RequestsApiService {
  factory RequestsApiService(Dio dio) = _RequestsApiService;

  @GET('DonationRequest/donor/{donorId}')
  Future<List<RequestModel>> getDonationRequests(@Path('donorId') int donorId);

  @PUT('DonationRequest/donor/{requestId}/approve')
  Future<void> approveDonationRequest(@Path('requestId') int requestId);

  @PUT('DonationRequest/donor/{requestId}/reject')
  Future<void> rejectDonationRequest(@Path('requestId') int requestId);
}