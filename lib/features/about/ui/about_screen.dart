import 'package:blood_bank_donor/core/theming/app_theme.dart';
import 'package:blood_bank_donor/core/widgets/app_widgets.dart';
import 'package:blood_bank_donor/features/about/data/model/donor_model.dart';
import 'package:blood_bank_donor/features/about/logic/donor_cubit.dart';
import 'package:blood_bank_donor/features/about/logic/donor_state.dart';
import 'package:blood_bank_donor/features/login/ui/logout_sheet.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.read<DonorCubit>().isClosed) {
        context.read<DonorCubit>().getDonorData();
      }
    });
  }

  void _reload() {
    if (!context.read<DonorCubit>().isClosed) {
      context.read<DonorCubit>().getDonorData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: context.tr('profile_title')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: BlocBuilder<DonorCubit, DonorState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (donor) => _ProfileBody(donor: donor),
                error: (error) => Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        StateMessage(
                          icon: Icons.cloud_off_outlined,
                          title: context.tr('profile_error'),
                          body: error.message,
                          actionLabel: context.tr('retry'),
                          onAction: _reload,
                        ),
                        // Logging out must stay reachable when the profile fails to load.
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: _LogoutButton(
                            onPressed: () => showLogoutSheet(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  final DonorModel donor;
  const _ProfileBody({required this.donor});

  String _genderLabel(BuildContext context, String gender) {
    switch (gender.trim().toLowerCase()) {
      case 'male':
      case 'm':
        return context.tr('gender_male');
      case 'female':
      case 'f':
        return context.tr('gender_female');
      default:
        return gender;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        Center(
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surface, width: 4),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.primary,
              size: 46,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          donor.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          context.tr('donor_role'),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13, color: AppColors.muted),
        ),
        const SizedBox(height: 18),
        AppCard(
          color: AppColors.primarySoft,
          borderColor: AppColors.primarySoft,
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: _HighlightTile(
                  label: context.tr('blood_type'),
                  child: Text(
                    donor.bloodTypeName,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _HighlightTile(
                  label: context.tr('total_points'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        donor.totalPoints.toString(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        context.tr('points_unit'),
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        _SectionTitle(context.tr('donor_details')),
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            children: [
              _DetailRow(
                icon: Icons.badge_outlined,
                label: context.tr('national_id'),
                value: donor.ssn,
                ltr: true,
              ),
              _DetailRow(
                icon: Icons.cake_outlined,
                label: context.tr('date_of_birth'),
                value: formatApiDate(donor.dateOfBirth),
                ltr: true,
              ),
              _DetailRow(
                icon: Icons.person_outline,
                label: context.tr('gender'),
                value: _genderLabel(context, donor.gender),
              ),
              _DetailRow(
                icon: Icons.location_on_outlined,
                label: context.tr('area'),
                value: donor.areaName,
              ),
              _DetailRow(
                icon: Icons.phone_outlined,
                label: context.tr('phone'),
                value: donor.phoneNumber,
                ltr: true,
                last: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        _SectionTitle(context.tr('settings')),
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              const _IconTile(icon: Icons.translate),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('language'),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.muted,
                      ),
                    ),
                    Text(
                      context.tr('language_name'),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
              const LanguagePill(),
            ],
          ),
        ),
        const SizedBox(height: 22),
        _LogoutButton(onPressed: () => showLogoutSheet(context)),
      ],
    );
  }
}

class _HighlightTile extends StatelessWidget {
  final String label;
  final Widget child;
  const _HighlightTile({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.muted),
          ),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColors.text,
        ),
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  final IconData icon;
  const _IconTile({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.primarySofter,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 19, color: AppColors.primary),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool ltr;
  final bool last;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.ltr = false,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          _IconTile(icon: icon),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: AppColors.muted),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            textDirection: ltr ? TextDirection.ltr : null,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _LogoutButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.logout_rounded, size: 20),
      label: Text(context.tr('logout')),
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.primarySofter,
        side: const BorderSide(color: AppColors.primarySoft),
      ),
    );
  }
}
