import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../mobile/home/model/patrol_model.dart';

class StationReportModel {
  /// Station
  final String stationId;
  final String stationName;

  /// QR Statistics
  final int totalQrPoints;
  final int visitedQrPoints;
  final int missedQrPoints;

  /// Patrol Statistics
  final int totalPatrols;

  /// Compliance %
  final double compliance;

  /// Officer Statistics
  final int totalOfficers;

  /// Report Date
  final DateTime reportDate;

  /// Patrol Details
  final List<PatrolHistoryModel> details;

  const StationReportModel({
    required this.stationId,
    required this.stationName,
    required this.totalQrPoints,
    required this.visitedQrPoints,
    required this.missedQrPoints,
    required this.totalPatrols,
    required this.compliance,
    required this.totalOfficers,
    required this.reportDate,
    this.details = const [],
  });

  //----------------------------------------------------------
  // Factory
  //----------------------------------------------------------

  factory StationReportModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return StationReportModel(
      stationId: map["stationId"] ?? "",

      stationName: map["stationName"] ?? "",

      totalQrPoints: map["totalQrPoints"] ?? 0,

      visitedQrPoints: map["visitedQrPoints"] ?? 0,

      missedQrPoints: map["missedQrPoints"] ?? 0,

      totalPatrols: map["totalPatrols"] ?? 0,

      compliance: (map["compliance"] ?? 0).toDouble(),

      totalOfficers: map["totalOfficers"] ?? 0,

      reportDate: map["reportDate"] is Timestamp
          ? (map["reportDate"] as Timestamp).toDate()
          : DateTime.now(),

      // Details are not stored in Firestore.
      details: const [],
    );
  }

  //----------------------------------------------------------
  // To Map
  //----------------------------------------------------------

  Map<String, dynamic> toMap() {
    return {
      "stationId": stationId,
      "stationName": stationName,
      "totalQrPoints": totalQrPoints,
      "visitedQrPoints": visitedQrPoints,
      "missedQrPoints": missedQrPoints,
      "totalPatrols": totalPatrols,
      "compliance": compliance,
      "totalOfficers": totalOfficers,
      "reportDate": Timestamp.fromDate(reportDate),
    };
  }

  //----------------------------------------------------------
  // Copy With
  //----------------------------------------------------------

  StationReportModel copyWith({
    String? stationId,
    String? stationName,
    int? totalQrPoints,
    int? visitedQrPoints,
    int? missedQrPoints,
    int? totalPatrols,
    double? compliance,
    int? totalOfficers,
    DateTime? reportDate,
    List<PatrolHistoryModel>? details,
  }) {
    return StationReportModel(
      stationId: stationId ?? this.stationId,
      stationName: stationName ?? this.stationName,
      totalQrPoints: totalQrPoints ?? this.totalQrPoints,
      visitedQrPoints: visitedQrPoints ?? this.visitedQrPoints,
      missedQrPoints: missedQrPoints ?? this.missedQrPoints,
      totalPatrols: totalPatrols ?? this.totalPatrols,
      compliance: compliance ?? this.compliance,
      totalOfficers: totalOfficers ?? this.totalOfficers,
      reportDate: reportDate ?? this.reportDate,
      details: details ?? this.details,
    );
  }

  //----------------------------------------------------------
  // Helpers
  //----------------------------------------------------------

  bool get isPerfect => missedQrPoints == 0;

  bool get hasMissedPatrol => missedQrPoints > 0;

  String get complianceText =>
      "${compliance.toStringAsFixed(1)}%";
}