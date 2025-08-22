import 'package:blood_bank_donor/core/routing/routes.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_cubit.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/scheduler.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  bool _isLayoutReady = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isLayoutReady = true;
      });
      if (!context.read<RequestsCubit>().isClosed) {
        context.read<RequestsCubit>().getDonationRequests();
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
    final padding = isMobile ? 8.w : isTablet ? 10.w : 12.w;
    final verticalMargin = isMobile ? 6.h : isTablet ? 7.h : 8.h;
    final titleFontSize = isMobile ? 14.sp : isTablet ? 15.sp : 16.sp;
    final detailFontSize = isMobile ? 12.sp : isTablet ? 13.sp : 14.sp;
    final iconSize = isMobile ? 20.sp : isTablet ? 22.sp : 24.sp;
    final buttonWidth = isMobile ? 80.w : isTablet ? 100.w : 150.w;
    final buttonFontSize = isMobile ? 12.sp : isTablet ? 13.sp : 14.sp;
    final snackBarFontSize = isMobile ? 12.sp : isTablet ? 13.sp : 14.sp;

    return Scaffold(
      appBar: AppBar(
        leading: Image(image: const AssetImage('assets/images/safe_blood.png')),
        backgroundColor: Colors.white,
        title: Text(
          "Hospital Requests",
          style: TextStyle(
            fontSize: isMobile ? 18.sp : isTablet ? 19.sp : 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth > 800 ? 800 : constraints.maxWidth,
              ),
              child: BlocListener<RequestsCubit, RequestsState>(
                listener: (context, state) {
                  state.whenOrNull(
                    success: (requests) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Requests updated successfully',
                            style: TextStyle(fontSize: snackBarFontSize),
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
                            error.toString(),
                            style: TextStyle(fontSize: snackBarFontSize),
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
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.redAccent,
                          ),
                        ),
                      ),
                      loading: () => Center(
                        child: CircularProgressIndicator(
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.redAccent,
                          ),
                        ),
                      ),
                      success: (requests) => RefreshIndicator(
                        onRefresh: () async {
                          if (_isLayoutReady &&
                              !context.read<RequestsCubit>().isClosed) {
                            context.read<RequestsCubit>().getDonationRequests();
                          }
                        },
                        child: requests.isEmpty
                            ? Center(
                                child: Text(
                                  'No donation requests available',
                                  style: TextStyle(
                                    fontSize: detailFontSize,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.symmetric(
                                  horizontal: padding,
                                  vertical: verticalMargin,
                                ),
                                itemCount: requests.length,
                                itemBuilder: (context, index) {
                                  try {
                                    final request = requests[index];
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      margin: EdgeInsets.symmetric(vertical: verticalMargin),
                                      child: Padding(
                                        padding: EdgeInsets.all(padding),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Hospital: ${request.hospitalName}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: titleFontSize,
                                              ),
                                            ),
                                            SizedBox(height: isMobile ? 3.h : 4.h),
                                            Text(
                                              "Area: ${request.areaName}",
                                              style: TextStyle(fontSize: detailFontSize),
                                            ),
                                            Text(
                                              "Blood Type: ${request.bloodTypeName}",
                                              style: TextStyle(fontSize: detailFontSize),
                                            ),
                                            Text(
                                              "Date: ${request.dateOfCreation.substring(0, 10)}",
                                              style: TextStyle(fontSize: detailFontSize),
                                            ),
                                            SizedBox(height: isMobile ? 8.h : 10.h),
                                            if (request.donorApprovalStatus == null)
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: buttonWidth,
                                                    child: ElevatedButton(
                                                      onPressed: _isLayoutReady
                                                          ? () {
                                                              if (!context
                                                                  .read<RequestsCubit>()
                                                                  .isClosed) {
                                                                context
                                                                    .read<RequestsCubit>()
                                                                    .approveDonationRequest(
                                                                      request.donorDonationRequestId,
                                                                    );
                                                              }
                                                            }
                                                          : null,
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.green,
                                                        padding: EdgeInsets.symmetric(
                                                          vertical: isMobile ? 8.h : 10.h,
                                                        ),
                                                        textStyle: TextStyle(
                                                          fontSize: buttonFontSize,
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        "Accept",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: isMobile ? 8.w : 10.w),
                                                  SizedBox(
                                                    width: buttonWidth,
                                                    child: ElevatedButton(
                                                      onPressed: _isLayoutReady
                                                          ? () {
                                                              if (!context
                                                                  .read<RequestsCubit>()
                                                                  .isClosed) {
                                                                context
                                                                    .read<RequestsCubit>()
                                                                    .rejectDonationRequest(
                                                                      request.donorDonationRequestId,
                                                                    );
                                                              }
                                                            }
                                                          : null,
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.red,
                                                        padding: EdgeInsets.symmetric(
                                                          vertical: isMobile ? 8.h : 10.h,
                                                        ),
                                                        textStyle: TextStyle(
                                                          fontSize: buttonFontSize,
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        "Reject",
                                                        style: TextStyle(color: Colors.white),
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
                                                  fontSize: detailFontSize,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            if (request.donorApprovalStatus == false)
                                              Text(
                                                "Status: Rejected",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: detailFontSize,
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
                          padding: EdgeInsets.symmetric(horizontal: padding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: isMobile ? 40.sp : isTablet ? 44.sp : 48.sp,
                              ),
                              SizedBox(height: isMobile ? 12.h : 16.h),
                              Text(
                                error.toString(),
                                style: TextStyle(
                                  fontSize: detailFontSize,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: isMobile ? 12.h : 16.h),
                              ElevatedButton(
                                onPressed: _isLayoutReady
                                    ? () {
                                        if (!context.read<RequestsCubit>().isClosed) {
                                          context.read<RequestsCubit>().getDonationRequests();
                                        }
                                      }
                                    : null,
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
          );
        },
      ),
    );
  }
}