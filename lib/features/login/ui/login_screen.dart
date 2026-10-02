import 'package:blood_bank_donor/core/extension/navigation_extension.dart';
import 'package:blood_bank_donor/core/routing/routes.dart';
import 'package:blood_bank_donor/core/theming/app_theme.dart';
import 'package:blood_bank_donor/core/widgets/app_widgets.dart';
import 'package:blood_bank_donor/features/login/logic/login_cubit.dart';
import 'package:blood_bank_donor/features/login/logic/login_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: LanguagePill(),
                    ),
                    const SizedBox(height: 28),
                    const Center(child: AppLogo(size: 76)),
                    const SizedBox(height: 16),
                    Text(
                      context.tr('app_name'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.tr('app_tagline'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 28),
                    AppCard(
                      color: AppColors.primarySofter,
                      borderColor: AppColors.primarySoft,
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: AppColors.primarySoft,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.volunteer_activism,
                              color: AppColors.primary,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr('login_welcome_title'),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.text,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  context.tr('login_welcome_body'),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.5,
                                    color: AppColors.muted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _FieldLabel(context.tr('phone_label')),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: context.tr('phone_hint'),
                        prefixIcon: const Icon(
                          Icons.phone_outlined,
                          color: AppColors.muted,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.tr('phone_required');
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return context.tr('phone_invalid');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _FieldLabel(context.tr('password_label')),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: context.tr('password_hint'),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: AppColors.muted,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.muted,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.tr('password_required');
                        }
                        if (value.length < 8) {
                          return context.tr('password_short');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginStateSuccess) {
                          // Use onLogin callback if provided, otherwise use default navigation
                          if (widget.onLogin != null) {
                            widget.onLogin!(
                              context,
                              _phoneController.text.trim(),
                            );
                          } else {
                            context.pushReplacementNamed(Routes.requestsScreen);
                          }
                        } else if (state is LoginStateError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.errorHandler.apiErrorModel.message ??
                                    context.tr('unknown_error'),
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final loading = state is LoginStateLoading;
                        return FilledButton(
                          onPressed: loading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<LoginCubit>().login(
                                      _phoneController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                                  }
                                },
                          child: loading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(context.tr('sign_in')),
                        );
                      },
                    ),
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

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
    );
  }
}
