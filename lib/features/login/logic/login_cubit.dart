// import 'package:blood_bank_donor/core/networking/api_result.dart';
// import 'package:blood_bank_donor/features/login/data/repo/login_repo.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'login_state.freezed.dart';

// @freezed
// class LoginState with _$LoginState {
//   const factory LoginState.initial() = _Initial;
//   const factory LoginState.loading() = _Loading;
//   const factory LoginState.success(int donorId) = _Success;
//   const factory LoginState.error(String message) = _Error;
// }

// class LoginCubit extends Cubit<LoginState> {

//   LoginCubit(this._loginRepo) : super(const LoginState.initial());

//   Future<void> login(String phoneNumber) async {
//     if (isClosed) return;
//     emit(const LoginState.loading());
//   }
// }
