import 'package:json_annotation/json_annotation.dart';

part 'request_model.g.dart';

@JsonSerializable()
class RequestModel {
  final int donorDonationRequestId;
  final String hospitalName;
  final String bloodTypeName;
  final String areaName;
  final String dateOfCreation;
  final bool? donorApprovalStatus;

  RequestModel({
    required this.donorDonationRequestId,
    required this.hospitalName,
    required this.bloodTypeName,
    required this.areaName,
    required this.dateOfCreation,
    required this.donorApprovalStatus,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => _$RequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestModelToJson(this);
}