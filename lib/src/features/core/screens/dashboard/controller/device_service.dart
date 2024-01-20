import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../models/device_model.dart';
import '../control_panel/control_add_devices.dart';


class DeviceService {

  static Future<List<DeviceModel>> fetchDevices(List<DeviceModel> devices) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userEmail = user?.email;

      if (userEmail != null) {
        final userRef = FirebaseFirestore.instance.collection('Users');
        final userSnapshot =
        await userRef.where('Email', isEqualTo: userEmail).limit(1).get();

        if (userSnapshot.docs.isNotEmpty) {
          final userDoc = userSnapshot.docs.first;
          List<dynamic> devicesData = userDoc.data()['Devices'];
          devices.clear();
          devicesData.forEach((deviceData) {
            try {
              final decodedData = jsonDecode(deviceData);
              if (decodedData is Map<String, dynamic>) {
                String? name = decodedData['name'] as String?;
                String? color = decodedData['color'] as String?;
                bool? isActive = decodedData['isActive'] as bool?;
                String? icon = decodedData['icon'] as String?;

                final newDevice = DeviceModel(
                  name: name ?? '',
                  isActive: isActive ?? false,
                  color: color ?? '',
                  icon: icon ?? '',
                );
                devices.add(newDevice);
              }
            } catch (e) {
              print('Error decoding device data: $e');
            }
          });
        }
      }
    } catch (error) {
      print('Error fetching devices: $error');
    }

    return devices;
  }

  static Future<List<DeviceModel>> UserListDiveces() async {
    final DeviceController _deviceController = Get.find<DeviceController>();
    try {
      final userEmail = FirebaseAuth.instance.currentUser?.email;

      if (userEmail != null) {
        final userRef = FirebaseFirestore.instance.collection('Users');
        final userSnapshot = await userRef.where('Email', isEqualTo: userEmail).limit(1).get();

        if (userSnapshot.docs.isNotEmpty) {
          final userDoc = userSnapshot.docs.first;
          final devicesData = userDoc.data()['Devices'] as List<dynamic>;

          final devices = devicesData
              .map((device) => DeviceModel.fromJson(json.decode(device.toString())))
              .toList();

          _deviceController.devices.value = devices; // Cập nhật danh sách thiết bị trong Controller

          return devices;
        }
      }

      return [];
    } catch (error) {
      print('Error retrieving devices: $error');
      return [];
    }
  }
  Future<void> updateDevice(DeviceModel updatedDevice) async {
    try {
      final userEmail = FirebaseAuth.instance.currentUser?.email;

      if (userEmail != null) {
        final userRef = FirebaseFirestore.instance.collection('Users');
        final userSnapshot =
        await userRef.where('Email', isEqualTo: userEmail).limit(1).get();

        if (userSnapshot.docs.isNotEmpty) {
          final userDoc = userSnapshot.docs.first;
          final devices = List<String>.from(userDoc.data()['Devices']);

          // Tìm và cập nhật thiết bị trong danh sách
          for (int i = 0; i < devices.length; i++) {
            final deviceJson = json.decode(devices[i]);
            final existingDevice = DeviceModel.fromJson(deviceJson);

            if (existingDevice.name == updatedDevice.name) {
              devices[i] = json.encode(updatedDevice.toJson());
              break; // Bạn có thể break vì bạn đã tìm thấy và cập nhật thiết bị
            }
          }

          // Cập nhật danh sách thiết bị trong Firestore
          await userDoc.reference.update({'Devices': devices});

          // Cập nhật danh sách thiết bị cục bộ trong _deviceController (nếu cần)
          // _deviceController.devices.add(updatedDevice); // Nếu muốn thêm thiết bị mới thay vì cập nhật
        }
      }
    } catch (error) {
      print('Error updating device: $error');
    }
  }

}

