import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:npms/mobile/home/model/patrol_model.dart';

import '../../../../core/services/firebase_service.dart';
import '../../pages/officer/model/officer_model.dart';
import '../controller/admin_dashboard_controller.dart';


class DashboardService {
  final _firestore = FirebaseService.firestore;

  //----------------------------------------------------------
  // Counts
  //----------------------------------------------------------

  Future<int> totalOfficers() async {
    final result = await _firestore
        .collection("officers")
        .where("deleted", isEqualTo: false)
        .count()
        .get();

    return result.count ?? 0;
  }

  Future<int> totalStations() async {
  final snapshot = await _firestore
      .collection("police_stations")
      .get();

  debugPrint("Stations Found: ${snapshot.docs.length}");

  for (var doc in snapshot.docs) {
    debugPrint(doc.data().toString());
  }

  return snapshot.docs.length;
}

 Future<int> totalCheckpoints() async {
  final snapshot = await _firestore
      .collection("qr_checkpoints")
      .get();

  debugPrint("Checkpoints Found: ${snapshot.docs.length}");

  for (var doc in snapshot.docs) {
    debugPrint(doc.data().toString());
  }

  return snapshot.docs.length;
}

  Future<int> totalPatrols() async {
    final result = await _firestore
        .collection("patrol_history")
        .where("deleted", isEqualTo: false)
        .count()
        .get();

    return result.count ?? 0;
  }

  //----------------------------------------------------------
  // Today's Patrol Count
  //----------------------------------------------------------

  Future<int> todayPatrols() async {
    final now = DateTime.now();

    final start = Timestamp.fromDate(
      DateTime(now.year, now.month, now.day),
    );

    final end = Timestamp.fromDate(
      DateTime(now.year, now.month, now.day, 23, 59, 59),
    );

    final result = await _firestore
        .collection("patrol_history")
        .where("deleted", isEqualTo: false)
        .where("createdAt", isGreaterThanOrEqualTo: start)
        .where("createdAt", isLessThanOrEqualTo: end)
        .count()
        .get();

    return result.count ?? 0;
  }

  //----------------------------------------------------------
  // Recent Patrols
  //----------------------------------------------------------

 Future<List<PatrolHistoryModel>> recentPatrols() async {
  try {
    debugPrint("========== RECENT PATROLS ==========");

    final snapshot = await _firestore
        .collection("patrol_history")
        .where("deleted", isEqualTo: false)
        .orderBy("createdAt", descending: true)
        .limit(10)
        .get();

    debugPrint("Documents Found : ${snapshot.docs.length}");

    for (final doc in snapshot.docs) {
      debugPrint(
        "ID : ${doc.id} | Officer : ${doc.data()['officerName']} | Checkpoint : ${doc.data()['checkpointName']}",
      );
    }

    final list = snapshot.docs
        .map(
          (e) => PatrolHistoryModel.fromMap(
            e.data(),
            e.id,
          ),
        )
        .toList();

    debugPrint("Model Count : ${list.length}");
    debugPrint("========== END RECENT PATROLS ==========");

    return list;
  } catch (e, stack) {
    debugPrint("========== RECENT PATROL ERROR ==========");
    debugPrint("Error : ${e.toString()}");
    debugPrint("StackTrace :");
    debugPrint(stack.toString());
    debugPrint("=========================================");

    rethrow;
  }
}

  //----------------------------------------------------------
  // Recent Officers
  //----------------------------------------------------------

  Future<List<OfficerModel>> recentOfficers() async {
    final snapshot = await _firestore
        .collection("officers")
        .where("deleted", isEqualTo: false)
        .orderBy("createdAt", descending: true)
        .limit(10)
        .get();

    return snapshot.docs
        .map(
          (e) => OfficerModel.fromMap(
            e.data(),
            e.id,
          ),
        )
        .toList();
  }

  Future<List<WeeklyPatrolModel>> weeklyPatrols() async {
  final now = DateTime.now();

  List<WeeklyPatrolModel> list = [];

  debugPrint("========== WEEKLY PATROL ==========");

  for (int i = 6; i >= 0; i--) {
    final day = now.subtract(Duration(days: i));

    final start = Timestamp.fromDate(
      DateTime(day.year, day.month, day.day),
    );

    final end = Timestamp.fromDate(
      DateTime(day.year, day.month, day.day, 23, 59, 59),
    );

    debugPrint("--------------------------------");
    debugPrint("Day : ${day.toString()}");
    debugPrint("Start : ${start.toDate()}");
    debugPrint("End : ${end.toDate()}");

    try {
      final result = await FirebaseService.firestore
          .collection("patrol_history")
          .where("deleted", isEqualTo: false)
          .where("createdAt", isGreaterThanOrEqualTo: start)
          .where("createdAt", isLessThanOrEqualTo: end)
          .count()
          .get();

      debugPrint("Count : ${result.count}");

      list.add(
        WeeklyPatrolModel(
          day: [
            "Mon",
            "Tue",
            "Wed",
            "Thu",
            "Fri",
            "Sat",
            "Sun"
          ][day.weekday - 1],
          count: result.count ?? 0,
        ),
      );
    } catch (e, stack) {
      debugPrint("========== FIRESTORE ERROR ==========");
      debugPrint(e.toString());
      debugPrint(stack.toString());
      debugPrint("=====================================");

      rethrow;
    }
  }

  debugPrint("Weekly Data Loaded");
  debugPrint(list.toString());

  return list;
}
}

