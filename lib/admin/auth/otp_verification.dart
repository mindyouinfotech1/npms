import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/otp_verification_controller.dart';

class OtpVerificationPage extends GetView<OtpVerificationController> {
  const OtpVerificationPage({super.key});

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
                    "OTP Verification",
                    style: TextStyle(
                      color: Color(0xffFFC107),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "OTP has been sent to\n${controller.email}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 35),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      6,
                      (index) => _otpBox(
                        controller.controllers[index],
                        index,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Obx(
                    () => Text(
                      controller.remainingTime.value > 0
                          ? "Resend OTP in ${controller.remainingTime.value}s"
                          : "Didn't receive OTP?",
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Obx(
                    () => TextButton(
                      onPressed: controller.remainingTime.value == 0
                          ? controller.resendOtp
                          : null,
                      child: const Text(
                        "Resend OTP",
                        style: TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: controller.loading.value
                            ? null
                            : controller.verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFFC107),
                          foregroundColor: const Color(0xff081A3A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: controller.loading.value
                            ? const CircularProgressIndicator(
                                color: Color(0xff081A3A),
                              )
                            : const Text(
                                "VERIFY OTP",
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
                    onPressed: Get.back,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.amber,
                    ),
                    label: const Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.amber,
                      ),
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

Widget _otpBox(
  TextEditingController controller,
  int index,
) {
  return SizedBox(
    width: 48,
    child: TextFormField(
      controller: controller,
      focusNode: this.controller.focusNodes[index],
      autofocus: index == 0,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        counterText: "",
        filled: true,
        fillColor: const Color(0xff22375F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          this.controller.moveNext(index);
        } else {
          this.controller.movePrevious(index);
        }
      },
    ),
  );
}
}