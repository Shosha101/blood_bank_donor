class HospitalRequest {
  String hospitalName;
  String area;
  String bloodType;
  String date;
  bool isAccepted;

  HospitalRequest({
    required this.hospitalName,
    required this.area,
    required this.bloodType,
    required this.date,
    this.isAccepted = false,
  });
}