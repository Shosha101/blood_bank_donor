import 'package:blood_bank_donor/core/extension/navigation_extension.dart';
import 'package:blood_bank_donor/core/helpers/spacing.dart';
import 'package:blood_bank_donor/core/routing/routes.dart';
import 'package:blood_bank_donor/core/theming/colors.dart';
import 'package:blood_bank_donor/features/login/logic/login_cubit.dart';
import 'package:blood_bank_donor/features/login/logic/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  final Function(BuildContext, String)? onLogin; // Add onLogin parameter

  const LoginScreen({super.key, this.onLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donor Login',
          style: TextStyle(
            color: ColorsManager.mainAppFontColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        elevation: 0.5,
        backgroundColor: ColorsManager.gradientBackgroundColorWhite,
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 460.w,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(26.h),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: ColorsManager.mainAppFontColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(25.h),
                    Text(
                      'Phone Number',
                      style: TextStyle(fontSize: 12.sp, color: Colors.black),
                    ),
                    SizedBox(
                      width: 448.w,
                      height: 56.h,
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Enter your phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Please enter a valid 10-digit phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    verticalSpace(24.h),
                    Text(
                      'Password',
                      style: TextStyle(fontSize: 12.sp, color: Colors.black),
                    ),
                    SizedBox(
                      width: 448.w,
                      height: 56.h,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: ColorsManager.mainAppFontColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                    ),
                    verticalSpace(24.h),
                    SizedBox(
                      width: 460.w,
                      height: 40.h,
                      child: BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginStateSuccess) {
                            // Use onLogin callback if provided, otherwise use default navigation
                            if (widget.onLogin != null) {
                              widget.onLogin!(
                                context,
                                _phoneController.text.trim(),
                              );
                            } else {
                              context.pushReplacementNamed(
                                Routes.requestsScreen,
                              );
                            }
                          } else if (state is LoginStateError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.errorHandler.apiErrorModel.message ??
                                      'Unknown error',
                                ),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginStateLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginCubit>().login(
                                  _phoneController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              backgroundColor: ColorsManager.mainBlue,
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    verticalSpace(16.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
