import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/forgot_password_controller.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

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
                        )
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
                    "Forgot Password",
                    style: TextStyle(
                      color: Color(0xffFFC107),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Enter your username and registered\nemail address to receive OTP.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 35),

                  TextFormField(
                    controller: controller.usernameController,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Enter Username";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Username",
                      prefixIcon: const Icon(Icons.person_outline),
                      filled: true,
                      fillColor: const Color(0xff22375F),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: controller.emailController,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Enter Registered Email";
                      }

                      if (!GetUtils.isEmail(value.trim())) {
                        return "Enter Valid Email";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Registered Email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: const Color(0xff22375F),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: controller.loading.value
                            ? null
                            : controller.sendOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFFC107),
                          foregroundColor: const Color(0xff081A3A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: controller.loading.value
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xff081A3A),
                                ),
                              )
                            : const Text(
                                "SEND OTP",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextButton.icon(
                    onPressed: () {
                      Get.back();
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