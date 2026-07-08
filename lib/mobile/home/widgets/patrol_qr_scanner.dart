import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controller/patrol_controller.dart';



class PatrolQrScanner extends GetView<PatrolController> {
  const PatrolQrScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.qr_code_scanner,
                  color: Colors.indigo,
                ),
                SizedBox(width: 10),
                Text(
                  "Scan Patrol Checkpoint",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              "Scan the QR Code installed at the checkpoint to continue patrol.",
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              height: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.indigo,
                  width: 2,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: MobileScanner(
                controller: controller.scannerController,
                onDetect: controller.onQrDetected,
              ),
            ),

            const SizedBox(height: 20),

            Obx(() {
              if (!controller.qrScanned.value) {
                return const SizedBox();
              }

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green,
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 40,
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "QR Scanned Successfully",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    if (controller.checkpoint != null) ...[
                      ListTile(
                        dense: true,
                        leading: const Icon(Icons.location_on),
                        title: const Text("Checkpoint"),
                        subtitle: Text(
                          controller
                              .checkpoint!.checkpointName,
                        ),
                      ),

                      ListTile(
                        dense: true,
                        leading:
                            const Icon(Icons.local_police),
                        title:
                            const Text("Police Station"),
                        subtitle: Text(
                          controller
                              .checkpoint!.stationName,
                        ),
                      ),

                      ListTile(
                        dense: true,
                        leading: const Icon(Icons.flag),
                        title: const Text("Priority"),
                        subtitle: Text(
                          controller.checkpoint!.priority,
                        ),
                      ),
                    ],

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon:
                            const Icon(Icons.location_on),
                        label:
                            const Text("Continue"),
                        onPressed:
                            controller.getCurrentLocation,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 10),

            Center(
              child: TextButton.icon(
                onPressed: controller.resetPatrol,
                icon: const Icon(Icons.refresh),
                label: const Text("Scan Again"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}