// import 'package:blood_bank_donor/core/networking/api_error_handler.dart';
// import 'package:blood_bank_donor/core/networking/api_result.dart';
// import 'package:blood_bank_donor/features/login/data/api/login_api_service.dart';

// class LoginRepo {
//   final LoginApiService _loginApiService;

//   LoginRepo(this._loginApiService);

//   Future<ApiResult<int>> login(String phoneNumber) async {
//     try {
//       final donorId = await _loginApiService.login(phoneNumber);
//       return ApiResult.success(donorId);
//     } catch (error) {
//       return ApiResult.failure(ErrorHandler.handle(error).apiErrorModel);
//     }
//   }
// }
