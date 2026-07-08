import 'package:cloud_firestore/cloud_firestore.dart';

class QrCheckpointModel {
  final String id;

  final String qrId;
  final String checkpointName;
  final String areaDescription;

  final String stationId;
  final String stationName;

  final double latitude;
  final double longitude;

  final String priority;

  final String qrData;
  final String qrImage;

  /// active | inactive | deleted
  final String status;

  /// Soft Delete
  final bool deleted;
  final String deletedBy;
  final Timestamp? deletedAt;

  /// Audit
  final String createdBy;
  final Timestamp? createdAt;

  final String updatedBy;
  final Timestamp? updatedAt;

  const QrCheckpointModel({
    required this.id,
    required this.qrId,
    required this.checkpointName,
    required this.areaDescription,
    required this.stationId,
    required this.stationName,
    required this.latitude,
    required this.longitude,
    required this.priority,
    required this.qrData,
    required this.qrImage,
    required this.status,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.updatedBy = "",
    this.deleted = false,
    this.deletedBy = "",
    this.deletedAt,
  });

  factory QrCheckpointModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return QrCheckpointModel(
      id: id,
      qrId: map["qrId"] ?? "",
      checkpointName: map["checkpointName"] ?? "",
      areaDescription: map["areaDescription"] ?? "",
      stationId: map["stationId"] ?? "",
      stationName: map["stationName"] ?? "",
      latitude: (map["latitude"] ?? 0).toDouble(),
      longitude: (map["longitude"] ?? 0).toDouble(),
      priority: map["priority"] ?? "Low",
      qrData: map["qrData"] ?? "",
      qrImage: map["qrImage"] ?? "",
      status: map["status"] ?? "active",

      createdBy: map["createdBy"] ?? "",
      createdAt: map["createdAt"],

      updatedBy: map["updatedBy"] ?? "",
      updatedAt: map["updatedAt"],

      deleted: map["deleted"] ?? false,
      deletedBy: map["deletedBy"] ?? "",
      deletedAt: map["deletedAt"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "qrId": qrId,
      "checkpointName": checkpointName,
      "areaDescription": areaDescription,
      "stationId": stationId,
      "stationName": stationName,
      "latitude": latitude,
      "longitude": longitude,
      "priority": priority,
      "qrData": qrData,
      "qrImage": qrImage,
      "status": status,

      "createdBy": createdBy,
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),

      "updatedBy": updatedBy,
      "updatedAt": FieldValue.serverTimestamp(),

      "deleted": deleted,
      "deletedBy": deletedBy,
      "deletedAt": deletedAt,
    };
  }

  QrCheckpointModel copyWith({
    String? id,
    String? qrId,
    String? checkpointName,
    String? areaDescription,
    String? stationId,
    String? stationName,
    double? latitude,
    double? longitude,
    String? priority,
    String? qrData,
    String? qrImage,
    String? status,
    bool? deleted,
    String? deletedBy,
    Timestamp? deletedAt,
    String? createdBy,
    Timestamp? createdAt,
    String? updatedBy,
    Timestamp? updatedAt,
  }) {
    return QrCheckpointModel(
      id: id ?? this.id,
      qrId: qrId ?? this.qrId,
      checkpointName: checkpointName ?? this.checkpointName,
      areaDescription: areaDescription ?? this.areaDescription,
      stationId: stationId ?? this.stationId,
      stationName: stationName ?? this.stationName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      priority: priority ?? this.priority,
      qrData: qrData ?? this.qrData,
      qrImage: qrImage ?? this.qrImage,
      status: status ?? this.status,
      deleted: deleted ?? this.deleted,
      deletedBy: deletedBy ?? this.deletedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}