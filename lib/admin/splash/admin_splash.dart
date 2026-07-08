import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:npms/core/services/session_manager.dart';

import '../../core/routes/appRoutes.dart';

class AdminSplash extends StatefulWidget {
  const AdminSplash({super.key});

  @override
  State<AdminSplash> createState() => _AdminSplashState();
}

class _AdminSplashState extends State<AdminSplash> {
  @override
  void initState() {
    super.initState();
    _init();
    // Future.microtask(() async {
    //   try {
    //     // await NotificationService().init();
    //   } catch (e) {
    //     debugPrint("Notification init failed: $e");
    //   }
    // });
  }

    Future<void> _init() async {
  await Future.delayed(const Duration(seconds: 2));

  if (!mounted) return;

  if (SessionManager.isLoggedIn) {
    Get.offAllNamed(AppRoutes.adminHomePage);
  } else {
    Get.offAllNamed(AppRoutes.adminLoginPage);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff081A3A),
          ),
          child: Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.95, end: 1.05),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeInOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              onEnd: () {
                if (mounted) setState(() {});
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffFFC107),
                        width: 4,
                      ),
                      boxShadow: [
                        // BoxShadow(
                        //   color: Colors.amber.withOpacity(.35),
                        //   blurRadius: 25,
                        //   spreadRadius: 2,
                        // ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/logo.jpeg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    "NPMS",
                    style: TextStyle(
                      color: Color(0xffFFC107),
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 8,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "KAIMUR POLICE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4,
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    "Night Patrol Monitoring System",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 40),

                  const SizedBox(
                    width: 42,
                    height: 42,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor: AlwaysStoppedAnimation(
                        Color(0xffFFC107),
                      ),
                      backgroundColor: Colors.white24,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
