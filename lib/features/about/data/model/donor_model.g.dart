// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonorModel _$DonorModelFromJson(Map<String, dynamic> json) => DonorModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  ssn: json['ssn'] as String,
  dateOfBirth: json['dateOfBirth'] as String,
  bloodTypeName: json['bloodTypeName'] as String,
  areaName: json['areaName'] as String,
  gender: json['gender'] as String,
  phoneNumber: json['phoneNumber'] as String,
  totalPoints: (json['totalPoints'] as num).toInt(),
);

Map<String, dynamic> _$DonorModelToJson(DonorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ssn': instance.ssn,
      'dateOfBirth': instance.dateOfBirth,
      'bloodTypeName': instance.bloodTypeName,
      'areaName': instance.areaName,
      'gender': instance.gender,
      'phoneNumber': instance.phoneNumber,
      'totalPoints': instance.totalPoints,
    };
