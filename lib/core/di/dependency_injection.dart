import 'package:blood_bank_donor/core/networking/dio_factory.dart';
import 'package:blood_bank_donor/features/about/data/api/donor_api_service.dart';
import 'package:blood_bank_donor/features/about/data/repo/donor_repo.dart';
import 'package:blood_bank_donor/features/about/logic/donor_cubit.dart';
import 'package:blood_bank_donor/features/login/data/api/login_api_service.dart';
import 'package:blood_bank_donor/features/login/data/repo/login_repo.dart';
import 'package:blood_bank_donor/features/login/logic/login_cubit.dart';
import 'package:blood_bank_donor/features/requests/data/api/requests_api_service.dart';
import 'package:blood_bank_donor/features/requests/data/repo/requests_repo.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  try {
    // Dio
    Dio dio = await DioFactory.getDio();
    getIt.registerSingleton<Dio>(dio);


    // Login
    getIt.registerLazySingleton<LoginApiService>(() => LoginApiService(dio));
    getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt<LoginApiService>(), dio));
    getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt<LoginRepo>()));

    // Donor
    getIt.registerLazySingleton<DonorApiService>(() => DonorApiService(dio));
    getIt.registerLazySingleton<DonorRepo>(() => DonorRepo(getIt<DonorApiService>()));
    getIt.registerLazySingleton<DonorCubit>(() => DonorCubit(getIt<DonorRepo>()));

    // Requests
    getIt.registerLazySingleton<RequestsApiService>(() => RequestsApiService(dio));
    getIt.registerLazySingleton<RequestsRepo>(() => RequestsRepo(getIt<RequestsApiService>()));
    getIt.registerLazySingleton<RequestsCubit>(() => RequestsCubit(getIt<RequestsRepo>()));
  } catch (e, stackTrace) {
    debugPrint('DI Setup Error: $e\n$stackTrace');
    // Optionally integrate with a crash reporting tool like Sentry
  }
}
