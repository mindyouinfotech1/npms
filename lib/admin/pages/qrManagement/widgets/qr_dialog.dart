import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/qr_management_controller.dart';

class QrDialog extends GetView<QrManagementController> {
  final bool isEdit;

  const QrDialog({
    super.key,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        isEdit
            ? "Edit QR Checkpoint"
            : "Create QR Checkpoint",
      ),
      content: SizedBox(
        width: 700,
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                TextFormField(
                  controller:
                      controller.checkpointNameController,
                  decoration: const InputDecoration(
                    labelText: "Checkpoint Name",
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller:
                      controller.areaDescriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "Area Description",
                    prefixIcon: Icon(Icons.description),
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: [

                    Expanded(
                      child: TextFormField(
                        controller:
                            controller.latitudeController,
                        keyboardType:
                            TextInputType.number,
                        decoration:
                            const InputDecoration(
                          labelText: "Latitude",
                          prefixIcon:
                              Icon(Icons.pin_drop),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: TextFormField(
                        controller:
                            controller.longitudeController,
                        keyboardType:
                            TextInputType.number,
                        decoration:
                            const InputDecoration(
                          labelText: "Longitude",
                          prefixIcon: Icon(
                            Icons.pin_drop_outlined,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller
                            .selectedStationId.value
                            .isEmpty
                        ? null
                        : controller
                            .selectedStationId.value,
                    decoration: const InputDecoration(
                      labelText: "Police Station",
                      prefixIcon:
                          Icon(Icons.local_police),
                    ),
                    items: controller.stationList
                        .map(
                          (station) =>
                              DropdownMenuItem(
                            value: station.id,
                            child: Text(station.stationName),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;

                      final station = controller
                          .stationList
                          .firstWhere(
                        (e) => e.id == value,
                      );

                      controller.selectedStationId
                          .value = station.id;

                      controller.selectedStationName
                          .value = station.stationName;
                    },
                  ),
                ),

                const SizedBox(height: 18),

                Obx(
                  () => DropdownButtonFormField<String>(
                    value:
                        controller.selectedPriority.value,
                    decoration: const InputDecoration(
                      labelText: "Priority",
                      prefixIcon: Icon(Icons.flag),
                    ),
                    items: const [

                      DropdownMenuItem(
                        value: "Low",
                        child: Text("Low"),
                      ),

                      DropdownMenuItem(
                        value: "Medium",
                        child: Text("Medium"),
                      ),

                      DropdownMenuItem(
                        value: "High",
                        child: Text("High"),
                      ),

                      DropdownMenuItem(
                        value: "Critical",
                        child: Text("Critical"),
                      ),
                    ],
                    onChanged: (value) {
                      controller.selectedPriority.value =
                          value!;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [

        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),

        ElevatedButton.icon(
          icon: Icon(
            isEdit
                ? Icons.save
                : Icons.qr_code,
          ),
          label: Text(
            isEdit
                ? "Update"
                : "Generate QR",
          ),
          onPressed: () async {

            if (isEdit) {
              await controller.updateCheckpoint();
            } else {
              await controller.addCheckpoint();
            }

            Get.back();
          },
        ),
      ],
    );
  }
}