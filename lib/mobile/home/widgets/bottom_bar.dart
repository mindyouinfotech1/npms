import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Mobile/profile/profile.dart';

class OfficerBottomNavigationBar extends StatelessWidget {
  const OfficerBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xff081A3A),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xffFFC107),
      unselectedItemColor: Colors.white54,
      currentIndex: 2, // Scan page
      onTap: (index) {
        switch (index) {
          case 0:
            Get.offAllNamed('/dashboard');
            break;

          case 1:
            Get.toNamed('/patrol-history');
            break;

          case 2:
            // Already on Scan
            break;

          case 3:
            Get.toNamed('/emergency');
            break;

          case 4:
          Get.to(() => const ProfilePage());
          break;
                }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "History",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner),
          label: "Scan",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.warning_amber_outlined),
          label: "Emergency",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}