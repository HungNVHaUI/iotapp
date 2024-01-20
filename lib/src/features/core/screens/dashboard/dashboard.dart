import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:testapp/src/constants/sizes.dart';
import 'package:testapp/src/constants/text_strings.dart';
import 'package:testapp/src/features/core/screens/dashboard/widgets/add_devices.dart';
import 'package:testapp/src/features/core/screens/dashboard/widgets/devices.dart';
import 'package:testapp/src/features/core/utils/string_to_color.dart';
import '../../../../repository/realtime_data/firebase_listener.dart';
import '../../../../repository/realtime_data/firebase_writer.dart';
import '../../../models/device_model.dart';
import '../../../screens/home/dash_board_app_bar.dart';
import 'controller/device_service.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  // Biến để lưu trữ giá trị ss01 và ss02 từ Firebase
  String ss01 = '';
  String ss02 = '';

  // Danh sách các thiết bị
  List<DeviceModel> devices = [];

  // DatabaseReference để thực hiện đọc/ghi data từ Firebase Realtime Database
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  // FirebaseListener để lắng nghe sự thay đổi từ Firebase Realtime Database
  late FirebaseListener _firebaseListener;

  // FirebaseWriter để ghi data lên Firebase Realtime Database
  late FirebaseWriter _firebaseWriter;

  // Thông tin về người dùng hiện tại
  late User _currentUser;

  // Service quản lý thiết bị
  DeviceService deviceService = DeviceService();

  // Instance của AddDevices để gọi hàm addDeviceToFirebase
  final AddDevices _addDevicesInstance = AddDevices();

  // Hàm khởi tạo
  @override
  void initState() {
    super.initState();
    _fetchDevices();
    // Khởi tạo biến và cấu hình Firebase
    _initializeVariables();
    // Thiết lập lắng nghe sự kiện từ Firebase
    _setupFirebaseListeners();
    // Lấy danh sách thiết bị từ Firebase
    _fetchDevices();


    // _firebaseListener.listenToSS('AI1/ss01', (value) {        // đọc data từ firebase
    //   setState(() {
    //     ss01 = value;
    //   });
    // });
  }

  // Hàm khởi tạo biến
  void _initializeVariables() {
    _firebaseListener = FirebaseListener(_databaseReference);
    _firebaseWriter = FirebaseWriter(_databaseReference);
    _currentUser = FirebaseAuth.instance.currentUser!;
  }

  // Hàm thiết lập lắng nghe sự kiện từ Firebase
  void _setupFirebaseListeners() {
    _firebaseListener.listenToSS('AI1/ss01', (value) => _onValueChanged(value, 'ss01'));
    _firebaseListener.listenToSS('AI1/ss02', (value) => _onValueChanged(value, 'ss02'));
  }

// Hàm xử lý sự kiện khi giá trị thay đổi
  void _onValueChanged(String value, String ssKey) {
    setState(() {
      if (ssKey == 'ss01') {
        ss01 = value;
      } else if (ssKey == 'ss02') {
        ss02 = value;
      }
      // Có thể thêm xử lý cho các trường hợp khác nếu cần
    });
  }

  // Hàm lấy danh sách thiết bị từ Firebase
  Future<void> _fetchDevices() async {
    devices = await DeviceService.fetchDevices(devices);
    setState(() {});
  }

  // Hàm xử lý sự kiện khi trạng thái của thiết bị thay đổi
  void _deviceStatusChanged(DeviceModel device) {
    setState(() {
      device.isActive = !device.isActive;
    });
    // Ghi trạng thái của thiết bị lên Firebase
    _writeDeviceStatusToFirebase(device);
    // Gọi hàm ghi trạng thái của thiết bị từ AddDevices
    //_addDevicesInstance.addDevicesState.addDeviceToFirebase(device);
    // Cập nhật trạng thái của thiết bị trong danh sách
    deviceService.updateDevice(device);
  }

  // Hàm ghi trạng thái của thiết bị lên Firebase
  Future<void> _writeDeviceStatusToFirebase(DeviceModel device) async {
    try {
      DatabaseReference deviceStatusRef =
      FirebaseDatabase.instance.reference().child(_currentUser.uid).child(device.name).child('isActive');
      await deviceStatusRef.set(device.isActive);
    } catch (error) {
      print('Error writing device status to Firebase: $error');
    }
  }

  // Hàm ghi dữ liệu lên Firebase
  Future<void> _writeData(String ssKey, String value) async {
    try {
      await _firebaseWriter.writeToSS(ssKey, value);
    } catch (error) {
      print('Error writing data: $error');
    }
  }

  // Xây dựng phần giao diện của header
  Widget _buildHeader() {
    final txtTheme = Theme.of(context).textTheme;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                tDashboardTitle,
                style: txtTheme.bodyText2,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Get.to(AddDevices());
              },
            ),
          ],
        ),
        const SizedBox(height: tFormHeight - 20.0),
        // Hiển thị giá trị của ss01
        _buildSSValueRow('Giá trị ss01 là:', ss01),
        // Hiển thị giá trị của ss02
        _buildSSValueRow('Giá trị ss02 là:', ss02),
        const SizedBox(height: tFormHeight - 20.0),
      ],
    );
  }

  // Xây dựng dòng hiển thị giá trị của ss
  Widget _buildSSValueRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$label $value',
        ),
      ],
    );
  }

  // Xây dựng lưới thiết bị
  Widget _buildDeviceGrid() {
    return Expanded(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        childAspectRatio: 3 / 3.5,
        children: devices.map((device) {
          return Devices(
            name: device.name,
            svg: device.icon,
            color: device.color.toColor(),
            isActive: device.isActive,
            onChanged: (val) {
              _deviceStatusChanged(device);
            },
          );
        }).toList(),
      ),
    );
  }
  // Xây dựng giao diện chính của trang DashBoard
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DashBoardAppBar(isDark: MediaQuery.of(context).platformBrightness == Brightness.dark),
        body: RefreshIndicator(
          onRefresh: _fetchDevices,
          child: Container(
            padding: const EdgeInsets.all(tDashboardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildDeviceGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

