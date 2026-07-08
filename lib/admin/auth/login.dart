import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../admin/auth/forgot_password.dart';
import '../../core/routes/appRoutes.dart';
import 'controller/admin_auth_controller.dart';

class AdminLoginPage extends GetView<AdminAuthController> {
  const AdminLoginPage({super.key});

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
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xffFFC107),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.35),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/logo.jpeg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),

                  const SizedBox(height: 20),

                  const Text(
                    "NPMS",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFFC107),
                      letterSpacing: 4,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "KAIMUR POLICE",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Night Patrol Monitoring System\nAdministrator Portal",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Administrator Login",
                      style: TextStyle(
                        color: Colors.amber.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  TextFormField(
                    controller: controller.usernameController,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
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

                  Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
                      obscureText: controller.obscurePassword.value,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller.togglePassword,
                        ),
                        filled: true,
                        fillColor: const Color(0xff22375F),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [

                      Obx(
                        () => Checkbox(
                          value: controller.rememberMe.value,
                          activeColor: Colors.amber,
                          onChanged: (value) {
                            controller.rememberMe(value!);
                          },
                        ),
                      ),

                      const Text(
                        "Remember Me",
                        style: TextStyle(color: Colors.white70),
                      ),

                      const Spacer(),

                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.forgotPasswordPage);
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.amber),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: controller.loading.value
                            ? null
                            : controller.login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFFC107),
                          foregroundColor: const Color(0xff081A3A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: controller.loading.value
                            ? const CircularProgressIndicator()
                            : const Text(
                                "LOGIN TO NPMS",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Government of Bihar • Kaimur District Police",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "NPMS v2.1",
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 11,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}