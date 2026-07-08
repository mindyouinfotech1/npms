import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/qr_management_controller.dart';
import '../widgets/qr_dialog.dart';
import '../widgets/qr_table.dart';

class QrManagementPage extends GetView<QrManagementController> {
  const QrManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;

        return Container(
          color: Colors.transparent,
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "QR Checkpoint Management",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "Manage Patrol QR Checkpoints",
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
                            onPressed: () {
                              controller.clearForm();

                              Get.dialog(
                                const QrDialog(),
                                barrierDismissible: false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xffFFC107),
                              foregroundColor:
                                  const Color(0xff081A3A),
                            ),
                            icon: const Icon(Icons.add),
                            label: const Text("New Checkpoint"),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "QR Checkpoint Management",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Manage Patrol QR Checkpoints",
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
                            minHeight: 48,
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              controller.clearForm();

                              Get.dialog(
                                const QrDialog(),
                                barrierDismissible: false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xffFFC107),
                              foregroundColor:
                                  const Color(0xff081A3A),
                            ),
                            icon: const Icon(Icons.add),
                            label:
                                const Text("New Checkpoint"),
                          ),
                        ),
                      ],
                    ),

              SizedBox(height: isMobile ? 16 : 25),

              const Expanded(
                child: QrTable(),
              ),
            ],
          ),
        );
      },
    );
  }
}