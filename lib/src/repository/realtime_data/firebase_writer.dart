import 'package:firebase_database/firebase_database.dart';

class FirebaseWriter {
  final DatabaseReference _databaseReference;

  FirebaseWriter(this._databaseReference);

  Future<void> writeToSS(String ssKey, String value) async {
    await _databaseReference.child(ssKey).set(value);
  }
}
