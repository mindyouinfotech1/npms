import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/services/firebase_service.dart';
import '../../station/model/police_station_model.dart';
import '../model/officer_model.dart';

class OfficerService {
  final CollectionReference<Map<String, dynamic>> _collection =
      FirebaseService.firestore.collection("officers");

  //==========================================================
  // Add Officer
  //==========================================================

  Future<void> addOfficer(
    OfficerModel model,
  ) async {
    await _collection.doc(model.id).set(
          model.toMap(),
        );
  }

  //==========================================================
  // Update Officer
  //==========================================================

  Future<void> updateOfficer(
    OfficerModel model,
  ) async {
    await _collection.doc(model.id).update(
          model.toMap(),
        );
  }

  //==========================================================
  // Soft Delete
  //==========================================================

  Future<void> deleteOfficer({
    required String id,
    required String deletedBy,
  }) async {
    await _collection.doc(id).update({
      "deleted": true,
      "status": "deleted",
      "deletedBy": deletedBy,
      "deletedAt": FieldValue.serverTimestamp(),
      "updatedBy": deletedBy,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  //==========================================================
  // Get Officers (Realtime)
  //==========================================================

  Stream<List<OfficerModel>> getOfficers() {
    return _collection
        .where("deleted", isEqualTo: false)
        .orderBy(
          "createdAt",
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (e) => OfficerModel.fromMap(
                  e.data(),
                  e.id,
                ),
              )
              .toList(),
        );
  }

  //==========================================================
  // Server Side Pagination
  //==========================================================

  Future<QuerySnapshot<Map<String, dynamic>>> getPage({
    required int limit,
    DocumentSnapshot? startAfter,
  }) async {
    Query<Map<String, dynamic>> query = _collection
        .where("deleted", isEqualTo: false)
        .orderBy(
          "createdAt",
          descending: true,
        )
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    return query.get();
  }

  //==========================================================
  // Get Officer By ID
  //==========================================================

  Future<OfficerModel?> getOfficer(
    String id,
  ) async {
    final doc = await _collection.doc(id).get();

    if (!doc.exists) {
      return null;
    }

    return OfficerModel.fromMap(
      doc.data()!,
      doc.id,
    );
  }

  //==========================================================
  // Get Active Police Stations
  //==========================================================

  Future<List<PoliceStationModel>> getStationList() async {
  final result = await FirebaseService.firestore
      .collection("police_stations")
      .where("status", isEqualTo: "active")
      .orderBy("stationName")
      .get();

  return result.docs
      .map(
        (e) => PoliceStationModel.fromMap(
          e.data(),
          e.id,
        ),
      )
      .toList();
}

  //==========================================================
  // Check Badge ID Exists
  //==========================================================

  Future<bool> badgeExists(
    String badgeId,
  ) async {
    final snapshot = await _collection
        .where("deleted", isEqualTo: false)
        .where("badgeId", isEqualTo: badgeId)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  //==========================================================
  // Reset Password
  //==========================================================

  Future<void> resetPassword({
    required String officerId,
    required String password,
    required String updatedBy,
  }) async {
    await _collection.doc(officerId).update({
      "password": password,
      "updatedBy": updatedBy,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  //==========================================================
  // Change Status
  //==========================================================

  Future<void> changeStatus({
    required String officerId,
    required String status,
    required String updatedBy,
  }) async {
    await _collection.doc(officerId).update({
      "status": status,
      "updatedBy": updatedBy,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  //==========================================================
  // Total Officers
  //==========================================================

  Future<int> count() async {
    final result = await _collection
        .where("deleted", isEqualTo: false)
        .count()
        .get();

    return result.count ?? 0;
  }


List<OfficerModel> search({
  required List<OfficerModel> officers,
  required String keyword,
}) {
  if (keyword.trim().isEmpty) {
    return officers;
  }

  final search = keyword.toLowerCase().trim();

  return officers.where((e) {
    return e.fullName.toLowerCase().contains(search) ||
        e.badgeId.toLowerCase().contains(search) ||
        e.mobile.toLowerCase().contains(search) ||
        e.email.toLowerCase().contains(search) ||
        e.rank.toLowerCase().contains(search) ||
        e.stationName.toLowerCase().contains(search) ||
        e.shift.toLowerCase().contains(search);
  }).toList();
}
}