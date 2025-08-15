import 'package:blood_bank_donor/core/routing/routes.dart';
import 'package:blood_bank_donor/features/about/data/model/request_model.dart';
import 'package:flutter/material.dart';

class RequestsScreen extends StatefulWidget {
  final String? phoneNumber;

  const RequestsScreen({super.key, this.phoneNumber});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  List<HospitalRequest> requests = [
    HospitalRequest(
      hospitalName: "City Hospital",
      area: "Downtown",
      bloodType: "O+",
      date: "2025-08-15",
    ),
    HospitalRequest(
      hospitalName: "Green Valley Clinic",
      area: "East Side",
      bloodType: "A-",
      date: "2025-08-14",
    ),
    HospitalRequest(
      hospitalName: "Sunrise Medical",
      area: "West End",
      bloodType: "B+",
      date: "2025-08-13",
    ),
  ];

  void acceptRequest(int index) {
    setState(() {
      requests[index].isAccepted = true;
    });
  }

  void rejectRequest(int index) {
    setState(() {
      requests.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hospital Requests"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.initialRoute,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];

          return Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hospital: ${request.hospitalName}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text("Area: ${request.area}"),
                  Text("Blood Type: ${request.bloodType}"),
                  Text("Date: ${request.date}"),
                  const SizedBox(height: 10),
                  if (!request.isAccepted)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => acceptRequest(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text(
                              "Accept",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => rejectRequest(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text(
                              "Reject",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
