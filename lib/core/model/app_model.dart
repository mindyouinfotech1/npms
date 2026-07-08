import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AppModel {
  final String id;

  /// active / inactive / deleted
  final String status;

  /// Soft Delete
  final bool deleted;

  /// Audit Fields
  final String createdBy;
  final String updatedBy;
  final String? deletedBy;
  final Timestamp? lastLogin;

  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  final Timestamp? deletedAt;

  const AppModel({
    required this.id,
    required this.status,
    required this.deleted,
    required this.createdBy,
    required this.updatedBy,
     this.lastLogin,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  /// Every model must implement
  Map<String, dynamic> toMap();
}