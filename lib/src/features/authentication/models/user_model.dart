import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? joinedAt;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final List<String> devices;

  const UserModel({
    this.id,
    required this.joinedAt,
    required this.email,
    required this.fullName,
    required this.phoneNo,
    required this.password,
    required this.devices,
  });

  Map<String, dynamic> toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "JoinedAt": joinedAt,
      "Devices": devices,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data["Email"],
      fullName: data["FullName"],
      phoneNo: data["Phone"],
      password: data["Password"],
      joinedAt: data["JoinedAt"],
      devices: List<String>.from(data["Devices"]),
    );
  }


}
