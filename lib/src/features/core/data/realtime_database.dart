import 'package:firebase_database/firebase_database.dart';

void listeningToDatabase(String node, void Function(String) callback) {
  final databaseReference = FirebaseDatabase.instance.ref().child(node);
  databaseReference.onValue.listen((event) {
    String newData = event.snapshot.value.toString();
    callback(newData);
  });
}
