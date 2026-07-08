import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/appRoutes.dart';
import '../../../../core/services/admin_auth_service.dart';

class OtpVerificationController extends GetxController {
  final authService = Get.find<AdminAuthService>();

  final formKey = GlobalKey<FormState>();

  final loading = false.obs;
  final remainingTime = 60.obs;

  late final String username;
  late final String email;

  Timer? _timer;

  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
      List.generate(6, (_) => FocusNode());

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null) {
      Get.offAllNamed(AppRoutes.adminLoginPage);
      return;
    }

    username = args["username"] ?? "";
    email = args["email"] ?? "";

    debugPrint("Username : $username");
    debugPrint("Email : $email");

    startTimer();

    Future.delayed(const Duration(milliseconds: 300), () {
      focusNodes.first.requestFocus();
    });
  }

  void startTimer() {
    remainingTime.value = 60;

    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainingTime.value <= 0) {
          timer.cancel();
        } else {
          remainingTime.value--;
        }
      },
    );
  }

  String get otp => controllers.map((e) => e.text).join();

  void moveNext(int index) {
    if (index < 5) {
      focusNodes[index + 1].requestFocus();
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void movePrevious(int index) {
    if (index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> verifyOtp() async {
    if (otp.length != 6) {
      Get.snackbar(
        "Invalid OTP",
        "Please enter all 6 digits.",
      );
      return;
    }

    loading(true);

    try {
      final verified = await authService.verifyOtp(
        username: username,
        otp: otp,
      );

      if (!verified) {
        Get.snackbar(
          "Invalid OTP",
          "OTP is incorrect or expired.",
        );

        controllers.forEach((e) => e.clear());

        focusNodes.first.requestFocus();

        return;
      }

      Get.offNamed(
        AppRoutes.resetPassword,
        arguments: {
          "username": username,
        },
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      loading(false);
    }
  }

  Future<void> resendOtp() async {
    loading(true);

    try {
      final sent = await authService.sendOtp(
        username: username,
        email: email,
      );

      if (!sent) {
        Get.snackbar(
          "Error",
          "Unable to resend OTP.",
        );
        return;
      }

      controllers.forEach((e) => e.clear());

      focusNodes.first.requestFocus();

      startTimer();

      Get.snackbar(
        "Success",
        "OTP sent successfully.",
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      loading(false);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();

    for (final c in controllers) {
      c.dispose();
    }

    for (final f in focusNodes) {
      f.dispose();
    }

    super.onClose();
  }
}