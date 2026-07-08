import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        title: const Text("Terms & Conditions"),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.amber.shade100,
                    child: const Icon(
                      Icons.gavel,
                      color: Colors.amber,
                      size: 40,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const Center(
                  child: Text(
                    "Terms & Conditions",
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
                      color: Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                _section(
                  "1. Acceptance of Terms",
                  "By using the RentLoco application or website, you agree to comply with these Terms & Conditions. If you do not agree, please discontinue using our services.",
                ),

                _section(
                  "2. Eligibility",
                  "You must be at least 18 years old and capable of entering into legally binding agreements to rent products from RentLoco.",
                ),

                _section(
                  "3. Account Registration",
                  "• Provide accurate personal information.\n"
                  "• Complete KYC verification.\n"
                  "• Keep your login credentials secure.\n"
                  "• You are responsible for all activities under your account.",
                ),

                _section(
                  "4. Product Rental",
                  "• Products remain the property of RentLoco.\n"
                  "• Monthly rent must be paid before the due date.\n"
                  "• Rental tenure starts from the delivery date.\n"
                  "• Products must be used responsibly.",
                ),

                _section(
                  "5. Security Deposit",
                  "A refundable security deposit may be collected before delivery. Refunds will be processed after product inspection and clearance of outstanding dues.",
                ),

                _section(
                  "6. Delivery & Pickup",
                  "• Delivery dates depend on product availability.\n"
                  "• Pickup requests should be submitted through the app.\n"
                  "• Pickup charges may apply depending on the location.",
                ),

                _section(
                  "7. Damage & Loss",
                  "Customers are responsible for any damage, misuse, theft, or loss of rented products. Repair or replacement charges may apply.",
                ),

                _section(
                  "8. Payments",
                  "• Rent must be paid on time.\n"
                  "• Late payments may incur penalties.\n"
                  "• All payments are processed through secure payment gateways.",
                ),

                _section(
                  "9. Cancellation Policy",
                  "Orders may be cancelled before dispatch. Cancellation charges may apply based on the order stage and company policy.",
                ),

                _section(
                  "10. Service Requests",
                  "Customers can raise service requests for repair, replacement, installation, or pickup through the RentLoco application.",
                ),

                _section(
                  "11. Account Suspension",
                  "RentLoco reserves the right to suspend or terminate accounts involved in fraudulent activities, policy violations, or misuse of rented products.",
                ),

                _section(
                  "12. Limitation of Liability",
                  "RentLoco shall not be liable for indirect, incidental, or consequential damages arising from the use of rented products or the platform.",
                ),

                _section(
                  "13. Changes to Terms",
                  "RentLoco reserves the right to modify these Terms & Conditions at any time. Updated terms will be published in the application.",
                ),

                _section(
                  "14. Contact Information",
                  "Email : support@rentloco.com\n"
                  "Phone : +91 9876543210\n"
                  "Website : www.rentloco.com",
                ),

                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Icon(
                        Icons.info_outline,
                        color: Colors.amber,
                      ),

                      SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          "By continuing to use RentLoco, you acknowledge that you have read, understood, and agreed to these Terms & Conditions.",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Center(
                  child: Text(
                    "© 2026 RentLoco. All Rights Reserved.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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