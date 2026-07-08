import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  final String mobile;

  const RegisterPage({
    super.key,
    required this.mobile,
  });

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();

  final middleNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final emailController = TextEditingController();

  String gender = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Complete Registration",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),

          child: Form(
            key: formKey,

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Center(
                  child: Image.asset(
                    "assets/logo.jpeg",
                    height: 55,
                  ),
                ),

                const SizedBox(height: 25),

                Center(
                  child: Image.asset(
                    "assets/rentlogohero.png",
                    height: 150,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Complete Your Profile",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Almost done! Fill your basic details to continue.",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 30),

                _textField(
                  controller: firstNameController,
                  label: "First Name",
                  hint: "Enter first name",
                ),

                const SizedBox(height: 18),

                _textField(
                  controller: middleNameController,
                  label: "Middle Name (Optional)",
                  hint: "Enter middle name",
                ),

                const SizedBox(height: 18),

                _textField(
                  controller: lastNameController,
                  label: "Last Name",
                  hint: "Enter last name",
                ),

                const SizedBox(height: 18),

                _textField(
                  controller: emailController,
                  label: "Email Address",
                  hint: "Enter email",
                  keyboardType:
                      TextInputType.emailAddress,
                ),

                const SizedBox(height: 18),

                const Text(
                  "Verified Mobile Number",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  initialValue: widget.mobile,
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    prefixIcon:
                        const Icon(Icons.phone),
                    suffixIcon: const Icon(
                      Icons.verified,
                      color: Colors.green,
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  "Gender",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  value: gender,

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),

                  items: const [

                    DropdownMenuItem(
                      value: "Male",
                      child: Text("Male"),
                    ),

                    DropdownMenuItem(
                      value: "Female",
                      child: Text("Female"),
                    ),

                    DropdownMenuItem(
                      value: "Other",
                      child: Text("Other"),
                    ),
                  ],

                  onChanged: (value) {

                    setState(() {

                      gender = value!;

                    });

                  },
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 56,

                  child: ElevatedButton(

                    onPressed: () {

                      if (formKey.currentState!
                          .validate()) {

                        /// Register API

                      }

                    },

                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Center(
                  child: Text(
                    "By creating an account you agree to our Terms & Privacy Policy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType =
        TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          keyboardType: keyboardType,

          validator: (value) {

            if (label.contains("Optional")) {
              return null;
            }

            if (value == null ||
                value.trim().isEmpty) {
              return "Required";
            }

            return null;
          },

          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade100,

            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}