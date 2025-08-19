import 'package:blood_bank_donor/core/routing/routes.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_cubit.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.read<RequestsCubit>().isClosed) {
        context.read<RequestsCubit>().getDonationRequests();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Hospital Requests",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, size: 24.sp),
            tooltip: 'Logout',
            onPressed: () {
              try {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.initialRoute,
                  (route) => false,
                );
              } catch (e, stackTrace) {
                debugPrint('Error during logout: $e\n$stackTrace');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Failed to logout: $e',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: BlocListener<RequestsCubit, RequestsState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (requests) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Requests updated successfully',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    error.message ?? 'Action failed',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          );
        },
        child: BlocBuilder<RequestsCubit, RequestsState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return state.when(
              initial: () => Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                ),
              ),
              loading: () => Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                ),
              ),
              success: (requests) => RefreshIndicator(
                onRefresh: () async {
                  if (!context.read<RequestsCubit>().isClosed) {
                    context.read<RequestsCubit>().getDonationRequests();
                  }
                },
                child: requests.isEmpty
                    ? Center(
                        child: Text(
                          'No donation requests available',
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(12.w),
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          try {
                            final request = requests[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 8.h),
                              child: Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hospital: ${request.hospitalName}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    Text(
                                      "Area: ${request.areaName}",
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    Text(
                                      "Blood Type: ${request.bloodTypeName}",
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    Text(
                                      "Date: ${request.dateOfCreation.substring(0, 10)}",
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    SizedBox(height: 10.h),
                                    if (request.donorApprovalStatus == null)
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (!context
                                                    .read<RequestsCubit>()
                                                    .isClosed) {
                                                  context
                                                      .read<RequestsCubit>()
                                                      .approveDonationRequest(
                                                        request
                                                            .donorDonationRequestId,
                                                      );
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                ),
                                                textStyle: TextStyle(
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                              child: const Text(
                                                "Accept",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (!context
                                                    .read<RequestsCubit>()
                                                    .isClosed) {
                                                  context
                                                      .read<RequestsCubit>()
                                                      .rejectDonationRequest(
                                                        request
                                                            .donorDonationRequestId,
                                                      );
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                ),
                                                textStyle: TextStyle(
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                              child: const Text(
                                                "Reject",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (request.donorApprovalStatus == true)
                                      Text(
                                        "Status: Accepted",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    if (request.donorApprovalStatus == false)
                                      Text(
                                        "Status: Rejected",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          } catch (e, stackTrace) {
                            debugPrint(
                              'Error rendering request at index $index: $e\n$stackTrace',
                            );
                            return const SizedBox.shrink();
                          }
                        },
                      ),
              ),
              error: (error) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 48.sp),
                      SizedBox(height: 16.h),
                      Text(
                        error.message ?? 'Unable to load requests',
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
                          if (!context.read<RequestsCubit>().isClosed) {
                            context.read<RequestsCubit>().getDonationRequests();
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
    );
  }
}
