import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../../models/device_model.dart';
import '../control_panel/control_add_devices.dart';

class AddDevices extends StatefulWidget {
  @override
  _AddDevicesState createState() => _AddDevicesState();

  _AddDevicesState get addDevicesState => _AddDevicesState();
}

class _AddDevicesState extends State<AddDevices> {
  // Sử dụng Get để truy cập Controller
  final DeviceController _deviceController = Get.find<DeviceController>();

  // Controller cho TextField
  final TextEditingController _textEditingController = TextEditingController();

  // Biến lưu trữ icon được chọn
  late String? selectedIcon;

  // Danh sách các icon
  List<Map<String, dynamic>> iconList = [
    {'label': 'TV', 'value': 'assets/svg/tv.svg'},
    {'label': 'Drop', 'value': 'assets/svg/drop.svg'},
    {'label': 'Speaker', 'value': 'assets/svg/speaker.svg'},
    {'label': 'AC', 'value': 'assets/svg/ac.svg'},
  ];

  @override
  void initState() {
    super.initState();
    selectedIcon = iconList.first['value']; // Thiết lập icon mặc định
    _addDeviceToCurrentUser();
  }

  // Hàm để lấy danh sách thiết bị từ Firestore
  void _addDeviceToCurrentUser() async {
    try {
      final userEmail = FirebaseAuth.instance.currentUser?.email;

      if (userEmail != null) {
        final userRef = FirebaseFirestore.instance.collection('Users');
        final userSnapshot =
            await userRef.where('Email', isEqualTo: userEmail).limit(1).get();

        if (userSnapshot.docs.isNotEmpty) {
          final userDoc = userSnapshot.docs.first;
          final devices = List<String>.from(userDoc.data()['Devices']);

          // Cập nhật danh sách thiết bị trong Controller
          _deviceController.devices.value = devices
              .map((device) => DeviceModel.fromJson(json.decode(device)))
              .toList();
        }
      }
    } catch (error) {
      print('Error retrieving devices: $error');
    }
  }

// Hàm để thêm thiết bị mới vào Firestore
void _addDevice(DeviceModel newDevice) async {
  try {
    final userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userEmail != null) {
      final userRef = FirebaseFirestore.instance.collection('Users');
      final userSnapshot =
      await userRef.where('Email', isEqualTo: userEmail).limit(1).get();

      if (userSnapshot.docs.isNotEmpty) {
        final userDoc = userSnapshot.docs.first;
          final devices = List<String>.from(userDoc.data()['Devices']);

          // Thêm mã hóa thiết bị mới vào danh sách
          devices.add(json.encode(newDevice.toJson()));

          // Cập nhật danh sách thiết bị trong Firestore
          await userDoc.reference.update({'Devices': devices});

          // Cập nhật danh sách thiết bị trong Controller
          _deviceController.devices.add(newDevice);
        }
      }
    } catch (error) {
      print('Error adding device: $error');
    }
  }

  // Hàm để thêm thiết bị vào Firebase Realtime Database
  Future<void> addDeviceToFirebase(DeviceModel device) async {
    try {
      DatabaseReference deviceRef = FirebaseDatabase.instance
          .reference()
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(device.name);

      // Lưu tất cả thông tin của thiết bị
      await deviceRef.set(device.toJson());
    } catch (error) {
      print('Error writing device to Firebase: $error');
    }
  }

  // Hàm để xóa thiết bị khỏi Firestore
  Future<void> removeDeviceToFirebase(DeviceModel device) async {
    try {
      String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      DatabaseReference deviceRef = FirebaseDatabase.instance
          .reference()
          .child(currentUserUid)
          .child(device.name);
      await deviceRef.remove();
    } catch (error) {
      print('Error removing device from Firebase: $error');
    }
  }

  // Hàm để xóa thiết bị khỏi danh sách
  void _removeDevice(DeviceModel device) async {
    try {
      final userEmail = FirebaseAuth.instance.currentUser?.email;

      if (userEmail != null) {
        final userRef = FirebaseFirestore.instance.collection('Users');
        final userSnapshot =
        await userRef.where('Email', isEqualTo: userEmail).limit(1).get();

        if (userSnapshot.docs.isNotEmpty) {
          final userDoc = userSnapshot.docs.first;
          final devices = List<String>.from(userDoc.data()['Devices']);

          // Xóa mã hóa thiết bị khỏi danh sách
          devices.remove(json.encode(device.toJson()));

          // Cập nhật danh sách thiết bị trong Firestore
          await userDoc.reference.update({'Devices': devices});

          // Cập nhật danh sách thiết bị trong Controller
          _deviceController.devices.remove(device);
        }
      }
    } catch (error) {
      print('Error removing device: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(
          tDevicesServiceHeading,
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              //const SizedBox(height: 20),
              // TextField để nhập tên thiết bị
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter device name',
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  const Text('Select Icon'),
                  const SizedBox(width: 10),
                  // PopupMenuButton để chọn icon
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      setState(() {
                        selectedIcon = value;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return iconList.map((Map<String, dynamic> icon) {
                        return PopupMenuItem<String>(
                          value: icon['value'],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(icon['label']),
                              const SizedBox(width: 30),
                              SvgPicture.asset(
                                icon['value'],
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        );
                      }).toList();
                    },
                  ),
                  const SizedBox(width: 10),
                  // Hiển thị icon được chọn
                  if (selectedIcon != null) ...[
                    Text(
                      iconList.firstWhere(
                          (icon) => icon['value'] == selectedIcon)['label'],
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      selectedIcon!,
                      width: 24,
                      height: 24,
                    ),
                  ] else ...[
                    // Hiển thị icon mặc định nếu không có icon được chọn
                    Text(iconList.first['label']),
                    const SizedBox(width: 20),
                    SvgPicture.asset(
                      iconList.first['value'],
                      width: 24,
                      height: 24,
                    ),
                  ],
                  const SizedBox(width: 70),
                  // Nút để thêm thiết bị mới
                  ElevatedButton(
                    onPressed: () async {
                      final deviceName = _textEditingController.text.trim();

                      if (deviceName.isEmpty) {
                        return;
                      }

                      // Kiểm tra xem tên thiết bị đã tồn tại trong danh sách chưa
                      if (_deviceController.devices
                          .any((device) => device.name == deviceName)) {
                        // Hiển thị SnackBar thông báo lỗi
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Device with the same name already exists.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      // Nếu không có thiết bị trùng tên, tiếp tục thêm thiết bị mới
                      final newDevice = DeviceModel(
                        name: deviceName,
                        isActive: true,
                        color: "#7739ff",
                        icon: selectedIcon!,
                      );

                      _addDevice(newDevice);
                      addDeviceToFirebase(newDevice);
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Text(
                'Device List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Danh sách thiết bị
              Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  itemCount: _deviceController.devices.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final device = _deviceController.devices[index];

                    return ListTile(
                      // Hiển thị icon của thiết bị
                      leading: SizedBox(
                        width: 48,
                        height: 48,
                        child: SvgPicture.asset(
                          device.icon,
                          width: 24,
                          height: 24,
                        ),
                      ),
                      // Hiển thị tên thiết bị
                      title: Text(device.name),
                      // Nút để xóa thiết bị
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Gọi hàm xóa thiết bị
                          _removeDevice(device);
                          // Gọi hàm xóa thiết bị khỏi Firebase
                          removeDeviceToFirebase(device);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
