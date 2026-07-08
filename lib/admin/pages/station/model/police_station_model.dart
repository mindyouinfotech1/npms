import 'package:cloud_firestore/cloud_firestore.dart';

class PoliceStationModel {
  final String id;

  final String stationName;

  final String district;

  /// Urban / Rural
  final String type;

  /// active / inactive / deleted
  final String status;

  final DateTime createdAt;

  final DateTime updatedAt;

  final String createdBy;

  const PoliceStationModel({
    required this.id,
    required this.stationName,
    required this.district,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
  });

  factory PoliceStationModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return PoliceStationModel(
      id: id,
      stationName: map["stationName"] ?? "",
      district: map["district"] ?? "",
      type: map["type"] ?? "Urban",
      status: map["status"] ?? "active",
      createdBy: map["createdBy"] ?? "",

      createdAt: map["createdAt"] == null
          ? DateTime.now()
          : (map["createdAt"] as Timestamp).toDate(),

      updatedAt: map["updatedAt"] == null
          ? DateTime.now()
          : (map["updatedAt"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "stationName": stationName,
      "district": district,
      "type": type,
      "status": status,
      "createdBy": createdBy,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": Timestamp.fromDate(updatedAt),
    };
  }

  PoliceStationModel copyWith({
    String? id,
    String? stationName,
    String? district,
    String? type,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
  }) {
    return PoliceStationModel(
      id: id ?? this.id,
      stationName: stationName ?? this.stationName,
      district: district ?? this.district,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}