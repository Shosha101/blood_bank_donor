import 'package:json_annotation/json_annotation.dart';

part 'donor_model.g.dart';

@JsonSerializable()
class DonorModel {
  final int id;
  final String name;
  final String ssn;
  final String dateOfBirth;
  final String bloodTypeName;
  final String areaName;
  final String gender;
  final String phoneNumber;
  final int totalPoints;

  DonorModel({
    required this.id,
    required this.name,
    required this.ssn,
    required this.dateOfBirth,
    required this.bloodTypeName,
    required this.areaName,
    required this.gender,
    required this.phoneNumber,
    required this.totalPoints,
  });

  factory DonorModel.fromJson(Map<String, dynamic> json) => _$DonorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DonorModelToJson(this);
}