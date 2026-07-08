import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/police_station_controller.dart';

class PoliceStationDialog extends GetView<PoliceStationController> {
  final bool isEdit;

  const PoliceStationDialog({
    super.key,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      title: Text(
        isEdit
            ? "Edit Police Station"
            : "Add Police Station",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: 500,
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// Station Name
                TextFormField(
                  controller:
                      controller.stationNameController,
                  decoration: const InputDecoration(
                    labelText: "Police Station Name",
                    prefixIcon: Icon(Icons.local_police),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return "Station Name is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                /// District
                TextFormField(
                  controller:
                      controller.districtController,
                  decoration: const InputDecoration(
                    labelText: "District / Thana",
                    prefixIcon:
                        Icon(Icons.location_city),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return "District is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                /// Station Type
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedType.value,
                    decoration: const InputDecoration(
                      labelText: "Station Type",
                      prefixIcon:
                          Icon(Icons.apartment),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Urban",
                        child: Text("Urban"),
                      ),
                      DropdownMenuItem(
                        value: "Rural",
                        child: Text("Rural"),
                      ),
                    ],
                    onChanged: (value) {
                      controller.selectedType.value =
                          value!;
                    },
                  ),
                ),

                const SizedBox(height: 18),

                /// Status
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedStatus.value,
                    decoration: const InputDecoration(
                      labelText: "Status",
                      prefixIcon:
                          Icon(Icons.verified),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "active",
                        child: Text("Active"),
                      ),
                      DropdownMenuItem(
                        value: "inactive",
                        child: Text("Inactive"),
                      ),
                    ],
                    onChanged: (value) {
                      controller.selectedStatus.value =
                          value!;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20,
      ),
      actions: [

        OutlinedButton(
          onPressed: () => Get.back(),
          child: const Text("Cancel"),
        ),

        ElevatedButton.icon(
          icon: Icon(
            isEdit
                ? Icons.save
                : Icons.add_business,
          ),
          label: Text(
            isEdit
                ? "Update"
                : "Save",
          ),
          onPressed: () async {

            if (isEdit) {
              await controller.updateStation();
            } else {
              await controller.addStation();
            }

            Get.back();
          },
        ),
      ],
    );
  }
}