import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mobile/auth/controller/auth_controller.dart';


class OfficerLoginPage extends GetView<OfficerLoginController> {
  const OfficerLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff081A3A),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 30,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),
              child: Card(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                      children: [
                        //----------------------------------------
                        // Logo
                        //----------------------------------------

                        CircleAvatar(
                          radius: 55,
                          backgroundColor:
                              const Color(0xffFFC107),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                const AssetImage(
                              "assets/logo.jpeg",
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "KAIMUR POLICE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: Color(0xff081A3A),
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "Night Patrol Monitoring System",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 35),

                        //----------------------------------------
                        // Badge ID
                        //----------------------------------------

                        TextFormField(
                          controller:
                              controller.badgeIdController,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return "Enter Badge ID";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Badge ID",
                            hintText: "Enter Badge ID",
                            prefixIcon:
                                const Icon(Icons.badge),
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        //----------------------------------------
                        // Password
                        //----------------------------------------

                        Obx(
                          () => TextFormField(
                            controller: controller
                                .passwordController,
                            obscureText:
                                controller.hidePassword.value,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty) {
                                return "Enter Password";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter Password",
                              prefixIcon:
                                  const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.hidePassword
                                          .value
                                      ? Icons.visibility
                                      : Icons
                                          .visibility_off,
                                ),
                                onPressed: controller
                                    .togglePassword,
                              ),
                              border:
                                  OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  14,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        //----------------------------------------
                        // Login Button
                        //----------------------------------------

                        SizedBox(
                          height: 55,
                          child: Obx(
                            () => ElevatedButton.icon(
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(
                                  0xffFFC107,
                                ),
                                foregroundColor:
                                    Colors.black,
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    14,
                                  ),
                                ),
                              ),
                              onPressed:
                                  controller.loading.value
                                      ? null
                                      : controller.login,
                              icon: controller
                                      .loading.value
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child:
                                          CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.black,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.login,
                                    ),
                              label: Text(
                                controller.loading.value
                                    ? "Please Wait..."
                                    : "LOGIN",
                                style:
                                    const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        const Divider(),

                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.security,
                              color: Colors.green,
                              size: 18,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "256 Bit Secure Login",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "© Kaimur Police",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}