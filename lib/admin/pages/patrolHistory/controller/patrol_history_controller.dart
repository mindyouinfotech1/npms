import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/services/session_manager.dart';
import '../../../../mobile/home/model/patrol_model.dart';
import '../../../../mobile/home/service/patrol_service.dart';




class PatrolHistoryController extends GetxController {
  final PatrolService service = PatrolService();

  //==========================================================
  // State
  //==========================================================

  final loading = false.obs;

  final search = "".obs;

  final page = 1.obs;

  final rowsPerPage = 10.obs;

  final totalRecords = 0.obs;

  final hasNext = false.obs;

  final hasPrevious = false.obs;

  //==========================================================
  // Data
  //==========================================================

  final RxList<PatrolHistoryModel> patrolList =
      <PatrolHistoryModel>[].obs;

  DocumentSnapshot? firstDocument;

  DocumentSnapshot? lastDocument;


  //==========================================================
  // Filtered List
  //==========================================================

  List<PatrolHistoryModel> get filteredList {
    if (search.value.trim().isEmpty) {
      return patrolList;
    }

    final keyword = search.value.toLowerCase();

    return patrolList.where((e) {
      return e.officerName
              .toLowerCase()
              .contains(keyword) ||
          e.badgeId
              .toLowerCase()
              .contains(keyword) ||
          e.stationName
              .toLowerCase()
              .contains(keyword) ||
          e.checkpointName
              .toLowerCase()
              .contains(keyword);
          // e.qrId
          //     .toLowerCase()
          //     .contains(keyword);
    }).toList();
  }


  List<PatrolHistoryModel> get paginatedList {
  final list = filteredList;

  final start = (page.value - 1) * rowsPerPage.value;

  if (start >= list.length) {
    return [];
  }

  final end = (start + rowsPerPage.value).clamp(0, list.length);

  return list.sublist(start, end);
}

  //==========================================================
  // Init
  //==========================================================

  @override
  void onInit() {
    super.onInit();

    // debounce(
    //   search,
    //   (_) => update(),
    //   time: const Duration(milliseconds: 300),
    // );

    loadPatrols();
  }

  //==========================================================
  // Load Patrols
  //==========================================================

  Future<void> loadPatrols() async {
    loading(true);

    try {
      debugPrint("========== LOAD PATROLS ==========");

      final snapshot = await service.getPage(
        limit: rowsPerPage.value,
      );

      patrolList.assignAll(
        snapshot.docs
            .map(
              (e) => PatrolHistoryModel.fromMap(
                e.data(),
                e.id,
              ),
            )
            .toList(),
      );

      totalRecords.value = await service.count();

      debugPrint(
          "Patrol Count : ${patrolList.length}");

      debugPrint(
          "Total Records : ${totalRecords.value}");

      if (snapshot.docs.isNotEmpty) {
        firstDocument = snapshot.docs.first;
        lastDocument = snapshot.docs.last;

        debugPrint(
            "First Doc : ${firstDocument!.id}");

        debugPrint(
            "Last Doc : ${lastDocument!.id}");
      } else {
        firstDocument = null;
        lastDocument = null;
      }

      page.value = 1;

      hasPrevious.value = false;

      hasNext.value =
          snapshot.docs.length ==
              rowsPerPage.value;

      debugPrint(
          "Has Next : ${hasNext.value}");

      debugPrint("========== END LOAD ==========");
    } catch (e, stack) {
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
    if (!hasNext.value || lastDocument == null) {
      return;
    }

    loading(true);

    try {
      final snapshot = await service.getPage(
        limit: rowsPerPage.value,
        startAfter: lastDocument,
      );

      patrolList.assignAll(
        snapshot.docs
            .map(
              (e) => PatrolHistoryModel.fromMap(
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
  // PREVIOUS PAGE
  //==========================================================

  Future<void> previousPage() async {
    if (page.value <= 1) {
      return;
    }

    /// Firestore doesn't support reverse cursor directly.
    /// Reload first page for now.
    await loadPatrols();
  }

  //==========================================================
  // CHANGE ROWS PER PAGE
  //==========================================================

  Future<void> changeRowsPerPage(
    int value,
  ) async {
    rowsPerPage.value = value;

    await loadPatrols();
  }

  //==========================================================
  // REFRESH
  //==========================================================

  Future<void> refresh() async {
    search.value = "";

    await loadPatrols();
  }

    //==========================================================
  // DELETE PATROL
  //==========================================================

  Future<void> deletePatrol(
    PatrolHistoryModel patrol,
  ) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Delete Patrol"),
        content: Text(
          "Delete patrol of ${patrol.officerName}?",
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    loading(true);

    try {
      await service.deletePatrol(
        id: patrol.id,
        deletedBy: SessionManager.uid,
      );

      await loadPatrols();

      Get.snackbar(
        "Success",
        "Patrol deleted successfully.",
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
  // CHANGE STATUS
  //==========================================================

  Future<void> changeStatus({
    required PatrolHistoryModel patrol,
    required String status,
  }) async {
    loading(true);

    try {
      await service.changeStatus(
        patrolId: patrol.id,
        status: status,
        updatedBy: SessionManager.uid,
      );

      await loadPatrols();

      Get.snackbar(
        "Success",
        "Patrol status updated.",
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
  // VIEW PATROL
  //==========================================================

  Future<PatrolHistoryModel?> viewPatrol(
    String patrolId,
  ) async {
    loading(true);

    try {
      return await service.getPatrol(patrolId);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
      return null;
    } finally {
      loading(false);
    }
  }

  //==========================================================
  // TODAY PATROLS
  //==========================================================

  Future<int> todayPatrolCount() async {
    try {
      return await service.todayCount();
    } catch (_) {
      return 0;
    }
  }

  //==========================================================
  // OFFICER PATROLS
  //==========================================================

  Future<List<PatrolHistoryModel>> officerPatrols(
    String officerId,
  ) async {
    try {
      return await service.officerPatrols(
        officerId,
      );
    } catch (_) {
      return [];
    }
  }

  //==========================================================
  // STATION PATROLS
  //==========================================================

  Future<List<PatrolHistoryModel>> stationPatrols(
    String stationId,
  ) async {
    try {
      return await service.stationPatrols(
        stationId,
      );
    } catch (_) {
      return [];
    }
  }

  //==========================================================
  // SEARCH
  //==========================================================

  Future<void> searchPatrols(
    String keyword,
  ) async {
    search.value = keyword;
  }

  //==========================================================
  // CLEAR SEARCH
  //==========================================================

  void clearSearch() {
    search.value = "";
  }

  //==========================================================
  // RELOAD
  //==========================================================

  Future<void> reload() async {
    await loadPatrols();
  }
}