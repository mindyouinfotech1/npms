import 'dart:math';

import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../admin/auth/model/admin_model.dart';
import 'firebase_service.dart';

class AdminAuthService {

  
  Future<AdminModel?> login({
    required String username,
    required String password,
  }) async {
    final result = await FirebaseService.firestore
        .collection("admins")
        .where("username", isEqualTo: username)
        .where("status", isEqualTo: "active")
        .limit(1)
        .get();

        print("Found Docs: ${result.docs.length}");

    if (result.docs.isEmpty) {
      return null;
    }

    final admin = AdminModel.fromFirestore(result.docs.first);
    print("Entered Password: $password");
    print("Stored Hash: ${admin.password}");
    final isValid = BCrypt.checkpw(password, admin.password);

    print("Password Match: $isValid");

    final isPasswordCorrect =
        BCrypt.checkpw(password, admin.password);

    if (!isPasswordCorrect) {
      return null;
    }

    // Update last login
    await result.docs.first.reference.update({
      "lastLogin": FieldValue.serverTimestamp(),
    });

    return admin;
  }



 Future<bool> sendOtp({
    required String username,
    required String email,
  }) async {
    try {
      final result = await FirebaseService.firestore
          .collection("admins")
          .where("username", isEqualTo: username)
          .where("email", isEqualTo: email)
          .where("status", isEqualTo: "active")
          .limit(1)
          .get();

      if (result.docs.isEmpty) {
        return false;
      }

      final otp = _generateOtp();

      await FirebaseService.firestore
          .collection("password_reset_otps")
          .doc(username)
          .set({
        "username": username,
        "email": email,
        "otp": otp,
        "verified": false,
        "attempts": 0,
        "createdAt": FieldValue.serverTimestamp(),
        "expiresAt": Timestamp.fromDate(
          DateTime.now().add(
            const Duration(minutes: 10),
          ),
        ),
      });

      print("OTP : $otp");

      /// TODO
      /// EmailService.sendOtp(
      ///   email: email,
      ///   otp: otp,
      /// );

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// -------------------------
  /// Generate OTP
  /// -------------------------
  String _generateOtp() {
    final random = Random();

    return (100000 + random.nextInt(900000)).toString();
  }


  Future<bool> verifyOtp({
  required String username,
  required String otp,
}) async {
  try {
    final doc = await FirebaseService.firestore
        .collection("password_reset_otps")
        .doc(username)
        .get();

    if (!doc.exists) {
      return false;
    }

    final data = doc.data()!;

    // Already verified
    if (data["verified"] == true) {
      return false;
    }

    // Maximum attempts
    final attempts = data["attempts"] ?? 0;

    if (attempts >= 5) {
      return false;
    }

    // Check Expiry
    final Timestamp expiry = data["expiresAt"];

    if (expiry.toDate().isBefore(DateTime.now())) {
      return false;
    }

    // Check OTP
    if (data["otp"] != otp) {
      await FirebaseService.firestore
          .collection("password_reset_otps")
          .doc(username)
          .update({
        "attempts": FieldValue.increment(1),
      });

      return false;
    }

    // Mark Verified
    await FirebaseService.firestore
        .collection("password_reset_otps")
        .doc(username)
        .update({
      "verified": true,
      "verifiedAt": FieldValue.serverTimestamp(),
    });

    return true;
  } catch (e) {
    print(e);
    return false;
  }
}


Future<bool> resetPassword({
  required String username,
  required String hashedPassword,
}) async {
  try {
    final otpDoc = await FirebaseService.firestore
        .collection("password_reset_otps")
        .doc(username)
        .get();

    if (!otpDoc.exists) {
      return false;
    }

    final otpData = otpDoc.data()!;

    // OTP must be verified
    if (otpData["verified"] != true) {
      return false;
    }

    // Find admin
    final admin = await FirebaseService.firestore
        .collection("admins")
        .where("username", isEqualTo: username)
        .limit(1)
        .get();

    if (admin.docs.isEmpty) {
      return false;
    }

    await FirebaseService.firestore
        .collection("admins")
        .doc(admin.docs.first.id)
        .update({
      "password": hashedPassword,
      "updatedAt": FieldValue.serverTimestamp(),
      "lastLogin": null,
    });

    // Delete OTP after successful password reset
    await FirebaseService.firestore
        .collection("password_reset_otps")
        .doc(username)
        .delete();

    return true;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}

}