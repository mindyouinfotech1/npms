import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/services/session_manager.dart';
import '../../station/model/police_station_model.dart';
import '../model/qr_checkpoint_model.dart';
import '../services/qr_management_service.dart';
import '../widgets/qr_dialog.dart';

class QrManagementController extends GetxController {
  final service = Get.find<QrManagementService>();

  final checkpointNameController = TextEditingController();
  final areaDescriptionController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final loading = false.obs;

  final checkpoints = <QrCheckpointModel>[].obs;

    DocumentSnapshot? lastDocument;

    DocumentSnapshot? firstDocument;

    final hasNext = true.obs;

    final hasPrevious = false.obs;

    var page = 1.obs;

    final rowsPerPage = 10.obs;

  final stationList = <PoliceStationModel>[].obs;

  final selectedStationId = "".obs;
  final selectedStationName = "".obs;

  final selectedPriority = "Low".obs;

  final search = "".obs;

  StreamSubscription? _subscription;

  String editingId = "";

  String currentQrId = "";

  String currentQrImage = "";

  Timestamp? currentCreatedAt;

  List<QrCheckpointModel> get filteredList {
    final keyword = search.value.toLowerCase();

    return checkpoints.where((e) {
      return e.qrId.toLowerCase().contains(keyword) ||
          e.checkpointName.toLowerCase().contains(keyword) ||
          e.stationName.toLowerCase().contains(keyword);
    }).toList();
}



List<QrCheckpointModel> get paginatedList {
  final start = (page.value - 1) * rowsPerPage.value;

  if (start >= filteredList.length) {
    return [];
  }

  final end = (start + rowsPerPage.value)
      .clamp(0, filteredList.length);

  return filteredList.sublist(start, end);
}

int get totalPages {
  if (filteredList.isEmpty) return 1;

  return (filteredList.length / rowsPerPage.value).ceil();
}

void nextPage() {
  if (page.value < totalPages) {
    page.value++;
  }
}

void previousPage() {
  if (page.value > 1) {
    page.value--;
  }
}

void changeRowsPerPage(int value) {
  rowsPerPage.value = value;
  page.value = 1;
}


@override
void onInit() {
  super.onInit();

  loadStationList();

  _subscription = service.getCheckpoints().listen((data) {
    checkpoints.assignAll(data);
  });
}


  @override
  void onClose() {
    checkpointNameController.dispose();
    areaDescriptionController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();

    _subscription?.cancel();

    super.onClose();
  }


  
// Future<void> loadCheckpoints() async {
//   loading(true);

//   final snapshot = await service.getPage(
//     limit: rowsPerPage.value,
//   );

//   checkpoints.assignAll(
//     snapshot.docs
//         .map((e) => QrCheckpointModel.fromMap(e.data(), e.id))
//         .toList(),
//   );

//   if (snapshot.docs.isNotEmpty) {
//     firstDocument = snapshot.docs.first;
//     lastDocument = snapshot.docs.last;
//   }

//   hasPrevious.value = false;

//   hasNext.value =
//       snapshot.docs.length == rowsPerPage.value;

//   loading(false);
// }

  Future<void> deleteCheckpoint(
    QrCheckpointModel model) async {

  final result = await Get.dialog<bool>(
    AlertDialog(
      title: const Text("Delete Checkpoint"),
      content: Text(
        "Are you sure you want to delete\n${model.checkpointName} ?",
      ),
      actions: [

        TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            Get.back(result: true);
          },
          child: const Text("Delete"),
        ),
      ],
    ),
  );

  if (result != true) return;

  loading(true);

  try {

    await service.deleteCheckpoint(
      id: model.id,
      deletedBy: SessionManager.uid,
    );

    Get.snackbar(
      "Success",
      "Checkpoint deleted successfully.",
    );

  } catch (e) {

    Get.snackbar(
      "Error",
      e.toString(),
    );

  } finally {

    loading(false);

  }
}

// Future<void> nextPage() async {
//   if (!hasNext.value) return;

//   loading(true);

//   final snapshot = await service.getPage(
//     limit: rowsPerPage.value,
//     startAfter: lastDocument,
//   );

//   checkpoints.assignAll(
//     snapshot.docs
//         .map((e) => QrCheckpointModel.fromMap(e.data(), e.id))
//         .toList(),
//   );

//   firstDocument = snapshot.docs.first;
//   lastDocument = snapshot.docs.last;

//   page++;

//   hasPrevious.value = true;

//   hasNext.value =
//       snapshot.docs.length == rowsPerPage.value;

//   loading(false);
// }

 Future<void> addCheckpoint() async {
  // Prevent multiple clicks
  if (loading.value) return;

  if (!formKey.currentState!.validate()) {
    return;
  }

  loading(true);

  try {
    final id = const Uuid().v4();

    final qrId = "CP-${DateTime.now().millisecondsSinceEpoch}";

    final qrData = jsonEncode({
      "checkpointId": qrId,
      "checkpointName": checkpointNameController.text.trim(),
      "stationId": selectedStationId.value,
      "stationName": selectedStationName.value,
      "latitude": double.parse(latitudeController.text.trim()),
      "longitude": double.parse(longitudeController.text.trim()),
    });

    final model = QrCheckpointModel(
      id: id,
      qrId: qrId,
      checkpointName: checkpointNameController.text.trim(),
      areaDescription: areaDescriptionController.text.trim(),
      stationId: selectedStationId.value,
      stationName: selectedStationName.value,
      latitude: latitudeController.text.trim().isEmpty
          ? 0
          : double.parse(latitudeController.text.trim()),
      longitude: longitudeController.text.trim().isEmpty
          ? 0
          : double.parse(longitudeController.text.trim()),
      priority: selectedPriority.value,
      qrData: qrData,
      qrImage: "",
      status: "active",
      createdBy: SessionManager.uid,
      updatedBy: SessionManager.uid,
      deleted: false,
    );

    await service.addCheckpoint(model);

    clearForm();

    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    Get.snackbar(
      "Success",
      "Checkpoint created successfully.",
    );
  } catch (e) {
    Get.snackbar(
      "Error",
      e.toString(),
    );
  } finally {
    loading(false);
  }
}


  Future<void> updateCheckpoint() async {
  if (!formKey.currentState!.validate()) return;

  if (editingId.isEmpty) {
    Get.snackbar(
      "Error",
      "No checkpoint selected for update.",
    );
    return;
  }

  loading(true);

  try {
    final qrData = jsonEncode({
      "checkpointId": editingId,
      "checkpointName": checkpointNameController.text.trim(),
      "stationId": selectedStationId.value,
      "stationName": selectedStationName.value,
      "latitude": double.parse(latitudeController.text.trim()),
      "longitude": double.parse(longitudeController.text.trim()),
    });

    final model = QrCheckpointModel(
      id: editingId,
      qrId: currentQrId,
      checkpointName: checkpointNameController.text.trim(),
      areaDescription: areaDescriptionController.text.trim(),
      stationId: selectedStationId.value,
      stationName: selectedStationName.value,
      latitude: latitudeController.text.trim().isEmpty
          ? 0
          : double.parse(latitudeController.text.trim()),
      longitude: longitudeController.text.trim().isEmpty
          ? 0
          : double.parse(longitudeController.text.trim()),
      priority: selectedPriority.value,
      qrData: qrData,
      qrImage: currentQrImage,
      status: "active",

      createdBy: SessionManager.uid,
      createdAt: currentCreatedAt,

      updatedBy: SessionManager.uid,

      deleted: false,
    );

    await service.updateCheckpoint(model);

    clearForm();

    Get.back();

    Get.snackbar(
      "Success",
      "Checkpoint updated successfully.",
    );
  } catch (e) {
    Get.snackbar(
      "Error",
      e.toString(),
    );
  } finally {
    loading(false);
  }
}

Future<void> editCheckpoint(QrCheckpointModel model) async {
  // Ensure station list is loaded
  if (stationList.isEmpty) {
    await loadStationList();
  }

  // Clear previous validation/errors
  clearForm();

  // Save editing state
  editingId = model.id;
  currentQrId = model.qrId;
  currentQrImage = model.qrImage;
  currentCreatedAt = model.createdAt;

  // Fill form
  checkpointNameController.text = model.checkpointName;
  areaDescriptionController.text = model.areaDescription;

  latitudeController.text =
      model.latitude == 0 ? "" : model.latitude.toString();

  longitudeController.text =
      model.longitude == 0 ? "" : model.longitude.toString();

  selectedStationId.value = model.stationId;
  selectedStationName.value = model.stationName;
  selectedPriority.value = model.priority;

  // Open dialog
  Get.dialog(
    const QrDialog(isEdit: true),
    barrierDismissible: false,
  );
}

Future<void> loadStationList() async {
  try {
    debugPrint("Loading Stations...");

    final stations = await service.getStationList();

    debugPrint("Stations Found : ${stations.length}");

    stationList.assignAll(stations);
  } catch (e, stack) {
    debugPrint("Station Error : $e");
    debugPrint(stack.toString());

    Get.snackbar(
      "Error",
      e.toString(),
    );
  }
}

void viewQr(QrCheckpointModel model) {
  Get.dialog(
    AlertDialog(
      title: Text(model.checkpointName),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImageView(
              data: model.qrData,
              size: 220,
            ),

            const SizedBox(height: 16),

            Text(
              model.qrId,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(model.stationName),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("Close"),
        ),
      ],
    ),
  );
}




  void clearForm() {
    checkpointNameController.clear();
    areaDescriptionController.clear();
    latitudeController.clear();
    longitudeController.clear();

    selectedPriority.value = "Low";

    selectedStationId.value = "";
    selectedStationName.value = "";
  }



  
}

