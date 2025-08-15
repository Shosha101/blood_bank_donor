
import 'package:blood_bank_donor/features/login/data/repo/login_repo.dart';
import 'package:blood_bank_donor/features/login/logic/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  // List<SpecializationsData?>? specializationsList = [];

  // void getSpecializations() async {
  //   emit(const HomeState.specializationsLoading());
  //   final response = await _homeRepo.getSpecialization();
  //   response.when(
  //     success: (specializationsResponseModel) {
  //       specializationsList =
  //           specializationsResponseModel.specializationDataList ?? [];

  //       // getting the doctors list for the first specialization by default.
  //       getDoctorsList(specializationId: specializationsList?.first?.id);

  //       emit(HomeState.specializationsSuccess(
  //           specializationsResponseModel.specializationDataList));
  //     },
  //     failure: (errorHandler) {
  //       emit(HomeState.specializationsError(errorHandler));
  //     },
  //   );
  // }

  // void getDoctorsList({required int? specializationId}) {
  //   List<Doctors?>? doctorsList =
  //       getDoctorsListBySpecializationId(specializationId);

  //   if (!doctorsList.isNullOrEmpty()) {
  //     emit(HomeState.doctorsSuccess(doctorsList));
  //   } else {
  //     emit(HomeState.doctorsError(ErrorHandler.handle('No doctors found')));
  //   }
  // }

  // /// returns the list of doctors based on the specialization id
  // getDoctorsListBySpecializationId(specializationId) {
  //   return specializationsList
  //       ?.firstWhere((specialization) => specialization?.id == specializationId)
  //       ?.doctorsList;
  // }
}
