// Renders the redesigned screens off-screen with sample data, in Arabic and English.
// Run: flutter test --update-goldens tool/screens_golden_test.dart  (PNGs land in tool/shots/)
import 'dart:io';

import 'package:blood_bank_donor/core/theming/app_theme.dart';
import 'package:blood_bank_donor/features/about/data/model/donor_model.dart';
import 'package:blood_bank_donor/features/about/logic/donor_cubit.dart';
import 'package:blood_bank_donor/features/about/logic/donor_state.dart';
import 'package:blood_bank_donor/features/login/logic/login_cubit.dart';
import 'package:blood_bank_donor/features/login/logic/login_state.dart';
import 'package:blood_bank_donor/features/login/ui/login_screen.dart';
import 'package:blood_bank_donor/features/requests/data/model/request_model.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_cubit.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_state.dart';
import 'package:blood_bank_donor/main_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeLoginCubit extends Cubit<LoginState> implements LoginCubit {
  FakeLoginCubit() : super(const LoginState.initial());
  @override
  Future<void> login(String phoneNumber, String password) async {}
  @override
  Future<void> logout() async {}
}

class FakeRequestsCubit extends Cubit<RequestsState> implements RequestsCubit {
  FakeRequestsCubit(this.seed) : super(const RequestsState.initial());
  final List<RequestModel> seed;
  @override
  void getDonationRequests() => emit(RequestsState.success(seed));
  @override
  void approveDonationRequest(int requestId) {}
  @override
  void rejectDonationRequest(int requestId) {}
}

class FakeDonorCubit extends Cubit<DonorState> implements DonorCubit {
  FakeDonorCubit(this.donor) : super(const DonorState.initial());
  final DonorModel donor;
  @override
  void getDonorData() => emit(DonorState.success(donor));
}

RequestModel request(int id, String hospital, String area, String type, String date, bool? status) =>
    RequestModel(
      donorDonationRequestId: id,
      hospitalName: hospital,
      bloodTypeName: type,
      areaName: area,
      dateOfCreation: date,
      donorApprovalStatus: status,
    );

final sample = {
  'ar': (
    requests: [
      request(1, 'مستشفى السلام', 'حي الزهور', 'O+', '2026-09-28T09:30:00', null),
      request(2, 'مستشفى النور التخصصي', 'وسط المدينة', 'O+', '2026-09-26T14:10:00', true),
      request(3, 'المستشفى الجامعي', 'المنطقة الشرقية', 'O+', '2026-09-24T11:45:00', null),
      request(4, 'مستشفى الأمل', 'حي الواحة', 'O+', '2026-09-20T08:00:00', false),
    ],
    donor: DonorModel(
      id: 7, name: 'أحمد خالد', ssn: '1089473621', dateOfBirth: '1991-08-14T00:00:00',
      bloodTypeName: 'O+', areaName: 'حي الزهور', gender: 'Male', phoneNumber: '0501234567', totalPoints: 1450,
    ),
  ),
  'en': (
    requests: [
      request(1, 'Al Salam Hospital', 'Al Zuhour District', 'O+', '2026-09-28T09:30:00', null),
      request(2, 'Al Noor Specialist Hospital', 'City Centre', 'O+', '2026-09-26T14:10:00', true),
      request(3, 'University Hospital', 'Eastern District', 'O+', '2026-09-24T11:45:00', null),
      request(4, 'Al Amal Hospital', 'Al Waha District', 'O+', '2026-09-20T08:00:00', false),
    ],
    donor: DonorModel(
      id: 7, name: 'Ahmed Khaled', ssn: '1089473621', dateOfBirth: '1991-08-14T00:00:00',
      bloodTypeName: 'O+', areaName: 'Al Zuhour District', gender: 'Male', phoneNumber: '0501234567', totalPoints: 1450,
    ),
  ),
};

Future<void> loadFonts() async {
  Future<ByteData> file(String path) async => ByteData.view((await File(path).readAsBytes()).buffer);
  final plex = FontLoader(AppTheme.fontFamily);
  for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
    plex.addFont(file('assets/fonts/IBMPlexSansArabic-$weight.ttf'));
  }
  await plex.load();
  final sdk = File(Platform.resolvedExecutable).parent.parent.parent.parent.path;
  await (FontLoader('MaterialIcons')..addFont(file('$sdk/artifacts/material_fonts/materialicons-regular.otf'))).load();
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    await loadFonts();
  });

  Future<void> pumpApp(WidgetTester tester, String lang, Widget home) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 2.75;
    tester.view.padding = const FakeViewPadding(top: 88);
    tester.view.viewPadding = const FakeViewPadding(top: 88);
    addTearDown(tester.view.reset);

    FlutterSecureStorage.setMockInitialValues({});
    final getIt = GetIt.instance;
    await getIt.reset();
    getIt.registerSingleton<LoginCubit>(FakeLoginCubit());
    getIt.registerSingleton<RequestsCubit>(FakeRequestsCubit(sample[lang]!.requests));
    getIt.registerSingleton<DonorCubit>(FakeDonorCubit(sample[lang]!.donor));

    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          key: UniqueKey(),
          supportedLocales: const [Locale('ar'), Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          startLocale: Locale(lang),
          saveLocale: false,
          child: Builder(
            builder: (context) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: BlocProvider<LoginCubit>.value(value: getIt<LoginCubit>(), child: home),
            ),
          ),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await tester.pumpAndSettle();
  }

  for (final lang in ['ar', 'en']) {
    testWidgets('$lang login', (tester) async {
      debugDisableShadows = false;
      await pumpApp(tester, lang, const LoginScreen());
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('shots/$lang-01-login.png'));
      debugDisableShadows = true;
    });

    testWidgets('$lang requests', (tester) async {
      debugDisableShadows = false;
      await pumpApp(tester, lang, const MainScreen(phoneNumber: '0501234567'));
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('shots/$lang-02-requests.png'));
      debugDisableShadows = true;
    });

    testWidgets('$lang profile and logout', (tester) async {
      debugDisableShadows = false;
      await pumpApp(tester, lang, const MainScreen(phoneNumber: '0501234567'));
      await tester.tap(find.byIcon(Icons.person_outline).last);
      await tester.pumpAndSettle();
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('shots/$lang-03-profile.png'));

      final logout = find.byIcon(Icons.logout_rounded);
      await tester.scrollUntilVisible(logout, 300, scrollable: find.byType(Scrollable).last);
      await tester.pumpAndSettle();
      await tester.tap(logout);
      await tester.pumpAndSettle();
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('shots/$lang-04-logout.png'));
      debugDisableShadows = true;
    });
  }
}
