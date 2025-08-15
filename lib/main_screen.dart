import 'package:blood_bank_donor/core/di/dependency_injection.dart';
import 'package:blood_bank_donor/features/about/ui/about_screen.dart';
import 'package:blood_bank_donor/features/requests/ui/requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_cubit.dart';
import 'package:blood_bank_donor/features/about/logic/about_cubit.dart';

class MainScreen extends StatefulWidget {
  final String phoneNumber;

  const MainScreen({super.key, required this.phoneNumber});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Start on RequestsScreen

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      BlocProvider(
        create: (context) => getIt<RequestsCubit>(),
        child: RequestsScreen(phoneNumber: widget.phoneNumber),
      ),
      BlocProvider(
        create: (context) => getIt<AboutCubit>(),
        child: const AboutScreen(),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}