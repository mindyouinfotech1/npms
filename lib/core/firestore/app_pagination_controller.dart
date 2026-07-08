import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'app_firestore_repository.dart';

abstract class AppPaginationController<T> extends GetxController {
  /// Repository
  AppFirestoreRepository<T> get repository;

  //==========================================================
  // STATE
  //==========================================================

  final loading = false.obs;

  final items = <T>[].obs;

  final page = 1.obs;

  final rowsPerPage = 10.obs;

  final totalRecords = 0.obs;

  final hasNext = false.obs;

  final hasPrevious = false.obs;

  DocumentSnapshot? _lastDocument;

  final List<DocumentSnapshot?> _pageHistory = [];

  //==========================================================
  // INIT
  //==========================================================

  @override
  void onInit() {
    super.onInit();
    loadFirstPage();
  }

  //==========================================================
  // LOAD FIRST PAGE
  //==========================================================

  Future<void> loadFirstPage() async {
    loading(true);

    page.value = 1;

    _pageHistory.clear();

    final snapshot = await repository.getPage(
      limit: rowsPerPage.value,
    );

    items.assignAll(
      snapshot.docs
          .map(
            (e) => repository.fromMap(
              e.data(),
              e.id,
            ),
          )
          .toList(),
    );

    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
    } else {
      _lastDocument = null;
    }

    totalRecords.value = await repository.count();

    hasPrevious.value = false;

    hasNext.value =
        snapshot.docs.length == rowsPerPage.value;

    loading(false);
  }

  //==========================================================
  // NEXT PAGE
  //==========================================================

  Future<void> nextPage() async {
    if (!hasNext.value || _lastDocument == null) {
      return;
    }

    loading(true);

    _pageHistory.add(_lastDocument);

    final snapshot = await repository.getPage(
      limit: rowsPerPage.value,
      startAfter: _lastDocument,
    );

    items.assignAll(
      snapshot.docs
          .map(
            (e) => repository.fromMap(
              e.data(),
              e.id,
            ),
          )
          .toList(),
    );

    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
    }

    page.value++;

    hasPrevious.value = page.value > 1;

    hasNext.value =
        snapshot.docs.length == rowsPerPage.value;

    loading(false);
  }

  //==========================================================
  // PREVIOUS PAGE
  //==========================================================

  Future<void> previousPage() async {
    if (page.value <= 1) return;

    page.value--;

    loading(true);

    if (page.value == 1) {
      await loadFirstPage();
      return;
    }

    final cursor = _pageHistory[page.value - 2];

    final snapshot = await repository.getPage(
      limit: rowsPerPage.value,
      startAfter: cursor,
    );

    items.assignAll(
      snapshot.docs
          .map(
            (e) => repository.fromMap(
              e.data(),
              e.id,
            ),
          )
          .toList(),
    );

    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
    }

    hasPrevious.value = page.value > 1;

    hasNext.value =
        snapshot.docs.length == rowsPerPage.value;

    loading(false);
  }

  //==========================================================
  // CHANGE PAGE SIZE
  //==========================================================

  Future<void> changeRowsPerPage(int value) async {
    rowsPerPage.value = value;

    await loadFirstPage();
  }

  //==========================================================
  // REFRESH
  //==========================================================

  Future<void> refreshData() async {
    await loadFirstPage();
  }
}