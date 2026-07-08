import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        title: const Text("Privacy Policy"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Center(
                  child: CircleAvatar(
                    radius: 38,
                    backgroundColor:
                        Colors.amber.shade100,
                    child: const Icon(
                      Icons.privacy_tip,
                      color: Colors.amber,
                      size: 40,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const Center(
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Center(
                  child: Text(
                    "Last Updated: 29 June 2026",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                _section(
                  "1. Introduction",
                  "RentLoco respects your privacy. This Privacy Policy explains how we collect, use, store and protect your personal information while using our mobile application and website.",
                ),

                _section(
                  "2. Information We Collect",
                  "• Name\n"
                  "• Mobile Number\n"
                  "• Email Address\n"
                  "• Address\n"
                  "• Government ID for KYC\n"
                  "• Payment Information\n"
                  "• Device Information\n"
                  "• Location (with permission)",
                ),

                _section(
                  "3. How We Use Your Information",
                  "• Create and manage your account\n"
                  "• Process rental orders\n"
                  "• Verify KYC documents\n"
                  "• Customer support\n"
                  "• Improve our services\n"
                  "• Send order updates and notifications",
                ),

                _section(
                  "4. Sharing of Information",
                  "We do not sell your personal information. Your data may only be shared with payment providers, logistics partners, KYC verification agencies and government authorities when legally required.",
                ),

                _section(
                  "5. Payment Security",
                  "Payments are processed through secure third-party payment gateways. RentLoco never stores your debit or credit card details on our servers.",
                ),

                _section(
                  "6. Cookies & Analytics",
                  "We may use cookies and analytics services to improve app performance and user experience.",
                ),

                _section(
                  "7. Data Retention",
                  "Your information is retained only as long as required for legal, business and operational purposes.",
                ),

                _section(
                  "8. Your Rights",
                  "You can:\n"
                  "• Update your profile\n"
                  "• Download invoices\n"
                  "• Request account deletion\n"
                  "• Contact support regarding your data",
                ),

                _section(
                  "9. Contact Us",
                  "Email: support@rentloco.com\n"
                  "Phone: +91 9876543210\n"
                  "Website: www.rentloco.com",
                ),

                _section(
                  "10. Changes to this Policy",
                  "RentLoco may update this Privacy Policy from time to time. Any updates will be published within the application.",
                ),

                const SizedBox(height: 30),

                Center(
                  child: Text(
                    "© 2026 RentLoco. All Rights Reserved.",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            body,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}