// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../../../core/services/firebase_service.dart';
// import '../model/patrol_history_model.dart';

// class PatrolHistoryService {
//   final CollectionReference<Map<String, dynamic>> _collection =
//       FirebaseService.firestore.collection("patrol_history");

//   //==========================================================
//   // Get Patrol History (Realtime)
//   //==========================================================

//   Stream<List<PatrolHistoryModel>> getPatrolHistory() {
//     return _collection
//         .where("deleted", isEqualTo: false)
//         .orderBy(
//           "createdAt",
//           descending: true,
//         )
//         .snapshots()
//         .map(
//           (snapshot) => snapshot.docs
//               .map(
//                 (e) => PatrolHistoryModel.fromMap(
//                   e.data(),
//                   e.id,
//                 ),
//               )
//               .toList(),
//         );
//   }

//   //==========================================================
//   // Server Side Pagination
//   //==========================================================

//   Future<QuerySnapshot<Map<String, dynamic>>> getPage({
//     required int limit,
//     DocumentSnapshot? startAfter,
//   }) async {
//     Query<Map<String, dynamic>> query = _collection
//         .where("deleted", isEqualTo: false)
//         .orderBy(
//           "createdAt",
//           descending: true,
//         )
//         .limit(limit);

//     if (startAfter != null) {
//       query = query.startAfterDocument(startAfter);
//     }

//     return query.get();
//   }

//   //==========================================================
//   // Get Patrol By ID
//   //==========================================================

//   Future<PatrolHistoryModel?> getPatrol(String id) async {
//   final doc = await _collection.doc(id).get();

//   if (!doc.exists) {
//     return null;
//   }

//   return PatrolHistoryModel.fromMap(
//     doc.data()!,
//     doc.id,
//   );
// }

//   //==========================================================
//   // Soft Delete
//   //==========================================================

//   Future<void> deletePatrol({
//     required String id,
//     required String deletedBy,
//   }) async {
//     await _collection.doc(id).update({
//       "deleted": true,
//       "status": "deleted",
//       "deletedBy": deletedBy,
//       "deletedAt": FieldValue.serverTimestamp(),
//       "updatedBy": deletedBy,
//       "updatedAt": FieldValue.serverTimestamp(),
//     });
//   }

//   //==========================================================
//   // Change Patrol Status
//   //==========================================================

//   Future<void> changeStatus({
//     required String patrolId,
//     required String status,
//     required String updatedBy,
//   }) async {
//     await _collection.doc(patrolId).update({
//       "patrolStatus": status,
//       "updatedBy": updatedBy,
//       "updatedAt": FieldValue.serverTimestamp(),
//     });
//   }

//   //==========================================================
//   // Search
//   //==========================================================

//   Future<List<PatrolHistoryModel>> search(
//     String keyword,
//   ) async {
//     keyword = keyword.trim().toLowerCase();

//     final snapshot = await _collection
//         .where("deleted", isEqualTo: false)
//         .get();

//     return snapshot.docs
//         .map(
//           (e) => PatrolHistoryModel.fromMap(
//             e.data(),
//             e.id,
//           ),
//         )
//         .where(
//           (e) =>
//               e.officerName.toLowerCase().contains(keyword) ||
//               e.badgeId.toLowerCase().contains(keyword) ||
//               e.stationName.toLowerCase().contains(keyword) ||
//               e.checkpointName.toLowerCase().contains(keyword) ||
//               e.qrId.toLowerCase().contains(keyword),
//         )
//         .toList();
//   }

//   //==========================================================
//   // Total Records
//   //==========================================================

//   Future<int> count() async {
//     final result = await _collection
//         .where("deleted", isEqualTo: false)
//         .count()
//         .get();

//     return result.count ?? 0;
//   }

//   //==========================================================
//   // Today's Patrol Count
//   //==========================================================

//   Future<int> todayCount() async {
//     final now = DateTime.now();

//     final start = Timestamp.fromDate(
//       DateTime(now.year, now.month, now.day),
//     );

//     final end = Timestamp.fromDate(
//       DateTime(now.year, now.month, now.day, 23, 59, 59),
//     );

//     final result = await _collection
//         .where("deleted", isEqualTo: false)
//         .where("createdAt", isGreaterThanOrEqualTo: start)
//         .where("createdAt", isLessThanOrEqualTo: end)
//         .count()
//         .get();

//     return result.count ?? 0;
//   }

//   //==========================================================
//   // Patrols By Officer
//   //==========================================================

//   Future<List<PatrolHistoryModel>> officerPatrols(
//     String officerId,
//   ) async {
//     final snapshot = await _collection
//         .where("deleted", isEqualTo: false)
//         .where("officerId", isEqualTo: officerId)
//         .orderBy(
//           "createdAt",
//           descending: true,
//         )
//         .get();

//     return snapshot.docs
//         .map(
//           (e) => PatrolHistoryModel.fromMap(
//             e.data(),
//             e.id,
//           ),
//         )
//         .toList();
//   }

//   //==========================================================
//   // Patrols By Station
//   //==========================================================

//   Future<List<PatrolHistoryModel>> stationPatrols(
//     String stationId,
//   ) async {
//     final snapshot = await _collection
//         .where("deleted", isEqualTo: false)
//         .where("stationId", isEqualTo: stationId)
//         .orderBy(
//           "createdAt",
//           descending: true,
//         )
//         .get();

//     return snapshot.docs
//         .map(
//           (e) => PatrolHistoryModel.fromMap(
//             e.data(),
//             e.id,
//           ),
//         )
//         .toList();
//   }
// }