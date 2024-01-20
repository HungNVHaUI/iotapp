import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../../features/core/screens/dashboard/control_panel/control_add_devices.dart';
import '../../features/models/device_model.dart';

class UpdateDevices extends StatefulWidget {
  @override
  _UpdateDevicesState createState() => _UpdateDevicesState();
}

class _UpdateDevicesState extends State<UpdateDevices> {
  final DeviceController _deviceController = Get.find<DeviceController>();

  @override
  void initState() {
    super.initState();
  }

  void _updateDevice(DeviceModel updatedDevice) async {
    try {
      final userEmail = FirebaseAuth.instance.currentUser?.email;

      if (userEmail != null) {
        final userRef = FirebaseFirestore.instance.collection('Users');
        final userSnapshot =
        await userRef.where('Email', isEqualTo: userEmail).limit(1).get();

        if (userSnapshot.docs.isNotEmpty) {
          final userDoc = userSnapshot.docs.first;
          final devices = List<String>.from(userDoc.data()?['Devices'] ?? []);

          // Tìm và cập nhật thông tin của thiết bị trong danh sách devices
          for (int i = 0; i < devices.length; i++) {
            final decodedDevice = jsonDecode(devices[i]);
            final existingDevice = DeviceModel.fromJson(decodedDevice);
            if (existingDevice.name == updatedDevice.name) {
              devices[i] = json.encode(updatedDevice.toJson());
              await userDoc.reference.update({'Devices': devices});

              // Cập nhật trạng thái của thiết bị trong danh sách hiện tại
              if (i < _deviceController.devices.length) {
                _deviceController.devices[i] = updatedDevice;
              }

              break;
            }
          }
        }
      }
    } catch (error) {
      print('Error updating device: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    // Không có giao diện người dùng ở đây
    return Container();
  }
}
