import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataProvider {
  static final FirebaseDataProvider instance = FirebaseDataProvider._internal();

  FirebaseDataProvider._internal();

  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getUsersStream() {
    return usersCollection.snapshots();
  }
}
