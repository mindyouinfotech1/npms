import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/model/app_model.dart';

class PatrolHistoryModel extends AppModel {
  /// Officer
  final String officerId;
  final String officerName;
  final String badgeId;
  final String rank;

  /// Station
  final String stationId;
  final String stationName;

  /// Checkpoint
  final String checkpointId;
  final String checkpointName;

  final double checkpointLatitude;
  final double checkpointLongitude;

  /// Officer GPS
  final double officerLatitude;
  final double officerLongitude;

  /// GPS Accuracy & Distance
  final double gpsAccuracy;
  final double distance;

  /// Photo
  final String photoUrl;

  /// Optional Remarks
  final String remarks;

  /// Device Time
  final Timestamp? patrolTime;

  const PatrolHistoryModel({
    required super.id,

    required super.status,
    required super.deleted,

    required super.createdBy,
    required super.updatedBy,

    super.deletedBy,

    super.createdAt,
    super.updatedAt,
    super.deletedAt,

    required this.officerId,
    required this.officerName,
    required this.badgeId,
    required this.rank,

    required this.stationId,
    required this.stationName,

    required this.checkpointId,
    required this.checkpointName,

    required this.checkpointLatitude,
    required this.checkpointLongitude,

    required this.officerLatitude,
    required this.officerLongitude,

    required this.gpsAccuracy,
    required this.distance,

    required this.photoUrl,
    required this.remarks,

    this.patrolTime,
  });

  factory PatrolHistoryModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return PatrolHistoryModel(
      id: id,

      officerId: map["officerId"] ?? "",
      officerName: map["officerName"] ?? "",
      badgeId: map["badgeId"] ?? "",
      rank: map["rank"] ?? "",

      stationId: map["stationId"] ?? "",
      stationName: map["stationName"] ?? "",

      checkpointId: map["checkpointId"] ?? "",
      checkpointName: map["checkpointName"] ?? "",

      checkpointLatitude:
          (map["checkpointLatitude"] ?? 0).toDouble(),

      checkpointLongitude:
          (map["checkpointLongitude"] ?? 0).toDouble(),

      officerLatitude:
          (map["officerLatitude"] ?? 0).toDouble(),

      officerLongitude:
          (map["officerLongitude"] ?? 0).toDouble(),

      gpsAccuracy:
          (map["gpsAccuracy"] ?? 0).toDouble(),

      distance:
          (map["distance"] ?? 0).toDouble(),

      photoUrl: map["photoUrl"] ?? "",

      remarks: map["remarks"] ?? "",

      patrolTime: map["patrolTime"],

      //----------------------
      // Common
      //----------------------

      status: map["status"] ?? "completed",

      deleted: map["deleted"] ?? false,

      createdBy: map["createdBy"] ?? "",
      updatedBy: map["updatedBy"] ?? "",

      deletedBy: map["deletedBy"],

      createdAt: map["createdAt"],
      updatedAt: map["updatedAt"],
      deletedAt: map["deletedAt"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "officerId": officerId,
      "officerName": officerName,
      "badgeId": badgeId,
      "rank": rank,

      "stationId": stationId,
      "stationName": stationName,

      "checkpointId": checkpointId,
      "checkpointName": checkpointName,

      "checkpointLatitude": checkpointLatitude,
      "checkpointLongitude": checkpointLongitude,

      "officerLatitude": officerLatitude,
      "officerLongitude": officerLongitude,

      "gpsAccuracy": gpsAccuracy,
      "distance": distance,

      "photoUrl": photoUrl,

      "remarks": remarks,

      "patrolTime":
          patrolTime ?? FieldValue.serverTimestamp(),

      //----------------------
      // Common
      //----------------------

      "status": status,

      "deleted": deleted,

      "createdBy": createdBy,
      "updatedBy": updatedBy,

      "deletedBy": deletedBy,

      "createdAt":
          createdAt ?? FieldValue.serverTimestamp(),

      "updatedAt":
          FieldValue.serverTimestamp(),

      "deletedAt": deletedAt,
    };
  }

  PatrolHistoryModel copyWith({
    String? id,

    String? officerId,
    String? officerName,
    String? badgeId,
    String? rank,

    String? stationId,
    String? stationName,

    String? checkpointId,
    String? checkpointName,

    double? checkpointLatitude,
    double? checkpointLongitude,

    double? officerLatitude,
    double? officerLongitude,

    double? gpsAccuracy,
    double? distance,

    String? photoUrl,
    String? remarks,

    Timestamp? patrolTime,

    String? status,
    bool? deleted,

    String? createdBy,
    String? updatedBy,
    String? deletedBy,

    Timestamp? createdAt,
    Timestamp? updatedAt,
    Timestamp? deletedAt,
  }) {
    return PatrolHistoryModel(
      id: id ?? this.id,

      officerId: officerId ?? this.officerId,
      officerName: officerName ?? this.officerName,
      badgeId: badgeId ?? this.badgeId,
      rank: rank ?? this.rank,

      stationId: stationId ?? this.stationId,
      stationName: stationName ?? this.stationName,

      checkpointId: checkpointId ?? this.checkpointId,
      checkpointName:
          checkpointName ?? this.checkpointName,

      checkpointLatitude:
          checkpointLatitude ??
              this.checkpointLatitude,

      checkpointLongitude:
          checkpointLongitude ??
              this.checkpointLongitude,

      officerLatitude:
          officerLatitude ?? this.officerLatitude,

      officerLongitude:
          officerLongitude ?? this.officerLongitude,

      gpsAccuracy:
          gpsAccuracy ?? this.gpsAccuracy,

      distance:
          distance ?? this.distance,

      photoUrl:
          photoUrl ?? this.photoUrl,

      remarks:
          remarks ?? this.remarks,

      patrolTime:
          patrolTime ?? this.patrolTime,

      status:
          status ?? this.status,

      deleted:
          deleted ?? this.deleted,

      createdBy:
          createdBy ?? this.createdBy,

      updatedBy:
          updatedBy ?? this.updatedBy,

      deletedBy:
          deletedBy ?? this.deletedBy,

      createdAt:
          createdAt ?? this.createdAt,

      updatedAt:
          updatedAt ?? this.updatedAt,

      deletedAt:
          deletedAt ?? this.deletedAt,
    );
  }
}