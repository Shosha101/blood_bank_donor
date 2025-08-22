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
    return Scaffold(
      appBar: AppBar(
        leading: Image(image: AssetImage('assets/images/safe_blood.png')),

        backgroundColor: Colors.white,
        title: Text(
          "About",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: BlocListener<DonorCubit, DonorState>(
            listener: (context, state) {
              state.whenOrNull(
                error: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        error.message ?? 'Failed to load donor data',
                        style: TextStyle(fontSize: 14.sp),
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
                        radius: 50.r,
                        backgroundImage: const AssetImage(
                          "assets/images/safe_blood.png",
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        donor.name,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 250.w),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              children: [
                                buildDetailRow(
                                  Icons.phone,
                                  "Phone",
                                  donor.phoneNumber,
                                ),
                                buildDetailRow(
                                  Icons.credit_card,
                                  "SSN",
                                  donor.ssn,
                                ),
                                buildDetailRow(
                                  Icons.cake,
                                  "Date of Birth",
                                  donor.dateOfBirth.substring(0, 10),
                                ),
                                buildDetailRow(
                                  Icons.person,
                                  "Gender",
                                  donor.gender,
                                ),
                                buildDetailRow(
                                  Icons.bloodtype,
                                  "Blood Type",
                                  donor.bloodTypeName,
                                ),
                                buildDetailRow(
                                  Icons.location_on,
                                  "Area",
                                  donor.areaName,
                                ),
                                buildDetailRow(
                                  Icons.star,
                                  "Points",
                                  donor.totalPoints.toString(),
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
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 48.sp,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            error.message ?? 'Unable to load donor data',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () {
                              if (!context.read<DonorCubit>().isClosed) {
                                context.read<DonorCubit>().getDonorData();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 12.h,
                              ),
                              textStyle: TextStyle(fontSize: 14.sp),
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

  Widget buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent, size: 24.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
          Text(value, style: TextStyle(fontSize: 16.sp)),
        ],
      ),
    );
  }
}
