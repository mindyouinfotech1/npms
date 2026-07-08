import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/services/firebase_service.dart';
import '../model/police_station_model.dart';

class PoliceStationService {
  final CollectionReference<Map<String, dynamic>> _collection =
      FirebaseService.firestore.collection("police_stations");

  /// Add Station
  Future<void> addStation(PoliceStationModel model) async {
    await _collection.doc(model.id).set(model.toMap());
  }

  /// Update Station
  Future<void> updateStation(PoliceStationModel model) async {
    await _collection.doc(model.id).update(model.toMap());
  }

  /// Soft Delete
  Future<void> softDeleteStation(String id) async {
    await _collection.doc(id).update({
      "status": "deleted",
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  /// Change Status (Active / Inactive)
  Future<void> changeStatus({
    required String id,
    required String status,
  }) async {
    await _collection.doc(id).update({
      "status": status,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  /// Get All Active Stations
  Stream<List<PoliceStationModel>> getStations() {
    return _collection
        .where("status", whereIn: ["active", "inactive"])
        .orderBy("stationName")
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => PoliceStationModel.fromMap(
                  e.data(),
                  e.id,
                ),
              )
              .toList(),
        );
  }

  /// Get Single Station
  Future<PoliceStationModel?> getStation(String id) async {
    final doc = await _collection.doc(id).get();

    if (!doc.exists) {
      return null;
    }

    return PoliceStationModel.fromMap(
      doc.data()!,
      doc.id,
    );
  }

  /// Total Officers (Dynamic)
  Future<int> getOfficerCount(String stationId) async {
    final snapshot = await FirebaseService.firestore
        .collection("officers")
        .where("stationId", isEqualTo: stationId)
        .where("status", isEqualTo: "active")
        .count()
        .get();

    return snapshot.count ?? 0;
  }

  /// Officers On Patrol (Dynamic)
  Future<int> getOnPatrolCount(String stationId) async {
    final snapshot = await FirebaseService.firestore
        .collection("officers")
        .where("stationId", isEqualTo: stationId)
        .where("patrolStatus", isEqualTo: "active")
        .count()
        .get();

    return snapshot.count ?? 0;
  }

  /// Total Checkpoints (Dynamic)
  Future<int> getCheckpointCount(String stationId) async {
    final snapshot = await FirebaseService.firestore
        .collection("qr_checkpoints")
        .where("stationId", isEqualTo: stationId)
        .where("status", isEqualTo: "active")
        .count()
        .get();

    return snapshot.count ?? 0;
  }

  /// Today's Attendance (Dynamic)
  Future<int> getTodayAttendance(String stationId) async {
    final now = DateTime.now();

    final start = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final end = start.add(
      const Duration(days: 1),
    );

    final snapshot = await FirebaseService.firestore
        .collection("attendance")
        .where("stationId", isEqualTo: stationId)
        .where(
          "attendanceTime",
          isGreaterThanOrEqualTo: Timestamp.fromDate(start),
        )
        .where(
          "attendanceTime",
          isLessThan: Timestamp.fromDate(end),
        )
        .count()
        .get();

    return snapshot.count ?? 0;
  }

  /// Dashboard Statistics
  Future<Map<String, int>> getStationStatistics(
    String stationId,
  ) async {
    final results = await Future.wait([
      getOfficerCount(stationId),
      getOnPatrolCount(stationId),
      getCheckpointCount(stationId),
      getTodayAttendance(stationId),
    ]);

    return {
      "officers": results[0],
      "onPatrol": results[1],
      "checkpoints": results[2],
      "attendance": results[3],
    };
  }
}