import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  // ✅ TOAST / SUCCESS / WARNING (GREY)
  static void toast(String message, {String title = "Message"}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: const Color.fromARGB(255, 54, 200, 76), // ✅ GREY
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.all(12),
      icon: const Icon(Icons.notifications, color: Colors.white),
      duration: const Duration(seconds: 2),
    );
  }

  static void success(String message, {String title = "Message"}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: const Color.fromARGB(255, 53, 180, 78), // ✅ GREY
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.all(12),
      icon: const Icon(Icons.notifications, color: Colors.white),
      duration: const Duration(seconds: 2),
    );
  }

  // ✅ ERROR / REQUIRED / ALERT (EXACT RED)
  static void error(String message, {String title = "Error"}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red, // ✅ EXACT RED
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.all(12),
      icon: const Icon(Icons.error, color: Colors.white),
      duration: const Duration(seconds: 3),
    );
  }

  // ✅ OPTIONAL: WARNING (GREY ALSO)
  static void warning(String message, {String title = "Warning"}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: const Color(0xFF5A5A5A), // ✅ GREY WARNING
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.all(12),
      icon: const Icon(Icons.warning, color: Colors.white),
      duration: const Duration(seconds: 2),
    );
  }
}
