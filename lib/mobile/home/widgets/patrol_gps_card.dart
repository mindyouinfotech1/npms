import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/patrol_controller.dart';

class PatrolGpsCard extends GetView<PatrolController> {
  const PatrolGpsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
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
                    Icons.my_location,
                    color: Colors.indigo,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Verify Current Location",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                "Your live GPS location will be compared with the QR checkpoint location.",
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 25),

              _infoTile(
                Icons.location_on,
                "Checkpoint",
                controller.checkpoint?.checkpointName ?? "-",
              ),

              const Divider(),

              _infoTile(
                Icons.local_police,
                "Police Station",
                controller.checkpoint?.stationName ?? "-",
              ),

              const Divider(),

              _infoTile(
                Icons.pin_drop,
                "Checkpoint Latitude",
                controller.checkpoint?.latitude.toStringAsFixed(6) ??
                    "-",
              ),

              const Divider(),

              _infoTile(
                Icons.pin_drop_outlined,
                "Checkpoint Longitude",
                controller.checkpoint?.longitude
                        .toStringAsFixed(6) ??
                    "-",
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _valueRow(
                      "Current Latitude",
                      controller.latitude.value == 0
                          ? "-"
                          : controller.latitude.value
                              .toStringAsFixed(6),
                    ),

                    const SizedBox(height: 12),

                    _valueRow(
                      "Current Longitude",
                      controller.longitude.value == 0
                          ? "-"
                          : controller.longitude.value
                              .toStringAsFixed(6),
                    ),

                    const SizedBox(height: 12),

                    _valueRow(
                      "GPS Accuracy",
                      "${controller.accuracy.value.toStringAsFixed(1)} m",
                    ),

                    const SizedBox(height: 12),

                    _valueRow(
                      "Distance",
                      "${controller.distance.value.toStringAsFixed(2)} m",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              if (controller.gpsReady.value)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.green,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "GPS location captured successfully.\nDistance: ${controller.distance.value.toStringAsFixed(2)} meters",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // if (controller.gpsReady.value)
              //   Container(
              //     width: double.infinity,
              //     padding: const EdgeInsets.all(15),
              //     decoration: BoxDecoration(
              //       color: controller.distance.value <= 30
              //           ? Colors.green.shade50
              //           : Colors.red.shade50,
              //       borderRadius: BorderRadius.circular(12),
              //       border: Border.all(
              //         color: controller.distance.value <= 30
              //             ? Colors.green
              //             : Colors.red,
              //       ),
              //     ),
              //     child: Row(
              //       children: [
              //         Icon(
              //           controller.distance.value <= 30
              //               ? Icons.check_circle
              //               : Icons.warning,
              //           color: controller.distance.value <= 30
              //               ? Colors.green
              //               : Colors.red,
              //         ),

              //         const SizedBox(width: 12),

              //         Expanded(
              //           child: Text(
              //             controller.distance.value <= 30
              //                 ? "Location verified successfully.\nYou are within the allowed patrol range."
              //                 : "You are outside the allowed patrol range.\nMove closer to the checkpoint.",
              //             style: TextStyle(
              //               fontWeight: FontWeight.w600,
              //               color:
              //                   controller.distance.value <= 30
              //                       ? Colors.green.shade800
              //                       : Colors.red.shade800,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text("Refresh GPS"),
                      onPressed:
                          controller.getCurrentLocation,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Continue"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(
                          double.infinity,
                          50,
                        ),
                      ),
                      onPressed: controller.distance.value <= 30
                          ? () {
                              controller.currentStep.value =
                                  3;
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: Colors.indigo,
      ),
      title: Text(title),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _valueRow(
    String title,
    String value,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
      ],
    );
  }
}