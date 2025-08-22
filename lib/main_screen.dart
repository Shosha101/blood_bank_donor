import 'package:blood_bank_donor/core/di/dependency_injection.dart';
import 'package:blood_bank_donor/core/extension/navigation_extension.dart';
import 'package:blood_bank_donor/core/helpers/shared_preference.dart';
import 'package:blood_bank_donor/core/routing/routes.dart';
import 'package:blood_bank_donor/features/about/logic/donor_cubit.dart';
import 'package:blood_bank_donor/features/about/ui/about_screen.dart';
import 'package:blood_bank_donor/features/login/logic/login_cubit.dart';
import 'package:blood_bank_donor/features/login/logic/login_state.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_cubit.dart';
import 'package:blood_bank_donor/features/requests/ui/requests_screen.dart';
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
    final selectedIndex = await SharedPrefHelper.getSecuredInt(SharedPrefKeys.selectedIndex);
    if (mounted && selectedIndex != null && selectedIndex >= 0 && selectedIndex < 2) {
      setState(() {
        _selectedIndex = selectedIndex;
      });
    }
  }

  Future<void> _saveSelectedIndex(int index) async {
    await SharedPrefHelper.setSecuredInt(SharedPrefKeys.selectedIndex, index);
    debugPrint('Stored selectedIndex: $index');
  }

  void _onItemTapped(BuildContext context, int index) {
    if (index == 2) {
      // Logout item
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<LoginCubit>().logout();
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
        _saveSelectedIndex(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const RequestsScreen(),
      const AboutScreen(),
    ];

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
              debugPrint('Logout error: ${state.errorHandler.apiErrorModel.message}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorHandler.apiErrorModel.message ?? 'Logout failed. Please try again.',
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'Retry',
                    textColor: Colors.white,
                    onPressed: () => context.read<LoginCubit>().logout(),
                  ),
                ),
              );
            } else if (state is LoginStateLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logging out...'),
                  duration: Duration(seconds: 1),
                ),
              );
            }
          },
          child: Scaffold(
            body: screens[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.request_page),
                  label: 'Requests',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.logout),
                  label: 'Logout',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.redAccent,
              unselectedItemColor: Colors.grey,
              onTap: (index) => _onItemTapped(providerContext, index),
            ),
          ),
        ),
      ),
    );
  }
}