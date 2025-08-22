import 'package:blood_bank_donor/core/routing/routes.dart';
import 'package:blood_bank_donor/features/about/logic/donor_cubit.dart';
import 'package:blood_bank_donor/features/about/logic/donor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  Widget build(BuildContext context) {
    // Determine screen size category
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 400;
    final isTablet = screenWidth >= 400 && screenWidth < 600;

    // Responsive sizes
    final avatarRadius = isMobile
        ? 40.r
        : isTablet
        ? 45.r
        : 50.r;
    final padding = isMobile
        ? 8.w
        : isTablet
        ? 12.w
        : 16.w;
    final cardHorizontalPadding = isMobile
        ? 20.w
        : isTablet
        ? 50.w
        : 100.w;
    final titleFontSize = isMobile
        ? 18.sp
        : isTablet
        ? 19.sp
        : 20.sp;
    final labelFontSize = isMobile
        ? 14.sp
        : isTablet
        ? 15.sp
        : 16.sp;
    final valueFontSize = isMobile
        ? 12.sp
        : isTablet
        ? 14.sp
        : 16.sp;
    final iconSize = isMobile
        ? 20.sp
        : isTablet
        ? 22.sp
        : 24.sp;
    final buttonFontSize = isMobile
        ? 12.sp
        : isTablet
        ? 13.sp
        : 14.sp;

    return Scaffold(
      appBar: AppBar(
        leading: Image(image: AssetImage('assets/images/safe_blood.png')),
        backgroundColor: Colors.white,
        title: Text(
          "About",
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: BlocListener<DonorCubit, DonorState>(
            listener: (context, state) {
              state.whenOrNull(
                error: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        error.message ?? 'Failed to load donor data',
                        style: TextStyle(fontSize: labelFontSize),
                      ),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
            child: BlocBuilder<DonorCubit, DonorState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return state.when(
                  initial: () => Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                    ),
                  ),
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                    ),
                  ),
                  success: (donor) => Column(
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: const AssetImage(
                          "assets/images/safe_blood.png",
                        ),
                      ),
                      SizedBox(height: isMobile ? 8.h : 12.h),
                      Text(
                        donor.name,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: isMobile ? 12.h : 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: cardHorizontalPadding,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.all(padding),
                            child: Column(
                              children: [
                                buildDetailRow(
                                  Icons.phone,
                                  "Phone",
                                  donor.phoneNumber,
                                  iconSize,
                                  labelFontSize,
                                  valueFontSize,
                                ),
                                buildDetailRow(
                                  Icons.credit_card,
                                  "SSN",
                                  donor.ssn,
                                  iconSize,
                                  labelFontSize,
                                  valueFontSize,
                                ),
                                buildDetailRow(
                                  Icons.cake,
                                  "Date of Birth",
                                  donor.dateOfBirth.substring(0, 10),
                                  iconSize,
                                  labelFontSize,
                                  valueFontSize,
                                ),
                                buildDetailRow(
                                  Icons.person,
                                  "Gender",
                                  donor.gender,
                                  iconSize,
                                  labelFontSize,
                                  valueFontSize,
                                ),
                                buildDetailRow(
                                  Icons.bloodtype,
                                  "Blood Type",
                                  donor.bloodTypeName,
                                  iconSize,
                                  labelFontSize,
                                  valueFontSize,
                                ),
                                buildDetailRow(
                                  Icons.location_on,
                                  "Area",
                                  donor.areaName,
                                  iconSize,
                                  labelFontSize,
                                  valueFontSize,
                                ),
                                buildDetailRow(
                                  Icons.star,
                                  "Points",
                                  donor.totalPoints.toString(),
                                  iconSize,
                                  labelFontSize,
                                  valueFontSize,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  error: (error) => Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: isMobile
                                ? 40.sp
                                : isTablet
                                ? 44.sp
                                : 48.sp,
                          ),
                          SizedBox(height: isMobile ? 12.h : 16.h),
                          Text(
                            error.message ?? 'Unable to load donor data',
                            style: TextStyle(
                              fontSize: labelFontSize,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: isMobile ? 12.h : 16.h),
                          ElevatedButton(
                            onPressed: () {
                              if (!context.read<DonorCubit>().isClosed) {
                                context.read<DonorCubit>().getDonorData();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 16.w : 24.w,
                                vertical: isMobile ? 8.h : 12.h,
                              ),
                              textStyle: TextStyle(fontSize: buttonFontSize),
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Retry'),
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
      ),
    );
  }

  Widget buildDetailRow(
    IconData icon,
    String label,
    String value,
    double iconSize,
    double labelFontSize,
    double valueFontSize,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent, size: iconSize),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: labelFontSize,
              ),
            ),
          ),
          Text(value, style: TextStyle(fontSize: valueFontSize)),
        ],
      ),
    );
  }
}
