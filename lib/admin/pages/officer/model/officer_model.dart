import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/model/app_model.dart';

class OfficerModel extends AppModel {
  /// Login
  final String badgeId;
  final String password;

  /// Personal
  final String fullName;
  final String mobile;
  final String email;

  /// Police Details
  final String rank;

  final String stationId;
  final String stationName;

  /// Shift
  /// Day | Night | General
  final String shift;

  /// Profile
  final String profileImage;

  const OfficerModel({
    required super.id,

    required super.status,
    required super.deleted,

    required super.createdBy,
    required super.updatedBy,

    super.deletedBy,
    super.lastLogin,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,

    required this.badgeId,
    required this.password,
    required this.fullName,
    required this.mobile,
    required this.email,
    required this.rank,
    required this.stationId,
    required this.stationName,
    required this.shift,
    required this.profileImage,
  });

  factory OfficerModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return OfficerModel(
      id: id,

      badgeId: map["badgeId"] ?? "",
      password: map["password"] ?? "",

      fullName: map["fullName"] ?? "",
      mobile: map["mobile"] ?? "",
      email: map["email"] ?? "",

      rank: map["rank"] ?? "",

      stationId: map["stationId"] ?? "",
      stationName: map["stationName"] ?? "",

      shift: map["shift"] ?? "Night",

      profileImage: map["profileImage"] ?? "",

      //-------------------------
      // Common Fields
      //-------------------------

      status: map["status"] ?? "active",

      deleted: map["deleted"] ?? false,

      createdBy: map["createdBy"] ?? "",
      updatedBy: map["updatedBy"] ?? "",

      deletedBy: map["deletedBy"],
       lastLogin: map["lastLogin"],
      createdAt: map["createdAt"],
      updatedAt: map["updatedAt"],
      deletedAt: map["deletedAt"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "badgeId": badgeId,
      "password": password,

      "fullName": fullName,
      "mobile": mobile,
      "email": email,

      "rank": rank,

      "stationId": stationId,
      "stationName": stationName,

      "shift": shift,

      "profileImage": profileImage,

      //-------------------------
      // Common Fields
      //-------------------------

      "status": status,

      "deleted": deleted,

      "createdBy": createdBy,
      "updatedBy": updatedBy,

      "deletedBy": deletedBy,
      "lastLogin": lastLogin ?? FieldValue.serverTimestamp(),
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
      "deletedAt": deletedAt,
    };
  }

  OfficerModel copyWith({
    String? id,

    String? badgeId,
    String? password,

    String? fullName,
    String? mobile,
    String? email,

    String? rank,

    String? stationId,
    String? stationName,

    String? shift,

    String? profileImage,

    String? status,
    bool? deleted,
    Timestamp? lastLogin,
    String? createdBy,
    String? updatedBy,
    String? deletedBy,

    Timestamp? createdAt,
    Timestamp? updatedAt,
    Timestamp? deletedAt,
  }) {
    return OfficerModel(
      id: id ?? this.id,

      badgeId: badgeId ?? this.badgeId,
      password: password ?? this.password,

      fullName: fullName ?? this.fullName,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,

      rank: rank ?? this.rank,

      stationId: stationId ?? this.stationId,
      stationName: stationName ?? this.stationName,

      shift: shift ?? this.shift,

      profileImage: profileImage ?? this.profileImage,

      status: status ?? this.status,

      deleted: deleted ?? this.deleted,

      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,

      deletedBy: deletedBy ?? this.deletedBy,
      lastLogin: lastLogin ?? this.lastLogin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}