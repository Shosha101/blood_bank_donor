import 'package:blood_bank_donor/core/networking/api_error_handler.dart';
import 'package:blood_bank_donor/core/networking/api_error_model.dart';
import 'package:blood_bank_donor/core/networking/api_result.dart';
import 'package:blood_bank_donor/features/requests/data/api/requests_api_service.dart';
import 'package:blood_bank_donor/features/requests/data/model/request_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RequestsRepo {
  final RequestsApiService _requestsApiService;
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

  RequestsRepo(this._requestsApiService);

  Future<ApiResult<List<RequestModel>>> getDonationRequests() async {
    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        final requests = await _requestsApiService.getDonationRequests();
        debugPrint('Fetched ${requests.length} donation requests');
        return ApiResult.success(requests);
      } catch (error) {
        debugPrint('Attempt $attempt failed: $error');
        if (attempt < _maxRetries && error is DioError && error.type == DioErrorType.connectionError) {
          await Future.delayed(_retryDelay);
          continue;
        }
        return ApiResult.failure(ErrorHandler.handle(error));
      }
    }
          return ApiResult.failure(ErrorHandler.handle('Failed to fetch requests after $_maxRetries attempts'));
 }

  Future<ApiResult<bool>> approveDonationRequest(int requestId) async {
    try {
      await _requestsApiService.approveDonationRequest(requestId);
      debugPrint('Approved request ID: $requestId');
      return const ApiResult.success(true);
    } catch (error) {
      debugPrint('Error approving request: $error');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<bool>> rejectDonationRequest(int requestId) async {
    try {
      await _requestsApiService.rejectDonationRequest(requestId);
      debugPrint('Rejected request ID: $requestId');
      return const ApiResult.success(true);
    } catch (error) {
      debugPrint('Error rejecting request: $error');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}