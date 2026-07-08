import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/firebase_service.dart';

abstract class AppFirestoreRepository<T> {
  /// Collection Name
  String get collection;

  /// Convert Firestore -> Model
  T fromMap(
    Map<String, dynamic> map,
    String id,
  );

  CollectionReference<Map<String, dynamic>> get ref =>
      FirebaseService.firestore.collection(collection);

  // ==========================================================
  // CREATE
  // ==========================================================

  Future<void> create({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    await ref.doc(id).set(data);
  }

  // ==========================================================
  // UPDATE
  // ==========================================================

  Future<void> update({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    data["updatedAt"] = FieldValue.serverTimestamp();

    await ref.doc(id).update(data);
  }

  // ==========================================================
  // SOFT DELETE
  // ==========================================================

  Future<void> softDelete({
    required String id,
    required String deletedBy,
  }) async {
    await ref.doc(id).update({
      "deleted": true,
      "status": "deleted",
      "deletedBy": deletedBy,
      "deletedAt": FieldValue.serverTimestamp(),
      "updatedBy": deletedBy,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  // ==========================================================
  // GET SINGLE
  // ==========================================================

  Future<T?> getById(String id) async {
    final doc = await ref.doc(id).get();

    if (!doc.exists) return null;

    return fromMap(
      doc.data()!,
      doc.id,
    );
  }

  // ==========================================================
  // COUNT
  // ==========================================================

  Future<int> count() async {
    final result = await ref
        .where("deleted", isEqualTo: false)
        .count()
        .get();

    return result.count ?? 0;
  }

  // ==========================================================
  // PAGINATION
  // ==========================================================

  Future<QuerySnapshot<Map<String, dynamic>>> getPage({
    int limit = 10,
    DocumentSnapshot? startAfter,
    String orderBy = "createdAt",
    bool descending = true,
  }) async {
    Query<Map<String, dynamic>> query = ref
        .where("deleted", isEqualTo: false)
        .orderBy(
          orderBy,
          descending: descending,
        )
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    return query.get();
  }

  // ==========================================================
  // STREAM
  // (Only use where realtime is actually required)
  // ==========================================================

  Stream<List<T>> stream({
    String orderBy = "createdAt",
    bool descending = true,
  }) {
    return ref
        .where("deleted", isEqualTo: false)
        .orderBy(
          orderBy,
          descending: descending,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (e) => fromMap(
                  e.data(),
                  e.id,
                ),
              )
              .toList(),
        );
  }

  // ==========================================================
  // SEARCH
  // ==========================================================

  Future<List<T>> search({
    required String field,
    required String keyword,
    int limit = 20,
  }) async {
    final result = await ref
        .where("deleted", isEqualTo: false)
        .orderBy(field)
        .startAt([keyword])
        .endAt(["$keyword\uf8ff"])
        .limit(limit)
        .get();

    return result.docs
        .map(
          (e) => fromMap(
            e.data(),
            e.id,
          ),
        )
        .toList();
  }

  // ==========================================================
  // EXISTS
  // ==========================================================

  Future<bool> exists(String id) async {
    final doc = await ref.doc(id).get();

    return doc.exists;
  }
}