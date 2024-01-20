import 'package:firebase_database/firebase_database.dart';

class FirebaseListener {
  final DatabaseReference _databaseReference;

  FirebaseListener(this._databaseReference);

  void listenToSS(String ssKey, Function(String) callback) {
    _databaseReference.child('$ssKey').onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      String value = snapshot.value?.toString() ?? '';
      callback(value);
    });
  }
}
