import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/officer_controller.dart';

class OfficerDialog extends GetView<OfficerController> {
  final bool isEdit;

  const OfficerDialog({
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
        isEdit ? "Edit Officer" : "Add Officer",
      ),
      content: SizedBox(
        width: 700,
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //----------------------------------------
                // Name
                //----------------------------------------

                TextFormField(
                  controller: controller.fullNameController,
                  decoration: const InputDecoration(
                    labelText: "Officer Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                //----------------------------------------
                // Mobile
                //----------------------------------------

                TextFormField(
                  controller: controller.mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Mobile Number",
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),

                const SizedBox(height: 16),

                //----------------------------------------
                // Email
                //----------------------------------------

                TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 16),

                //----------------------------------------
                // Badge ID
                //----------------------------------------

                TextFormField(
                  controller: controller.badgeIdController,
                  decoration: const InputDecoration(
                    labelText: "Badge ID",
                    prefixIcon: Icon(Icons.badge),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                //----------------------------------------
                // Password
                //----------------------------------------

                TextFormField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }

                    if (value.length < 6) {
                      return "Minimum 6 characters";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                //----------------------------------------
                // Rank
                //----------------------------------------

                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedRank.value,
                    decoration: const InputDecoration(
                      labelText: "Rank",
                      prefixIcon: Icon(Icons.workspace_premium),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Constable",
                        child: Text("Constable"),
                      ),
                      DropdownMenuItem(
                        value: "Head Constable",
                        child: Text("Head Constable"),
                      ),
                      DropdownMenuItem(
                        value: "ASI",
                        child: Text("ASI"),
                      ),
                      DropdownMenuItem(
                        value: "SI",
                        child: Text("Sub Inspector"),
                      ),
                      DropdownMenuItem(
                        value: "Inspector",
                        child: Text("Inspector"),
                      ),
                    ],
                    onChanged: (value) {
                      controller.selectedRank.value = value!;
                    },
                  ),
                ),

                const SizedBox(height: 16),

                //----------------------------------------
                // Station
                //----------------------------------------

                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedStationId.value.isEmpty
                        ? null
                        : controller.selectedStationId.value,
                    decoration: const InputDecoration(
                      labelText: "Police Station",
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
                    validator: (value) {
                      if (value == null) {
                        return "Select Police Station";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final station = controller.stationList.firstWhere(
                        (e) => e.id == value,
                      );

                      controller.selectedStationId.value = station.id;
                      controller.selectedStationName.value =
                          station.stationName;
                    },
                  ),
                ),

                const SizedBox(height: 16),

                //----------------------------------------
                // Shift
                //----------------------------------------

                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedShift.value,
                    decoration: const InputDecoration(
                      labelText: "Shift",
                      prefixIcon: Icon(Icons.schedule),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Day",
                        child: Text("Day"),
                      ),
                      DropdownMenuItem(
                        value: "Night",
                        child: Text("Night"),
                      ),
                      DropdownMenuItem(
                        value: "General",
                        child: Text("General"),
                      ),
                    ],
                    onChanged: (value) {
                      controller.selectedShift.value = value!;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Get.back(),
          child: const Text("Cancel"),
        ),
        ElevatedButton.icon(
          icon: Icon(
            isEdit ? Icons.save : Icons.person_add,
          ),
          label: Text(
            isEdit ? "Update" : "Create",
          ),
          onPressed: () async {
            if (isEdit) {
              await controller.updateOfficer();
            } else {
              await controller.createOfficer();
            }
          },
        ),
      ],
    );
  }
}