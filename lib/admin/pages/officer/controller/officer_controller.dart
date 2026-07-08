import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/services/session_manager.dart';
import '../../station/model/police_station_model.dart';
import '../model/officer_model.dart';

import '../service/officer_service.dart';
import '../widgets/OfficerDialog.dart';
class OfficerController extends GetxController {
  final OfficerService service = Get.find<OfficerService>();

  //==========================================================
  // FORM CONTROLLERS
  //==========================================================

  final fullNameController = TextEditingController();

  final mobileController = TextEditingController();

  final emailController = TextEditingController();

  final badgeIdController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  //==========================================================
  // OBSERVABLES
  //==========================================================

  final loading = false.obs;

  final officerList = <OfficerModel>[].obs;

  final stationList = <PoliceStationModel>[].obs;

  final search = "".obs;

  //==========================================================
  // DROPDOWNS
  //==========================================================

  final selectedRank = "Constable".obs;

  final selectedShift = "Night".obs;

  final selectedStationId = "".obs;

  final selectedStationName = "".obs;

  //==========================================================
  // EDIT MODE
  //==========================================================

  String editingId = "";

  Timestamp? currentCreatedAt;

  //==========================================================
  // PAGINATION
  //==========================================================

  DocumentSnapshot? lastDocument;

  DocumentSnapshot? firstDocument;

  final hasNext = true.obs;

  final hasPrevious = false.obs;

  final page = 1.obs;

  final rowsPerPage = 10.obs;

  final totalRecords = 0.obs;

  final List<DocumentSnapshot?> pageHistory = [];

  //==========================================================
  // SEARCH
  //==========================================================

  List<OfficerModel> get filteredList {
  return service.search(
    officers: officerList,
    keyword: search.value,
  );
}

  //==========================================================
  // INIT
  //==========================================================

  @override
  void onInit() {
    super.onInit();

    loadOfficers();

    loadStationList();
  }

  //==========================================================
  // LOAD OFFICERS
  //==========================================================

 Future<void> loadOfficers() async {
  loading(true);

  try {
    debugPrint("========== LOAD OFFICERS ==========");

    debugPrint("Rows Per Page : ${rowsPerPage.value}");

    final snapshot = await service.getPage(
      limit: rowsPerPage.value,
    );

    debugPrint("Documents Found : ${snapshot.docs.length}");

    for (final doc in snapshot.docs) {
      debugPrint(
        "ID : ${doc.id} | Name : ${doc.data()['fullName']} | Badge : ${doc.data()['badgeId']}",
      );
    }

    officerList.assignAll(
      snapshot.docs
          .map(
            (e) => OfficerModel.fromMap(
              e.data(),
              e.id,
            ),
          )
          .toList(),
    );
    totalRecords.value = await service.count();

debugPrint("Total Records : ${totalRecords.value}");

    debugPrint("Officer List Count : ${officerList.length}");

    if (snapshot.docs.isNotEmpty) {
      firstDocument = snapshot.docs.first;
      lastDocument = snapshot.docs.last;

      debugPrint("First Doc : ${firstDocument!.id}");
      debugPrint("Last Doc : ${lastDocument!.id}");
    } else {
      firstDocument = null;
      lastDocument = null;

      debugPrint("No officers found.");
    }

    pageHistory.clear();
     page.value = 1;

    hasPrevious.value = false;

    hasNext.value =
        snapshot.docs.length == rowsPerPage.value;

    debugPrint("Has Next : ${hasNext.value}");
    debugPrint("Current Page : ${page.value}");

    debugPrint("========== END LOAD ==========");
  } catch (e, stack) {
    debugPrint("LOAD OFFICERS ERROR");
    debugPrint(e.toString());
    debugPrint(stack.toString());

    Get.snackbar(
      "Error",
      e.toString(),
    );
  } finally {
    loading(false);
  }
}

  //==========================================================
  // NEXT PAGE
  //==========================================================

  Future<void> nextPage() async {
    if (!hasNext.value) return;

    loading(true);

    try {
      pageHistory.add(lastDocument);
      final snapshot = await service.getPage(
        limit: rowsPerPage.value,
        startAfter: lastDocument,
      );

      officerList.assignAll(
        snapshot.docs
            .map(
              (e) => OfficerModel.fromMap(
                e.data(),
                e.id,
              ),
            )
            .toList(),
      );

      if (snapshot.docs.isNotEmpty) {
        firstDocument = snapshot.docs.first;
        lastDocument = snapshot.docs.last;
      }

      page.value++;

      hasPrevious.value = true;

      hasNext.value =
          snapshot.docs.length == rowsPerPage.value;
    } finally {
      loading(false);
    }
  }

  //==========================================================
  // PREVIOUS PAGE
  //==========================================================

 Future<void> previousPage() async {
  if (page.value <= 1) return;

  loading(true);

  try {
    page.value--;

    if (page.value == 1) {
      await loadOfficers();
      return;
    }

    final cursor = pageHistory[page.value - 2];

    final snapshot = await service.getPage(
      limit: rowsPerPage.value,
      startAfter: cursor,
    );

    officerList.assignAll(
      snapshot.docs
          .map(
            (e) => OfficerModel.fromMap(
              e.data(),
              e.id,
            ),
          )
          .toList(),
    );

    firstDocument = snapshot.docs.first;
    lastDocument = snapshot.docs.last;

    hasPrevious.value = page.value > 1;

    hasNext.value =
        snapshot.docs.length == rowsPerPage.value;
  } finally {
    loading(false);
  }
}

  //==========================================================
  // CHANGE PAGE SIZE
  //==========================================================

  Future<void> changeRowsPerPage(int value) async {
    rowsPerPage.value = value;

    await loadOfficers();
  }

  //==========================================================
  // LOAD STATIONS
  //==========================================================

  Future<void> loadStationList() async {
    try {
      final stations =
          await service.getStationList();

      stationList.assignAll(stations);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }

    //==========================================================
  // CREATE OFFICER
  //==========================================================

  Future<void> createOfficer() async {
    if (!formKey.currentState!.validate()) return;

    loading(true);

    try {
      final exists = await service.badgeExists(
        badgeIdController.text.trim(),
      );

      if (exists) {
        Get.snackbar(
          "Duplicate",
          "Badge ID already exists.",
        );
        loading(false);
        return;
      }

      final officer = OfficerModel(
        id: const Uuid().v4(),

        badgeId: badgeIdController.text.trim(),
        password: passwordController.text.trim(),

        fullName: fullNameController.text.trim(),
        mobile: mobileController.text.trim(),
        email: emailController.text.trim(),

        rank: selectedRank.value,

        stationId: selectedStationId.value,
        stationName: selectedStationName.value,

        shift: selectedShift.value,

        profileImage: "",

        status: "active",
        deleted: false,

        createdBy: SessionManager.uid,
        updatedBy: SessionManager.uid,
      );

      await service.addOfficer(officer);

      clearForm();

      await loadOfficers();

      Get.back();

      Get.snackbar(
        "Success",
        "Officer added successfully.",
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

  //==========================================================
  // UPDATE OFFICER
  //==========================================================

  Future<void> updateOfficer() async {
    if (!formKey.currentState!.validate()) return;

    loading(true);

    try {
      final officer = OfficerModel(
        id: editingId,

        badgeId: badgeIdController.text.trim(),
        password: passwordController.text.trim(),

        fullName: fullNameController.text.trim(),
        mobile: mobileController.text.trim(),
        email: emailController.text.trim(),

        rank: selectedRank.value,

        stationId: selectedStationId.value,
        stationName: selectedStationName.value,

        shift: selectedShift.value,

        profileImage: "",

        status: "active",
        deleted: false,

        createdBy: SessionManager.uid,
        updatedBy: SessionManager.uid,

        createdAt: currentCreatedAt,
      );

      await service.updateOfficer(officer);

      clearForm();

      await loadOfficers();

      Get.back();

      Get.snackbar(
        "Success",
        "Officer updated successfully.",
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

  //==========================================================
  // EDIT OFFICER
  //==========================================================

  void editOfficer(OfficerModel model) {
    editingId = model.id;

    currentCreatedAt = model.createdAt;

    badgeIdController.text = model.badgeId;

    passwordController.text = model.password;

    fullNameController.text = model.fullName;

    mobileController.text = model.mobile;

    emailController.text = model.email;

    selectedRank.value = model.rank;

    selectedShift.value = model.shift;

    selectedStationId.value = model.stationId;

    selectedStationName.value = model.stationName;

    Get.dialog(
      const OfficerDialog(
        isEdit: true,
      ),
      barrierDismissible: false,
    );
  }

  //==========================================================
  // DELETE
  //==========================================================

  Future<void> deleteOfficer(
    OfficerModel officer,
  ) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Delete Officer"),
        content: Text(
          "Delete ${officer.fullName} ?",
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

    if (confirm != true) return;

    loading(true);

    try {
      await service.deleteOfficer(
        id: officer.id,
        deletedBy: SessionManager.uid,
      );

      await loadOfficers();

      Get.snackbar(
        "Success",
        "Officer deleted successfully.",
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

  //==========================================================
  // CHANGE PASSWORD
  //==========================================================

  Future<void> changePassword(
    OfficerModel officer,
    String newPassword,
  ) async {
    await service.resetPassword(
      officerId: officer.id,
      password: newPassword,
      updatedBy: SessionManager.uid,
    );

    await loadOfficers();

    Get.snackbar(
      "Success",
      "Password updated.",
    );
  }

  //==========================================================
  // CHANGE STATUS
  //==========================================================

  Future<void> changeStatus(
    OfficerModel officer,
    String status,
  ) async {
    await service.changeStatus(
      officerId: officer.id,
      status: status,
      updatedBy: SessionManager.uid,
    );

    await loadOfficers();
  }

  //==========================================================
  // CLEAR FORM
  //==========================================================

  void clearForm() {
    editingId = "";

    currentCreatedAt = null;

    fullNameController.clear();
    mobileController.clear();
    emailController.clear();

    badgeIdController.clear();
    passwordController.clear();

    selectedRank.value = "Constable";

    selectedShift.value = "Night";

    selectedStationId.value = "";

    selectedStationName.value = "";
  }

  //==========================================================
  // DISPOSE
  //==========================================================

  @override
  void onClose() {
    fullNameController.dispose();
    mobileController.dispose();
    emailController.dispose();

    badgeIdController.dispose();
    passwordController.dispose();

    super.onClose();
  }


  Future<void> showChangePasswordDialog(
  OfficerModel officer,
) async {
  final passwordController = TextEditingController();

  await Get.dialog(
    AlertDialog(
      title: Text("Change Password"),
      content: SizedBox(
        width: 350,
        child: TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "New Password",
            prefixIcon: Icon(Icons.lock),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            final password =
                passwordController.text.trim();

            if (password.isEmpty) {
              Get.snackbar(
                "Error",
                "Password cannot be empty.",
              );
              return;
            }

            if (password.length < 6) {
              Get.snackbar(
                "Error",
                "Password must be at least 6 characters.",
              );
              return;
            }

            Get.back();

            await changePassword(
              officer,
              password,
            );
          },
          child: const Text("Update"),
        ),
      ],
    ),
  );
}
}