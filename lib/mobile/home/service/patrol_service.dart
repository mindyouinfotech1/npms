import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/services/firebase_service.dart';
import '../../../admin/pages/qrManagement/model/qr_checkpoint_model.dart';
import '../model/patrol_model.dart';

class PatrolService {
  final CollectionReference<Map<String, dynamic>> _collection =
      FirebaseService.firestore.collection("patrol_history");

  final CollectionReference<Map<String, dynamic>> _checkpointCollection =
      FirebaseService.firestore.collection("qr_checkpoints");

  //==========================================================
  // SAVE PATROL
  //==========================================================

  Future<void> savePatrol(
    PatrolHistoryModel model,
  ) async {
    await _collection.doc(model.id).set(
          model.toMap(),
        );
  }

    Future<int> count() async {
    final result = await _collection
        .where("deleted", isEqualTo: false)
        .count()
        .get();

    return result.count ?? 0;
  }

    Future<void> changeStatus({
    required String patrolId,
    required String status,
    required String updatedBy,
  }) async {
    await _collection.doc(patrolId).update({
      "patrolStatus": status,
      "updatedBy": updatedBy,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }



  Future<List<PatrolHistoryModel>> stationPatrols(
    String stationId,
  ) async {
    final snapshot = await _collection
        .where("deleted", isEqualTo: false)
        .where("stationId", isEqualTo: stationId)
        .orderBy(
          "createdAt",
          descending: true,
        )
        .get();

    return snapshot.docs
        .map(
          (e) => PatrolHistoryModel.fromMap(
            e.data(),
            e.id,
          ),
        )
        .toList();
  }


    Future<int> todayCount() async {
    final now = DateTime.now();

    final start = Timestamp.fromDate(
      DateTime(now.year, now.month, now.day),
    );

    final end = Timestamp.fromDate(
      DateTime(now.year, now.month, now.day, 23, 59, 59),
    );

    final result = await _collection
        .where("deleted", isEqualTo: false)
        .where("createdAt", isGreaterThanOrEqualTo: start)
        .where("createdAt", isLessThanOrEqualTo: end)
        .count()
        .get();

    return result.count ?? 0;
  }

  //==========================================================
  // Patrols By Officer
  //==========================================================

  Future<List<PatrolHistoryModel>> officerPatrols(
    String officerId,
  ) async {
    final snapshot = await _collection
        .where("deleted", isEqualTo: false)
        .where("officerId", isEqualTo: officerId)
        .orderBy(
          "createdAt",
          descending: true,
        )
        .get();

    return snapshot.docs
        .map(
          (e) => PatrolHistoryModel.fromMap(
            e.data(),
            e.id,
          ),
        )
        .toList();
  }

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
  // GET CHECKPOINT
  //==========================================================

  Future<QrCheckpointModel?> getCheckpoint(
    String qrId,
  ) async {
    final snapshot = await _checkpointCollection
        .where("deleted", isEqualTo: false)
        .where("status", isEqualTo: "active")
        .where("qrId", isEqualTo: qrId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    final doc = snapshot.docs.first;

    return QrCheckpointModel.fromMap(
      doc.data(),
      doc.id,
    );
  }

  //==========================================================
  // OFFICER HISTORY
  //==========================================================

  Future<List<PatrolHistoryModel>> getOfficerHistory(
    String officerId,
  ) async {
    final snapshot = await _collection
        .where("deleted", isEqualTo: false)
        .where("officerId", isEqualTo: officerId)
        .orderBy(
          "createdAt",
          descending: true,
        )
        .get();

    return snapshot.docs
        .map(
          (e) => PatrolHistoryModel.fromMap(
            e.data(),
            e.id,
          ),
        )
        .toList();
  }

  //==========================================================
  // TODAY HISTORY
  //==========================================================

  Future<List<PatrolHistoryModel>> getTodayHistory(
    String officerId,
  ) async {
    final now = DateTime.now();

    final start = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final end = start.add(
      const Duration(days: 1),
    );

    final snapshot = await _collection
        .where("deleted", isEqualTo: false)
        .where("officerId", isEqualTo: officerId)
        .where(
          "createdAt",
          isGreaterThanOrEqualTo: Timestamp.fromDate(start),
        )
        .where(
          "createdAt",
          isLessThan: Timestamp.fromDate(end),
        )
        .orderBy(
          "createdAt",
          descending: true,
        )
        .get();

    return snapshot.docs
        .map(
          (e) => PatrolHistoryModel.fromMap(
            e.data(),
            e.id,
          ),
        )
        .toList();
  }

  //==========================================================
  // TOTAL PATROLS
  //==========================================================

  Future<int> getTotalPatrols(
    String officerId,
  ) async {
    final result = await _collection
        .where("deleted", isEqualTo: false)
        .where("officerId", isEqualTo: officerId)
        .count()
        .get();

    return result.count ?? 0;
  }

  //==========================================================
  // TODAY COUNT
  //==========================================================

  Future<int> getTodayPatrolCount(
    String officerId,
  ) async {
    final now = DateTime.now();

    final start = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final end = start.add(
      const Duration(days: 1),
    );

    final result = await _collection
        .where("deleted", isEqualTo: false)
        .where("officerId", isEqualTo: officerId)
        .where(
          "createdAt",
          isGreaterThanOrEqualTo: Timestamp.fromDate(start),
        )
        .where(
          "createdAt",
          isLessThan: Timestamp.fromDate(end),
        )
        .count()
        .get();

    return result.count ?? 0;
  }

  //==========================================================
  // GET SINGLE PATROL
  //==========================================================

  Future<PatrolHistoryModel?> getPatrol(
  String id,
) async {
  final doc = await _collection.doc(id).get();

  if (!doc.exists) {
    return null;
  }

  return PatrolHistoryModel.fromMap(
    doc.data()!,
    doc.id,
  );
}

  //==========================================================
  // DELETE (Soft Delete)
  //==========================================================

  Future<void> deletePatrol({
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
  // REALTIME HISTORY
  //==========================================================

  Stream<List<PatrolHistoryModel>> historyStream(
    String officerId,
  ) {
    return _collection
        .where("deleted", isEqualTo: false)
        .where("officerId", isEqualTo: officerId)
        .orderBy(
          "createdAt",
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (e) => PatrolHistoryModel.fromMap(
                  e.data(),
                  e.id,
                ),
              )
              .toList(),
        );
  }
}