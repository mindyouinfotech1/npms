import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/qr_management_controller.dart';

class QrForm extends GetView<QrManagementController> {
  const QrForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Create QR Checkpoint",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [

                  _textField(
                    controller: controller.checkpointNameController,
                    label: "Checkpoint Name",
                    icon: Icons.location_on,
                  ),

                  _textField(
                    controller: controller.areaDescriptionController,
                    label: "Area Description",
                    icon: Icons.description,
                  ),

                  _textField(
                    controller: controller.latitudeController,
                    label: "Latitude",
                    icon: Icons.pin_drop,
                    keyboardType: TextInputType.number,
                  ),

                  _textField(
                    controller: controller.longitudeController,
                    label: "Longitude",
                    icon: Icons.pin_drop_outlined,
                    keyboardType: TextInputType.number,
                  ),

                  SizedBox(
                    width: 320,
                    child: Obx(
                      () => DropdownButtonFormField<String>(
                        value: controller.selectedStationId.value.isEmpty
                            ? null
                            : controller.selectedStationId.value,
                        decoration: const InputDecoration(
                          labelText: "Police Station",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.local_police),
                        ),
                        items: controller.stationList
                            .map(
                              (station) => DropdownMenuItem(
                                value: station.id,
                                child: Text(station.stationName),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;

                          final station = controller.stationList.firstWhere(
                            (e) => e.id == value,
                          );

                          controller.selectedStationId.value =
                              station.id;

                          controller.selectedStationName.value =
                              station.stationName;
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Select Police Station";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 320,
                    child: Obx(
                      () => DropdownButtonFormField<String>(
                        value: controller.selectedPriority.value,
                        decoration: const InputDecoration(
                          labelText: "Priority",
                          border: OutlineInputBorder(),
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
                  ),
                ],
              ),

              const SizedBox(height: 30),

             Wrap(
  spacing: 15,
  runSpacing: 15,
  children: [
    ElevatedButton.icon(
      onPressed: controller.addCheckpoint,
      icon: const Icon(Icons.qr_code),
      label: const Text("Generate QR"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        minimumSize: const Size(170, 50),
      ),
    ),

    OutlinedButton.icon(
      onPressed: controller.clearForm,
      icon: const Icon(Icons.refresh),
      label: const Text("Clear"),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(130, 50),
      ),
    ),

    ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.map),
      label: const Text("Select From Map"),
    ),

    ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.my_location),
      label: const Text("Current Location"),
    ),
  ],
)
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      width: 320,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Required";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}