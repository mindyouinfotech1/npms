import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/reset_password_controller.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff081A3A),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 430,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xff132A54),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// Logo
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffFFC107),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(.35),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/logo.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Reset Password",
                    style: TextStyle(
                      color: Color(0xffFFC107),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Enter your new password below.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// Password

                  Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
                      obscureText: controller.obscurePassword.value,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter New Password";
                        }

                        if (value.length < 8) {
                          return "Minimum 8 characters required";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "New Password",
                        prefixIcon:
                            const Icon(Icons.lock_outline),

                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed:
                              controller.togglePassword,
                        ),

                        filled: true,
                        fillColor:
                            const Color(0xff22375F),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Confirm Password

                  Obx(
                    () => TextFormField(
                      controller:
                          controller.confirmPasswordController,
                      obscureText:
                          controller.obscureConfirmPassword.value,
                      style:
                          const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return "Confirm Password";
                        }

                        if (value !=
                            controller.passwordController.text) {
                          return "Passwords do not match";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Confirm Password",

                        prefixIcon:
                            const Icon(Icons.lock_reset),

                        suffixIcon: IconButton(
                          icon: Icon(
                            controller
                                    .obscureConfirmPassword
                                    .value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller
                              .toggleConfirmPassword,
                        ),

                        filled: true,

                        fillColor:
                            const Color(0xff22375F),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed:
                            controller.loading.value
                                ? null
                                : controller.resetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xffFFC107),
                          foregroundColor:
                              const Color(0xff081A3A),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),
                        child: controller.loading.value
                            ? const CircularProgressIndicator(
                                color:
                                    Color(0xff081A3A),
                              )
                            : const Text(
                                "UPDATE PASSWORD",
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextButton.icon(
                    onPressed: () {
                      Get.offAllNamed("/adminLogin");
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.amber,
                    ),
                    label: const Text(
                      "Back to Login",
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Divider(color: Colors.white24),

                  const SizedBox(height: 10),

                  const Text(
                    "Government of Bihar • Kaimur District Police",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "NPMS v1.0",
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}