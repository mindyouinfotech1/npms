import 'package:cloud_firestore/cloud_firestore.dart';

class OfficerReportModel {
  /// Officer
  final String officerId;
  final String officerName;
  final String badgeId;
  final String rank;

  /// Station
  final String stationId;
  final String stationName;

  /// Report Statistics
  final int assignedQrPoints;
  final int visitedQrPoints;
  final int missedQrPoints;

  final int totalPatrols;

  /// Compliance %
  final double compliance;

  /// Last Patrol
  final DateTime? lastPatrolTime;

  const OfficerReportModel({
    required this.officerId,
    required this.officerName,
    required this.badgeId,
    required this.rank,
    required this.stationId,
    required this.stationName,
    required this.assignedQrPoints,
    required this.visitedQrPoints,
    required this.missedQrPoints,
    required this.totalPatrols,
    required this.compliance,
    this.lastPatrolTime,
  });

  //----------------------------------------------------------
  // Factory
  //----------------------------------------------------------

  factory OfficerReportModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return OfficerReportModel(
      officerId: map["officerId"] ?? "",

      officerName: map["officerName"] ?? "",

      badgeId: map["badgeId"] ?? "",

      rank: map["rank"] ?? "",

      stationId: map["stationId"] ?? "",

      stationName: map["stationName"] ?? "",

      assignedQrPoints:
          map["assignedQrPoints"] ?? 0,

      visitedQrPoints:
          map["visitedQrPoints"] ?? 0,

      missedQrPoints:
          map["missedQrPoints"] ?? 0,

      totalPatrols:
          map["totalPatrols"] ?? 0,

      compliance:
          (map["compliance"] ?? 0).toDouble(),

      lastPatrolTime:
          map["lastPatrolTime"] is Timestamp
              ? (map["lastPatrolTime"] as Timestamp)
                  .toDate()
              : null,
    );
  }

  //----------------------------------------------------------
  // To Map
  //----------------------------------------------------------

  Map<String, dynamic> toMap() {
    return {
      "officerId": officerId,

      "officerName": officerName,

      "badgeId": badgeId,

      "rank": rank,

      "stationId": stationId,

      "stationName": stationName,

      "assignedQrPoints": assignedQrPoints,

      "visitedQrPoints": visitedQrPoints,

      "missedQrPoints": missedQrPoints,

      "totalPatrols": totalPatrols,

      "compliance": compliance,

      "lastPatrolTime": lastPatrolTime == null
          ? null
          : Timestamp.fromDate(lastPatrolTime!),
    };
  }

  //----------------------------------------------------------
  // CopyWith
  //----------------------------------------------------------

  OfficerReportModel copyWith({
    String? officerId,
    String? officerName,
    String? badgeId,
    String? rank,
    String? stationId,
    String? stationName,
    int? assignedQrPoints,
    int? visitedQrPoints,
    int? missedQrPoints,
    int? totalPatrols,
    double? compliance,
    DateTime? lastPatrolTime,
  }) {
    return OfficerReportModel(
      officerId: officerId ?? this.officerId,

      officerName:
          officerName ?? this.officerName,

      badgeId: badgeId ?? this.badgeId,

      rank: rank ?? this.rank,

      stationId:
          stationId ?? this.stationId,

      stationName:
          stationName ?? this.stationName,

      assignedQrPoints:
          assignedQrPoints ??
              this.assignedQrPoints,

      visitedQrPoints:
          visitedQrPoints ??
              this.visitedQrPoints,

      missedQrPoints:
          missedQrPoints ??
              this.missedQrPoints,

      totalPatrols:
          totalPatrols ??
              this.totalPatrols,

      compliance:
          compliance ?? this.compliance,

      lastPatrolTime:
          lastPatrolTime ??
              this.lastPatrolTime,
    );
  }

  //----------------------------------------------------------
  // Helpers
  //----------------------------------------------------------

  bool get isPerfect =>
      missedQrPoints == 0;

  bool get hasMissedPatrol =>
      missedQrPoints > 0;

  bool get isFullyCompliant =>
      compliance >= 100;

  String get complianceText =>
      "${compliance.toStringAsFixed(1)}%";
}