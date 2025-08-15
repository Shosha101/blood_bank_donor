import 'package:blood_bank_donor/core/routing/routes.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String profileImage = "assets/images/safe_blood.png";
    final String name = "Ahmed Mohamed";
    final String phone = "+20 123 456 789";
    final String ssn = "29812345678901";
    final String dob = "1998-12-15";
    final String lastDonation = "2025-06-10";
    final String gender = "Male";
    final String bloodType = "O+";
    final String area = "Cairo";
    final int points = 120;

    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(profileImage),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    buildDetailRow(Icons.phone, "Phone", phone),
                    buildDetailRow(Icons.credit_card, "SSN", ssn),
                    buildDetailRow(Icons.cake, "Date of Birth", dob),
                    buildDetailRow(
                      Icons.access_time,
                      "Last Donation Date",
                      lastDonation,
                    ),
                    buildDetailRow(Icons.person, "Gender", gender),
                    buildDetailRow(Icons.bloodtype, "Blood Type", bloodType),
                    buildDetailRow(Icons.location_on, "Area", area),
                    buildDetailRow(Icons.star, "Points", points.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}