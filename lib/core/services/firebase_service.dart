
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  FirebaseService._();

  static final firestore = FirebaseFirestore.instance;

  static final storage = FirebaseStorage.instance;
}