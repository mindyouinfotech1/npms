import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/services/firebase_service.dart' show FirebaseService;

import '../../station/model/police_station_model.dart';
import '../model/qr_checkpoint_model.dart';

class QrManagementService {
  final CollectionReference<Map<String, dynamic>> _collection =
      FirebaseService.firestore.collection("qr_checkpoints");

  // /// Add Checkpoint
  Future<void> addCheckpoint(QrCheckpointModel model) async {
    await _collection.doc(model.id).set(model.toMap());
  }

  /// Update Checkpoint
  Future<void> updateCheckpoint(QrCheckpointModel model) async {
    await _collection.doc(model.id).update(model.toMap());
  }


  /// Delete Checkpoint
  Future<void> deleteCheckpoint({
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

  /// Get All Checkpoints
 Future<QuerySnapshot<Map<String, dynamic>>> getPage({
  required int limit,
  DocumentSnapshot? startAfter,
}) async {
  Query<Map<String, dynamic>> query = _collection
      .where("deleted", isEqualTo: false)
      .orderBy("createdAt", descending: true)
      .limit(limit);

  if (startAfter != null) {
    query = query.startAfterDocument(startAfter);
  }

  return query.get();
}

  /// Get Single Checkpoint
  Stream<List<QrCheckpointModel>> getCheckpoints() {
  return _collection
      .where("deleted", isEqualTo: false)
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (e) => QrCheckpointModel.fromMap(
                e.data(),
                e.id,
              ),
            )
            .toList(),
      );
}

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
}