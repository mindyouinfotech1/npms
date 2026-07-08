import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_pagination_controller.dart';

abstract class AppCrudController<T> extends AppPaginationController<T> {
  /// Loading
  final saving = false.obs;
  final deleting = false.obs;

  /// Form
  final formKey = GlobalKey<FormState>();

  /// Editing
  final editingId = "".obs;

  bool get isEditing => editingId.value.isNotEmpty;

  //==========================================================
  // ABSTRACT METHODS
  //==========================================================

  Future<void> createRecord();

  Future<void> updateRecord();

  //==========================================================
  // SAVE
  //==========================================================

  Future<void> saveRecord() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    saving(true);

    try {
      if (isEditing) {
        await updateRecord();

        Get.snackbar(
          "Success",
          "Record updated successfully.",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        await createRecord();

        Get.snackbar(
          "Success",
          "Record created successfully.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      clearForm();

      await refreshData();
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      saving(false);
    }
  }

  //==========================================================
  // DELETE
  //==========================================================

  Future<void> deleteRecord({
    required String id,
    required String deletedBy,
  }) async {
    deleting(true);

    try {
      await repository.softDelete(
        id: id,
        deletedBy: deletedBy,
      );

      await refreshData();

      Get.snackbar(
        "Success",
        "Record deleted successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      deleting(false);
    }
  }

  //==========================================================
  // DELETE CONFIRMATION
  //==========================================================

  Future<bool> confirmDelete({
    required String title,
    required String message,
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Get.back(result: true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  //==========================================================
  // EDIT MODE
  //==========================================================

  @mustCallSuper
  void startEditing(String id) {
    editingId.value = id;
  }

  @mustCallSuper
  void cancelEditing() {
    clearForm();
  }

  @mustCallSuper
  void clearForm() {
    editingId.value = "";
  }

  //==========================================================
  // EXPORTS
  //==========================================================

  Future<void> exportExcel() async {}

  Future<void> exportPdf() async {}

  Future<void> exportCsv() async {}

  //==========================================================
  // RESTORE
  //==========================================================

  Future<void> restoreRecord(String id) async {}
}