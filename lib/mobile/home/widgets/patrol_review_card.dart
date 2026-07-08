import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/patrol_controller.dart';

class PatrolReviewCard extends GetView<PatrolController> {
  const PatrolReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //------------------------------------------------------
              // Header
              //------------------------------------------------------

              const Row(
                children: [
                  Icon(
                    Icons.fact_check,
                    color: Colors.green,
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Review Patrol",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                "Please verify all information before submitting the patrol.",
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 25),

              //------------------------------------------------------
              // Officer Details
              //------------------------------------------------------

              _sectionTitle("Officer Information"),

              _tile(
                Icons.person,
                "Officer",
                controller.officerName,
              ),

              _tile(
                Icons.badge,
                "Badge ID",
                controller.badgeId,
              ),

              _tile(
                Icons.workspace_premium,
                "Rank",
                controller.rank,
              ),

              _tile(
                Icons.local_police,
                "Police Station",
                controller.stationName,
              ),

              const Divider(height: 35),

              //------------------------------------------------------
              // Checkpoint
              //------------------------------------------------------

              _sectionTitle("Checkpoint"),

              _tile(
                Icons.qr_code,
                "QR ID",
                controller.checkpoint?.qrId ?? "-",
              ),

              _tile(
                Icons.location_on,
                "Checkpoint",
                controller.checkpoint?.checkpointName ?? "-",
              ),

              _tile(
                Icons.flag,
                "Priority",
                controller.checkpoint?.priority ?? "-",
              ),

              const Divider(height: 35),

              //------------------------------------------------------
              // GPS
              //------------------------------------------------------

              _sectionTitle("GPS Verification"),

              _tile(
                Icons.pin_drop,
                "Latitude",
                controller.latitude.value.toStringAsFixed(6),
              ),

              _tile(
                Icons.pin_drop_outlined,
                "Longitude",
                controller.longitude.value.toStringAsFixed(6),
              ),

              _tile(
                Icons.gps_fixed,
                "Accuracy",
                "${controller.accuracy.value.toStringAsFixed(2)} m",
              ),

              _tile(
                Icons.social_distance,
                "Distance",
                "${controller.distance.value.toStringAsFixed(2)} m",
              ),

              const Divider(height: 35),

              //------------------------------------------------------
              // Photo
              //------------------------------------------------------

              _sectionTitle("Captured Photo"),

              const SizedBox(height: 12),

              if (controller.imageCaptured.value)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(controller.imagePath.value),
                    width: double.infinity,
                    height: 260,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      "No Photo",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 25),

              //------------------------------------------------------
              // Remarks
              //------------------------------------------------------

              const Text(
                "Remarks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: controller.remarksController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      "Write patrol observations (optional)...",
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //------------------------------------------------------
              // Buttons
              //------------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Back"),
                      onPressed: () {
                        controller.currentStep.value = 3;
                      },
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: ElevatedButton.icon(
                      icon: controller.loading.value
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.check),

                      label: const Text(
                        "Submit Patrol",
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.green.shade700,
                        foregroundColor: Colors.white,
                        minimumSize:
                            const Size(double.infinity, 55),
                      ),

                      onPressed: controller.loading.value
                          ? null
                          : controller.submitPatrol,
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

  //------------------------------------------------------
  // Section Title
  //------------------------------------------------------

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }

  //------------------------------------------------------
  // Tile
  //------------------------------------------------------

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
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}