import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../models/device_model.dart';


class DeviceController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  RxList<DeviceModel> devices = <DeviceModel>[].obs;

  void addDevice(DeviceModel device) {
    _db
        .collection("Devices")
        .add(device.toJson())
        .then((_) {
      print("Device added successfully!");
      devices.add(device); // Thêm thiết bị vào danh sách
    })
        .catchError((error) {
      print("Error adding device: $error");
    });
  }
}



