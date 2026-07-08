import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/patrol_controller.dart';

class PatrolCameraCard extends GetView<PatrolController> {
  const PatrolCameraCard({super.key});

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
                    Icons.camera_alt,
                    color: Colors.indigo,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Capture Patrol Photo",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                "Capture a live photo as proof of your patrol at this checkpoint.",
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 25),

              //----------------------------------------------------------
              // Checkpoint Details
              //----------------------------------------------------------

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _tile(
                      Icons.location_on,
                      "Checkpoint",
                      controller.checkpoint?.checkpointName ?? "-",
                    ),

                    const Divider(),

                    _tile(
                      Icons.local_police,
                      "Police Station",
                      controller.checkpoint?.stationName ?? "-",
                    ),

                    const Divider(),

                    _tile(
                      Icons.social_distance,
                      "Distance",
                      "${controller.distance.value.toStringAsFixed(2)} m",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              //----------------------------------------------------------
              // Photo Preview
              //----------------------------------------------------------

              if (!controller.imageCaptured.value)
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 70,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "No Photo Captured",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(controller.imagePath.value),
                    width: double.infinity,
                    height: 320,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(height: 25),

              //----------------------------------------------------------
              // Buttons
              //----------------------------------------------------------

              if (!controller.imageCaptured.value)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text(
                      "Capture Photo",
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(
                        double.infinity,
                        55,
                      ),
                    ),
                    onPressed: controller.captureImage,
                  ),
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text("Retake"),
                        onPressed: controller.retakeImage,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("Continue"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(
                            double.infinity,
                            50,
                          ),
                        ),
                        onPressed: () {
                          controller.currentStep.value = 4;
                        },
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  "Photo must be captured using the device camera.\nGallery images are not allowed.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String title,
    String value,
  ) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: Colors.indigo,
      ),
      title: Text(title),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}