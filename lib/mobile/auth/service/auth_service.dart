import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/services/firebase_service.dart';
import '../../../admin/pages/officer/model/officer_model.dart';


class OfficerLoginService {
  final CollectionReference<Map<String, dynamic>> _collection =
      FirebaseService.firestore.collection("officers");

  //==========================================================
  // LOGIN
  //==========================================================

  Future<OfficerModel?> login({
    required String badgeId,
    required String password,
  }) async {
    final snapshot = await _collection
        .where("badgeId", isEqualTo: badgeId.trim())
        .where("password", isEqualTo: password.trim())
        .where("deleted", isEqualTo: false)
        .where("status", isEqualTo: "active")
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    final doc = snapshot.docs.first;

    return OfficerModel.fromMap(
      doc.data(),
      doc.id,
    );
  }

  //==========================================================
  // CHECK BADGE EXISTS
  //==========================================================

  Future<bool> badgeExists(String badgeId) async {
    final snapshot = await _collection
        .where("badgeId", isEqualTo: badgeId.trim())
        .where("deleted", isEqualTo: false)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  //==========================================================
  // GET OFFICER PROFILE
  //==========================================================

  Future<OfficerModel?> getOfficer(String officerId) async {
    final doc = await _collection.doc(officerId).get();

    if (!doc.exists) {
      return null;
    }

    return OfficerModel.fromMap(
      doc.data()!,
      doc.id,
    );
  }

  //==========================================================
  // UPDATE LAST LOGIN
  //==========================================================

  Future<void> updateLastLogin(String officerId) async {
    await _collection.doc(officerId).update({
      "lastLogin": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }
}