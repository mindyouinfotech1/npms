import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../mobile/auth/session_manager.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff081A3A),
      appBar: AppBar(
        backgroundColor: const Color(0xff14264D),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // Back button color
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white12,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 60,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              OfficerSession.name,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            _tile(Icons.badge, "Badge ID", OfficerSession.badgeId),

            _tile(Icons.workspace_premium, "Rank", OfficerSession.rank),

            _tile(Icons.account_balance, "Police Station",
                OfficerSession.stationName),

            _tile(Icons.nightlight_round, "Shift", OfficerSession.shift),

            _tile(Icons.phone, "Mobile", OfficerSession.mobile),

            _tile(Icons.email, "Email", OfficerSession.email),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  await OfficerSession.logout();

                  Get.offAllNamed("/login");
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String title,
    String value,
  ) {
    return Card(
      color: const Color(0xff14264D),
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: Colors.amber),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white70),
        ),
        subtitle: Text(
          value.isEmpty ? "-" : value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}