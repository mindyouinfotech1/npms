import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:uuid/uuid.dart';

import '../../../admin/pages/qrManagement/model/qr_checkpoint_model.dart';
import '../../auth/session_manager.dart';

import '../model/patrol_model.dart';
import '../service/patrol_service.dart';

class PatrolController extends GetxController {
  final PatrolService service = PatrolService();

  //==========================================================
  // FORM
  //==========================================================

  final remarksController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  //==========================================================
  // LOADING
  //==========================================================

  final loading = false.obs;

  //==========================================================
  // STEP
  //==========================================================

  /// 1 = QR
  /// 2 = GPS
  /// 3 = Camera
  /// 4 = Submit
  final currentStep = 1.obs;

  //==========================================================
  // QR
  //==========================================================

  final scannerController = MobileScannerController();

  final qrScanned = false.obs;

  final scannedQr = "".obs;

  QrCheckpointModel? checkpoint;

  //==========================================================
  // GPS
  //==========================================================

  final latitude = 0.0.obs;

  final longitude = 0.0.obs;

  final accuracy = 0.0.obs;

  final distance = 0.0.obs;

  final gpsReady = false.obs;

  //==========================================================
  // CAMERA
  //==========================================================

  final imagePath = "".obs;

  final imageUrl = "".obs;

  final imageCaptured = false.obs;

  //==========================================================
  // HISTORY
  //==========================================================

  final history = <PatrolHistoryModel>[].obs;

  //==========================================================
  // QR SCAN
  //==========================================================

  Future<void> onQrDetected(
    BarcodeCapture capture,
  ) async {
    if (qrScanned.value) return;

    final barcode = capture.barcodes.first;

    if (barcode.rawValue == null) {
      return;
    }

    qrScanned(true);

    scannedQr.value = barcode.rawValue!;

    try {
      final Map<String, dynamic> json =
          jsonDecode(barcode.rawValue!);

      checkpoint = await service.getCheckpoint(
        json["checkpointId"],
      );

      if (checkpoint == null) {
        Get.snackbar(
          "Invalid QR",
          "Checkpoint not found.",
        );

        qrScanned(false);

        return;
      }

      currentStep.value = 2;

      await getCurrentLocation();
    } catch (e) {
      qrScanned(false);

      Get.snackbar(
        "QR Error",
        "Invalid QR Code",
      );
    }
  }

  //==========================================================
  // LOCATION
  //==========================================================

  Future<void> getCurrentLocation() async {
    loading(true);

    try {
      bool enabled =
          await Geolocator.isLocationServiceEnabled();

      if (!enabled) {
        Get.snackbar(
          "Location",
          "Please enable GPS",
        );
        return;
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission =
            await Geolocator.requestPermission();
      }

      if (permission ==
              LocationPermission.denied ||
          permission ==
              LocationPermission.deniedForever) {
        Get.snackbar(
          "Permission",
          "Location permission denied.",
        );
        return;
      }

      Position position =
          await Geolocator.getCurrentPosition(
        desiredAccuracy:
            LocationAccuracy.bestForNavigation,
      );

      latitude.value = position.latitude;

      longitude.value = position.longitude;

      accuracy.value = position.accuracy;

      distance.value =
          Geolocator.distanceBetween(
        checkpoint!.latitude,
        checkpoint!.longitude,
        position.latitude,
        position.longitude,
      );

      gpsReady(true);

      // if (distance.value > 30) {
      //   Get.snackbar(
      //     "Too Far",
      //     "Officer must be within 30 meters of checkpoint.\nCurrent Distance : ${distance.value.toStringAsFixed(2)} m",
      //     duration: const Duration(seconds: 4),
      //   );

      //   return;
      // }

      currentStep.value = 3;
    } catch (e) {
      Get.snackbar(
        "GPS Error",
        e.toString(),
      );
    } finally {
      loading(false);
    }
  }

  //==========================================================
  // RESET
  //==========================================================

  void resetPatrol() {
    currentStep.value = 1;

    qrScanned(false);

    scannedQr.value = "";

    checkpoint = null;

    latitude.value = 0;

    longitude.value = 0;

    accuracy.value = 0;

    distance.value = 0;

    gpsReady(false);

    imageCaptured(false);

    imagePath.value = "";

    imageUrl.value = "";

    remarksController.clear();
  }

  //==========================================================
  // OFFICER INFO
  //==========================================================

  String get officerName =>
      OfficerSession.name;

  String get badgeId =>
      OfficerSession.badgeId;

  String get stationName =>
      OfficerSession.stationName;

  String get stationId =>
      OfficerSession.stationId;

  String get rank =>
      OfficerSession.rank;

  //==========================================================
  // DISPOSE
  //==========================================================

  @override
  void onClose() {
    remarksController.dispose();

    scannerController.dispose();

    super.onClose();
  }


//==========================================================
// CAMERA
//==========================================================

Future<void> captureImage() async {
  try {
    final XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 80,
    );

    if (file == null) return;

    imagePath.value = file.path;

    imageCaptured(true);

    currentStep.value = 4;
  } catch (e) {
    Get.snackbar(
      "Camera Error",
      e.toString(),
    );
  }
}

//==========================================================
// RETAKE
//==========================================================

Future<void> retakeImage() async {
  imageCaptured(false);

  imagePath.value = "";

  imageUrl.value = "";

  currentStep.value = 3;

  await captureImage();
}

//==========================================================
// UPLOAD IMAGE
//==========================================================

Future<String> uploadImage() async {
  if (imagePath.value.isEmpty) {
    throw Exception("No image selected.");
  }

  final file = File(imagePath.value);

  final fileName =
      "${OfficerSession.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg";

  final ref = FirebaseStorage.instance
      .ref()
      .child("patrol_images")
      .child(fileName);

  final task = await ref.putFile(file);

  return await task.ref.getDownloadURL();
}

//==========================================================
// SUBMIT PATROL
//==========================================================

Future<void> submitPatrol() async {
  if (checkpoint == null) {
    Get.snackbar(
      "Error",
      "Checkpoint not found.",
    );
    return;
  }

  loading(true);

  try {
    //------------------------------------------------------
    // Upload Photo
    //------------------------------------------------------

    imageUrl.value = await uploadImage();

    //------------------------------------------------------
    // Model
    //------------------------------------------------------

    final model = PatrolHistoryModel(
      id: const Uuid().v4(),

      officerId: OfficerSession.uid,
      officerName: OfficerSession.name,
      badgeId: OfficerSession.badgeId,
      rank: OfficerSession.rank,

      stationId: OfficerSession.stationId,
      stationName: OfficerSession.stationName,

      checkpointId: checkpoint!.qrId,
      checkpointName: checkpoint!.checkpointName,

      checkpointLatitude: checkpoint!.latitude,
      checkpointLongitude: checkpoint!.longitude,

      officerLatitude: latitude.value,
      officerLongitude: longitude.value,

      gpsAccuracy: accuracy.value,

      distance: distance.value,

      photoUrl: imageUrl.value,

      remarks: remarksController.text.trim(),

      patrolTime: Timestamp.now(),

      status: "completed",

      deleted: false,

      createdBy: OfficerSession.uid,
      updatedBy: OfficerSession.uid,
    );

    //------------------------------------------------------
    // Save Firestore
    //------------------------------------------------------

    await service.savePatrol(model);

    //------------------------------------------------------
    // Refresh History
    //------------------------------------------------------

    await loadHistory();

    //------------------------------------------------------
    // Success
    //------------------------------------------------------

    Get.snackbar(
      "Success",
      "Patrol submitted successfully.",
    );

    resetPatrol();
  } catch (e) {
    Get.snackbar(
      "Error",
      e.toString(),
    );
  } finally {
    loading(false);
  }
}

//==========================================================
// LOAD HISTORY
//==========================================================

Future<void> loadHistory() async {
  loading(true);

  try {
    history.assignAll(
      await service.getOfficerHistory(
        OfficerSession.uid,
      ),
    );
  } finally {
    loading(false);
  }
}

//==========================================================
// TODAY COUNT
//==========================================================

int get todayPatrols {
  final now = DateTime.now();

  return history.where((e) {
    if (e.createdAt == null) return false;

    final date = e.createdAt!.toDate();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }).length;
}

//==========================================================
// TOTAL PATROLS
//==========================================================

int get totalPatrols => history.length;

//==========================================================
// INIT
//==========================================================

@override
void onInit() {
  super.onInit();

  loadHistory();
}



}
