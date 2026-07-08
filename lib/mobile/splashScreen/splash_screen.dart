import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/appRoutes.dart';
import '../../mobile/auth/session_manager.dart';
import '../../mobile/auth/view/login_page.dart';
import '../auth/view/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
    Future.microtask(() async {
      try {
        // await NotificationService().init();
      } catch (e) {
        debugPrint("Notification init failed: $e");
      }
    });
  }

  Future<void> _init() async {
  await Future.delayed(const Duration(seconds: 2));

  if (!mounted) return;

  try {
    if (OfficerSession.isLoggedIn) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  } catch (e) {
    debugPrint("Splash Error: $e");

    Get.offAllNamed(AppRoutes.login);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/logo.jpeg', height: 150),
            const SizedBox(height: 12),
            // RichText(
            //   text: const TextSpan(
            //     children: [
            //       TextSpan(
            //         text: 'Book',
            //         style: TextStyle(color: AppColors.solarOrange, fontSize: 26, fontWeight: FontWeight.bold),
            //       ),
            //       TextSpan(
            //         text: 'MySolar',
            //         style: TextStyle(color: AppColors.solarGreen, fontSize: 26, fontWeight: FontWeight.bold),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 8),
            const Text(
              'Night Patrol Monitory System',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight(600)),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
