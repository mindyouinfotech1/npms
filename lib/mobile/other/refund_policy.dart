import 'package:flutter/material.dart';

class RefundPolicyPage extends StatelessWidget {
  const RefundPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        title: const Text("Refund Policy"),
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
                    backgroundColor: Colors.green.shade100,
                    child: const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const Center(
                  child: Text(
                    "Refund Policy",
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
                  "1. Introduction",
                  "This Refund Policy explains how refunds are processed for rental payments, security deposits, cancellations, and other eligible transactions made through the RentLoco platform.",
                ),

                _section(
                  "2. Rental Payments",
                  "Monthly rental payments are generally non-refundable once the billing cycle has started. If an incorrect payment is made due to a technical issue, please contact our support team immediately.",
                ),

                _section(
                  "3. Security Deposit Refund",
                  "Security deposits are refundable after the rented products are returned, inspected, and approved. Any outstanding rent, damages, missing accessories, or repair costs will be deducted before the refund is processed.",
                ),

                _section(
                  "4. Cancellation Refund",
                  "If an order is cancelled before dispatch, eligible payments may be refunded after deducting applicable cancellation charges. Orders cancelled after delivery are subject to the rental agreement.",
                ),

                _section(
                  "5. Damaged or Missing Products",
                  "If the returned product is damaged, missing components, or requires repairs due to misuse, the applicable charges will be deducted from the refundable security deposit.",
                ),

                _section(
                  "6. Refund Processing Time",
                  "Approved refunds are normally processed within 5–10 business days depending on the payment method and banking partner.",
                ),

                _section(
                  "7. Refund Methods",
                  "Refunds are credited through the original payment method whenever possible. If unavailable, the refund will be transferred to the customer's verified bank account or UPI ID.",
                ),

                _section(
                  "8. Non-Refundable Charges",
                  "The following charges are generally non-refundable:\n\n"
                  "• Late payment penalties\n"
                  "• Pickup charges (if applicable)\n"
                  "• Damage recovery charges\n"
                  "• Installation charges\n"
                  "• Convenience fees",
                ),

                _section(
                  "9. Refund Status",
                  "Customers can track refund requests directly from the 'Security Deposit Refund History' section of the RentLoco application.",
                ),

                _section(
                  "10. Failed Refunds",
                  "If a refund fails due to incorrect bank details, inactive accounts, or payment gateway issues, our support team will contact you to update the payment information.",
                ),

                _section(
                  "11. Contact Support",
                  "For any refund-related queries, please contact our support team with your Order ID and Transaction ID for faster assistance.",
                ),

                _section(
                  "12. Contact Information",
                  "Email : support@rentloco.com\n"
                  "Phone : +91 9876543210\n"
                  "Website : www.rentloco.com",
                ),

                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Icon(
                        Icons.info_outline,
                        color: Colors.green,
                      ),

                      SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          "Refund approval depends on successful product inspection, outstanding dues, and compliance with the RentLoco rental agreement.",
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