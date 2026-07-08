import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/appRoutes.dart';
import '../../../../core/services/firebase_service.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  final loading = false.obs;

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  Future<void> sendOtp() async {
    if (!formKey.currentState!.validate()) return;

    loading(true);

    try {
      final username = usernameController.text.trim();
      final email = emailController.text.trim();

      /// Check Admin
      final admin = await FirebaseService.firestore
          .collection("admins")
          .where("username", isEqualTo: username)
          .where("email", isEqualTo: email)
          .where("status", isEqualTo: "active")
          .limit(1)
          .get();

      if (admin.docs.isEmpty) {
        Get.snackbar(
          "Account Not Found",
          "Invalid username or registered email.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      /// Generate OTP
      final otp = _generateOtp();

      /// Save OTP
      await FirebaseService.firestore
          .collection("password_reset_otps")
          .doc(username)
          .set({
        "username": username,
        "email": email,
        "otp": otp,
        "verified": false,
        "attempts": 0,
        "createdAt": FieldValue.serverTimestamp(),
        "expiresAt": Timestamp.fromDate(
          DateTime.now().add(
            const Duration(minutes: 10),
          ),
        ),
      });

      /// TODO:
      /// Send OTP Email
      ///
      /// await EmailService.sendOtp(
      ///   email: email,
      ///   otp: otp,
      /// );

      Get.snackbar(
        "OTP Generated",
        "OTP has been generated successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.toNamed(
        AppRoutes.otpVerification,
        arguments: {
          "username": username,
          "email": email,
        },
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      loading(false);
    }
  }

  String _generateOtp() {
    final random = Random();

    return (100000 + random.nextInt(900000)).toString();
  }
}