import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/services/session_manager.dart';
import '../model/police_station_model.dart';
import '../pages/police_station_dialog.dart';
import '../services/police_station_service.dart';


class PoliceStationController extends GetxController {
  final PoliceStationService service =
      Get.find<PoliceStationService>();

  /// Form

  final formKey = GlobalKey<FormState>();

  final stationNameController = TextEditingController();

  final districtController = TextEditingController();

  final selectedType = "Urban".obs;

  final selectedStatus = "active".obs;

  /// State

  final loading = false.obs;

  final search = "".obs;

  final stationList = <PoliceStationModel>[].obs;

  StreamSubscription? _subscription;

  /// Edit

  String? editingId;

  DateTime? createdAt;

  @override
  void onInit() {
    super.onInit();

    loadStations();
  }

  //======================== LOAD ========================//

  void loadStations() {
    loading(true);

    _subscription?.cancel();

    _subscription = service.getStations().listen(
      (event) {
        stationList.assignAll(event);

        loading(false);
      },
      onError: (e) {
        loading(false);

        Get.snackbar(
          "Error",
          e.toString(),
        );
      },
    );
  }

  //======================== ADD ========================//

  Future<void> addStation() async {
    if (!formKey.currentState!.validate()) return;

    loading(true);

    try {
      final model = PoliceStationModel(
        id: const Uuid().v4(),

        stationName:
            stationNameController.text.trim(),

        district:
            districtController.text.trim(),

        type: selectedType.value,

        status: selectedStatus.value,

        createdBy: SessionManager.uid,

        createdAt: DateTime.now(),

        updatedAt: DateTime.now(),
      );

      await service.addStation(model);

      clearForm();

      Get.back();

      Get.snackbar(
        "Success",
        "Police Station Added Successfully",
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }

    loading(false);
  }

  //======================== UPDATE ========================//

  Future<void> updateStation() async {
    if (!formKey.currentState!.validate()) return;

    if (editingId == null) return;

    loading(true);

    try {
      final model = PoliceStationModel(
        id: editingId!,

        stationName:
            stationNameController.text.trim(),

        district:
            districtController.text.trim(),

        type: selectedType.value,

        status: selectedStatus.value,

        createdBy: SessionManager.uid,

        createdAt: createdAt ?? DateTime.now(),

        updatedAt: DateTime.now(),
      );

      await service.updateStation(model);

      clearForm();

      editingId = null;

      Get.back();

      Get.snackbar(
        "Success",
        "Station Updated Successfully",
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }

    loading(false);
  }

  //======================== EDIT ========================//

  void editStation(
    PoliceStationModel model,
  ) {
    editingId = model.id;

    createdAt = model.createdAt;

    stationNameController.text =
        model.stationName;

    districtController.text =
        model.district;

    selectedType.value = model.type;

    selectedStatus.value = model.status;

    Get.dialog(
      const PoliceStationDialog(
        isEdit: true,
      ),
    );
  }

  //======================== VIEW ========================//

  void viewStation(
    PoliceStationModel model,
  ) {
    Get.dialog(
      AlertDialog(
        title: Text(model.stationName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("District"),
              subtitle: Text(model.district),
            ),
            ListTile(
              title: const Text("Type"),
              subtitle: Text(model.type),
            ),
            ListTile(
              title: const Text("Status"),
              subtitle: Text(model.status),
            ),
          ],
        ),
      ),
    );
  }

  //======================== DELETE ========================//

  Future<void> deleteStation(
    PoliceStationModel model,
  ) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Delete Station"),
        content: Text(
          "Delete ${model.stationName} ?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (result != true) return;

    await service.softDeleteStation(
      model.id,
    );

    Get.snackbar(
      "Success",
      "Station Deleted",
    );
  }

  //======================== CLEAR ========================//

  void clearForm() {
    editingId = null;

    createdAt = null;

    stationNameController.clear();

    districtController.clear();

    selectedType.value = "Urban";

    selectedStatus.value = "active";
  }

  //======================== EXPORT ========================//

  Future<void> exportExcel() async {
    Get.snackbar(
      "Coming Soon",
      "Excel Export",
    );
  }

  Future<void> exportPdf() async {
    Get.snackbar(
      "Coming Soon",
      "PDF Export",
    );
  }

  //======================== CLOSE ========================//

  @override
  void onClose() {
    stationNameController.dispose();

    districtController.dispose();

    _subscription?.cancel();

    super.onClose();
  }
}