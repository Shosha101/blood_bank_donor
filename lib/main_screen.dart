import 'package:blood_bank_donor/core/di/dependency_injection.dart';
import 'package:blood_bank_donor/core/extension/navigation_extension.dart';
import 'package:blood_bank_donor/core/helpers/shared_preference.dart';
import 'package:blood_bank_donor/core/routing/routes.dart';
import 'package:blood_bank_donor/core/theming/app_theme.dart';
import 'package:blood_bank_donor/features/about/logic/donor_cubit.dart';
import 'package:blood_bank_donor/features/about/ui/about_screen.dart';
import 'package:blood_bank_donor/features/login/logic/login_cubit.dart';
import 'package:blood_bank_donor/features/login/logic/login_state.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_cubit.dart';
import 'package:blood_bank_donor/features/requests/ui/requests_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  final String phoneNumber;

  const MainScreen({super.key, required this.phoneNumber});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _restoreSelectedIndex();
  }

  Future<void> _restoreSelectedIndex() async {
    final selectedIndex = await SharedPrefHelper.getSecuredInt(
      SharedPrefKeys.selectedIndex,
    );
    if (mounted &&
        selectedIndex != null &&
        selectedIndex >= 0 &&
        selectedIndex < 2) {
      setState(() {
        _selectedIndex = selectedIndex;
      });
    }
  }

  Future<void> _saveSelectedIndex(int index) async {
    await SharedPrefHelper.setSecuredInt(SharedPrefKeys.selectedIndex, index);
    debugPrint('Stored selectedIndex: $index');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _saveSelectedIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [const RequestsScreen(), const AboutScreen()];

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<RequestsCubit>()),
        BlocProvider.value(value: getIt<DonorCubit>()),
        BlocProvider.value(value: getIt<LoginCubit>()),
      ],
      child: Builder(
        builder: (providerContext) => BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginStateLogoutSuccess) {
              debugPrint('Logout successful, navigating to LoginScreen');
              providerContext.pushReplacementNamed(Routes.initialRoute);
            } else if (state is LoginStateError) {
              debugPrint(
                'Logout error: ${state.errorHandler.apiErrorModel.message}',
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorHandler.apiErrorModel.message ??
                        context.tr('logout_failed'),
                  ),
                  backgroundColor: AppColors.primaryDark,
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: context.tr('retry'),
                    textColor: Colors.white,
                    onPressed: () => context.read<LoginCubit>().logout(),
                  ),
                ),
              );
            } else if (state is LoginStateLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.tr('logging_out')),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          child: Scaffold(
            body: screens[_selectedIndex],
            bottomNavigationBar: DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: _onItemTapped,
                destinations: [
                  NavigationDestination(
                    icon: const Icon(Icons.volunteer_activism_outlined),
                    selectedIcon: const Icon(Icons.volunteer_activism),
                    label: context.tr('nav_requests'),
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.person_outline),
                    selectedIcon: const Icon(Icons.person),
                    label: context.tr('nav_profile'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
