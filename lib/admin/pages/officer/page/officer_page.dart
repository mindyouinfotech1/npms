import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/officer_controller.dart';
import '../widgets/OfficerDialog.dart';
import '../widgets/OfficerTable.dart';

class OfficerPage extends GetView<OfficerController> {
  const OfficerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ===============================
          /// HEADER
          /// ===============================
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Officer Management",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Manage Police Officers",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add),
                    label: const Text("Add Officer"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFFC107),
                      foregroundColor: const Color(0xff081A3A),
                    ),
                    onPressed: () {
                      controller.clearForm();

                      Get.dialog(
                        const OfficerDialog(),
                        barrierDismissible: false,
                      );
                    },
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Officer Management",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Manage Police Officers",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 170,
                    maxWidth: 220,
                    minHeight: 45,
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add),
                    label: const Text("Add Officer"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xffFFC107),
                      foregroundColor:
                          const Color(0xff081A3A),
                    ),
                    onPressed: () {
                      controller.clearForm();

                      Get.dialog(
                        const OfficerDialog(),
                        barrierDismissible: false,
                      );
                    },
                  ),
                ),
              ],
            ),

          const SizedBox(height: 25),

          /// ===============================
          /// TABLE
          /// ===============================
          const Expanded(
            child: OfficerTable(),
          ),
        ],
      ),
    );
  }
}