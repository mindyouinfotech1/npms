import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/appRoutes.dart';
import '../../../../core/services/admin_auth_service.dart';

class ResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final authService = Get.find<AdminAuthService>();

  final loading = false.obs;

  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;

  late String username;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null) {
      Get.offAllNamed(AppRoutes.adminLoginPage);
      return;
    }

    username = args["username"] ?? "";
  }

  void togglePassword() {
    obscurePassword.toggle();
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword.toggle();
  }

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Password Mismatch",
        "Passwords do not match.",
      );
      return;
    }

    loading(true);

    try {
      final hash = BCrypt.hashpw(
        passwordController.text.trim(),
        BCrypt.gensalt(),
      );

      final success = await authService.resetPassword(
        username: username,
        hashedPassword: hash,
      );

      if (!success) {
        Get.snackbar(
          "Error",
          "Unable to reset password.",
        );
        return;
      }

      Get.snackbar(
        "Success",
        "Password updated successfully.",
      );

      Get.offAllNamed(AppRoutes.adminLoginPage);
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
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}