import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/officer_report_model.dart';
import '../model/station_report_model.dart';
import '../../../../core/services/firebase_service.dart';

class ReportService {
  final FirebaseFirestore firestore =
      FirebaseService.firestore;

  //----------------------------------------------------------
  // Collections
  //----------------------------------------------------------

  CollectionReference<Map<String, dynamic>>
      get stationCollection =>
          firestore.collection("police_stations");

  CollectionReference<Map<String, dynamic>>
      get checkpointCollection =>
          firestore.collection("qr_checkpoints");

  CollectionReference<Map<String, dynamic>>
      get officerCollection =>
          firestore.collection("officers");

  CollectionReference<Map<String, dynamic>>
      get patrolCollection =>
          firestore.collection("patrol_history");

  //----------------------------------------------------------
  // Station Report
  //----------------------------------------------------------
  

  Future<List<StationReportModel>> stationReport({
    
    String? stationId,
    DateTime? from,
    DateTime? to,
  }) async {

    

    
        Query<Map<String, dynamic>> stationQuery =
          stationCollection.where(
        "status",
        whereIn: ["active", "inactive"],
)     ;
    if (stationId != null && stationId.isNotEmpty) {
      stationQuery = stationQuery.where(
        "id",
        isEqualTo: stationId,
      );
    }

  final stationSnapshot = await stationQuery.get();

debugPrint("Stations Found = ${stationSnapshot.docs.length}");

for (final station in stationSnapshot.docs) {
  debugPrint("------------------------------------------------");
  debugPrint("Station ID = ${station.id}");
  debugPrint("Station Name = ${station["stationName"]}");

  final qrSnapshot = await checkpointCollection
      .where("deleted", isEqualTo: false)
      .where("stationId", isEqualTo: station.id)
      .get();

  debugPrint("QR = ${qrSnapshot.docs.length}");

  final officerSnapshot = await officerCollection
      .where("deleted", isEqualTo: false)
      .where("stationId", isEqualTo: station.id)
      .get();

  debugPrint("Officer = ${officerSnapshot.docs.length}");

  final patrolSnapshot = await patrolCollection
      .where("deleted", isEqualTo: false)
      .where("stationId", isEqualTo: station.id)
      .get();

  debugPrint("Patrol = ${patrolSnapshot.docs.length}");
}

    List<StationReportModel> reports = [];

    

    for (final station in stationSnapshot.docs) {
      final stationData = station.data();

      

      final String id = station.id;

      

      debugPrint("================================");
      debugPrint("Station Doc ID : $id");
      debugPrint("Station Name   : ${stationData["stationName"]}");

      //------------------------------------------------------
      // Total QR
      //------------------------------------------------------

      // final qrSnapshot = await checkpointCollection
      //     .where("deleted", isEqualTo: false)
      //     .where("stationId", isEqualTo: id)
      //     .get();

      final qrSnapshot = await checkpointCollection
    .where("deleted", isEqualTo: false)
    .where("stationId", isEqualTo: id)
    .get();

      debugPrint("QR Count : ${qrSnapshot.docs.length}");

      for (final qr in qrSnapshot.docs) {
        debugPrint("QR stationId : ${qr["stationId"]}");
      }

      final totalQr = qrSnapshot.docs.length;

      

      

      //------------------------------------------------------
      // Total Officers
      //------------------------------------------------------

      final officerSnapshot = await officerCollection
          .where("deleted", isEqualTo: false)
          .where("stationId", isEqualTo: id)
          .get();

      final totalOfficers =
          officerSnapshot.docs.length;

      //------------------------------------------------------
      // Patrol Query
      //------------------------------------------------------

      Query<Map<String, dynamic>> patrolQuery =
          patrolCollection
              .where(
                "deleted",
                isEqualTo: false,
              )
              .where(
                "stationId",
                isEqualTo: id,
              );

      if (from != null) {
        patrolQuery = patrolQuery.where(
          "patrolTime",
          isGreaterThanOrEqualTo:
              Timestamp.fromDate(from),
        );
      }

      if (to != null) {
        patrolQuery = patrolQuery.where(
          "patrolTime",
          isLessThanOrEqualTo:
              Timestamp.fromDate(to),
        );
      }

      final patrolSnapshot =
          await patrolQuery.get();

      //------------------------------------------------------
      // Distinct QR Visited
      //------------------------------------------------------

      final visitedSet = <String>{};

      for (final doc in patrolSnapshot.docs) {
        final checkpoint =
            doc["checkpointId"] ?? "";

        if (checkpoint.isNotEmpty) {
          visitedSet.add(checkpoint);
        }
      }

      final visited = visitedSet.length;

      final missed =
          (totalQr - visited) < 0
              ? 0
              : totalQr - visited;

      final compliance = totalQr == 0
          ? 0
          : (visited / totalQr) * 100;

      // reports.add(
      //   StationReportModel(
      //     stationId: id,
      //     stationName:
      //         stationData["stationName"] ??
      //             stationData["name"] ??
      //             "",

      //     totalQrPoints: totalQr,

      //     visitedQrPoints: visited,

      //     missedQrPoints: missed,

      //     totalPatrols:
      //         patrolSnapshot.docs.length,

      //     compliance: compliance.toDouble(),

      //     totalOfficers: totalOfficers,

      //     reportDate: DateTime.now(),
      //   ),
      // );



       debugPrint("About to add report for ${stationData["stationName"]}");

    reports.add(
      StationReportModel(
        stationId: id,
        stationName: stationData["stationName"] ?? "",
        totalQrPoints: totalQr,
        visitedQrPoints: visited,
        missedQrPoints: missed,
        totalPatrols: patrolSnapshot.docs.length,
        compliance: compliance.toDouble(),
        totalOfficers: totalOfficers,
        reportDate: DateTime.now(),
      ),
    );

    debugPrint("Report added successfully");
    }

    reports.sort(
      (a, b) =>
          b.compliance.compareTo(a.compliance),
    );

    return reports;
  }

  //----------------------------------------------------------
  // Officer Report
  //----------------------------------------------------------

  Future<List<OfficerReportModel>>
      officerReport({
    String? stationId,
    DateTime? from,
    DateTime? to,
  }) async {
    Query<Map<String, dynamic>> officerQuery =
        officerCollection.where(
      "deleted",
      isEqualTo: false,
    );

    if (stationId != null &&
        stationId.isNotEmpty) {
      officerQuery = officerQuery.where(
        "stationId",
        isEqualTo: stationId,
      );
    }

    final officers =
        await officerQuery.get();

    List<OfficerReportModel> list = [];

    for (final officer in officers.docs) {
      final data = officer.data();

      Query<Map<String, dynamic>> patrolQuery =
          patrolCollection
              .where(
                "deleted",
                isEqualTo: false,
              )
              .where(
                "officerId",
                isEqualTo: officer.id,
              );

      if (from != null) {
        patrolQuery = patrolQuery.where(
          "createdAt",
          isGreaterThanOrEqualTo:
              Timestamp.fromDate(from),
        );
      }

      if (to != null) {
        patrolQuery = patrolQuery.where(
          "createdAt",
          isLessThanOrEqualTo:
              Timestamp.fromDate(to),
        );
      }

      final patrols =
          await patrolQuery.get();

      final visited =
          patrols.docs
              .map((e) => e["checkpointId"])
              .toSet()
              .length;

      final assigned = await checkpointCollection
          .where(
            "stationId",
            isEqualTo: data["stationId"],
          )
          .count()
          .get();

      final assignedCount =
          assigned.count ?? 0;

      final missed =
          assignedCount - visited;

      final compliance =
          assignedCount == 0
              ? 0
              : (visited /
                      assignedCount) *
                  100;

      DateTime? lastPatrol;

      if (patrols.docs.isNotEmpty) {
        lastPatrol =
            (patrols.docs.first["createdAt"]
                    as Timestamp)
                .toDate();
      }

      list.add(
        OfficerReportModel(
          officerId: officer.id,

          officerName:
              data["fullName"] ?? "",

          badgeId:
              data["badgeId"] ?? "",

          rank: data["rank"] ?? "",

          stationId:
              data["stationId"] ?? "",

          stationName:
              data["stationName"] ?? "",

          assignedQrPoints:
              assignedCount,

          visitedQrPoints:
              visited,

          missedQrPoints:
              missed,

          totalPatrols:
              patrols.docs.length,

          compliance:
              compliance.toDouble(),

          lastPatrolTime:
              lastPatrol,
        ),
      );
    }

    list.sort(
      (a, b) =>
          b.compliance.compareTo(a.compliance),
    );

    return list;
  }
}