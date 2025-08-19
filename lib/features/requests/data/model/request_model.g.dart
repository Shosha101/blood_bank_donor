// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestModel _$RequestModelFromJson(Map<String, dynamic> json) => RequestModel(
  donorDonationRequestId: (json['donorDonationRequestId'] as num).toInt(),
  hospitalName: json['hospitalName'] as String,
  bloodTypeName: json['bloodTypeName'] as String,
  areaName: json['areaName'] as String,
  dateOfCreation: json['dateOfCreation'] as String,
  donorApprovalStatus: json['donorApprovalStatus'] as bool?,
);

Map<String, dynamic> _$RequestModelToJson(RequestModel instance) =>
    <String, dynamic>{
      'donorDonationRequestId': instance.donorDonationRequestId,
      'hospitalName': instance.hospitalName,
      'bloodTypeName': instance.bloodTypeName,
      'areaName': instance.areaName,
      'dateOfCreation': instance.dateOfCreation,
      'donorApprovalStatus': instance.donorApprovalStatus,
    };
