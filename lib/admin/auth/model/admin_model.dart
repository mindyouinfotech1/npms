import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  final String id;
  final String username;
  final String password;
  final String name;
  final String email;
  final String mobile;
  final String profileImage;
  final String status;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  final Timestamp? lastLogin;

  const AdminModel({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
    required this.mobile,
    required this.profileImage,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
  });

  factory AdminModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return AdminModel(
      id: doc.id,
      username: data['username'] ?? '',
      password: data['password'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      mobile: data['mobile'] ?? '',
      profileImage: data['profileImage'] ?? '',
      status: data['status'] ?? '',
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      lastLogin: data['lastLogin'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'mobile': mobile,
      'profileImage': profileImage,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'lastLogin': lastLogin,
    };
  }
}