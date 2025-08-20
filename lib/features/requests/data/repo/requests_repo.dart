import 'package:blood_bank_donor/core/networking/api_error_handler.dart';
import 'package:blood_bank_donor/core/networking/api_result.dart';
import 'package:blood_bank_donor/features/requests/data/api/requests_api_service.dart';
import 'package:blood_bank_donor/features/requests/data/model/request_model.dart';
class RequestsRepo {
  final RequestsApiService _requestsApiService;

  RequestsRepo(this._requestsApiService);

  Future<ApiResult<List<RequestModel>>> getDonationRequests() async {
    try {
      final requests = await _requestsApiService.getDonationRequests();
      return ApiResult.success(requests); // Empty list is valid
    } catch (error) {
      print('Error fetching donation requests: $error'); // Add logging
      return ApiResult.failure(ErrorHandler.handle(error).apiErrorModel);
    }
  }

  Future<ApiResult<bool>> approveDonationRequest(int requestId) async {
    try {
      await _requestsApiService.approveDonationRequest(requestId);
      return const ApiResult.success(true);
    } catch (error) {
      print('Error approving request: $error');
      return ApiResult.failure(ErrorHandler.handle(error).apiErrorModel);
    }
  }

  Future<ApiResult<bool>> rejectDonationRequest(int requestId) async {
    try {
      await _requestsApiService.rejectDonationRequest(requestId);
      return const ApiResult.success(true);
    } catch (error) {
      print('Error rejecting request: $error');
      return ApiResult.failure(ErrorHandler.handle(error).apiErrorModel);
    }
  }
}