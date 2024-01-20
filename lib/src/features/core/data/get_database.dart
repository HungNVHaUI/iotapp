import 'dart:async';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';



void updateDatabase(String collections,String doc ) {
  final databaseReference = FirebaseDatabase.instance.ref();
  final random = Random();
  Timer.periodic(Duration(seconds: 3), (timer) {
    final randomValue = random.nextInt(10) ;
    databaseReference.child(collections).child(doc).set(randomValue);
  });
}