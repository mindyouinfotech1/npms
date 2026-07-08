import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/admin_auth_service.dart';
import '../../../core/routes/appRoutes.dart';
import '../../../core/services/session_manager.dart';

class AdminAuthController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final authService = Get.find<AdminAuthService>();

  RxBool obscurePassword = true.obs;
  RxBool rememberMe = true.obs;
  RxBool loading = false.obs;

  void togglePassword() {
    obscurePassword.toggle();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    loading(true);

    try {
      final user = await authService.login(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (user == null) {
        Get.snackbar(
          "Login Failed",
          "Invalid username or password",
        );

        loading(false);
        return;
      }

     await SessionManager.saveUser(
        uid: user.id,
        username: user.username,
        name: user.name,
      );

      Get.snackbar(
        "Success",
        "Welcome ${user.name}",
      );

      Get.offAllNamed(AppRoutes.adminHomePage);

    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }

    loading(false);
  }
}