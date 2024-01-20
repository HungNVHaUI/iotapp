import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:testapp/src/features/authentication/models/user_model.dart';
import 'package:testapp/src/features/core/controllers/profile_controller.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  // Biến để kiểm soát việc hiển thị/ẩn mật khẩu
  bool _obscureText = true;

   void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tEditProfile,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),

          // Lấy dữ liệu người dùng từ Firestore
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;
                  DateTime now = DateTime.now();
                  String joinedAt = user.joinedAt.toString();

                  // Controllers để quản lý dữ liệu nhập từ người dùng
                  final email = TextEditingController(text: user.email);
                  final fullName = TextEditingController(text: user.fullName);
                  final phoneNo = TextEditingController(text: user.phoneNo);
                  final password = TextEditingController(text: user.password);

                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: const Image(
                                image: AssetImage(tProfileImage),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: tPrimaryColor,
                              ),
                              child: const Icon(
                                LineAwesomeIcons.camera,
                                size: 20.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50,),
                      Form(
                        
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fullName,
                              decoration: const InputDecoration(
                                labelText: tFullName,
                                prefixIcon: Icon(Icons.person_outline_rounded),
                              ),
                            ),
                            const SizedBox(height: tFormHeight - 20.0),
                            TextFormField(
                              controller: email,
                              decoration: const InputDecoration(
                                labelText: tEmail,
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            const SizedBox(height: tFormHeight - 20.0),
                            TextFormField(
                              controller: phoneNo,
                              decoration: const InputDecoration(
                                labelText: tPhoneNo,
                                prefixIcon: Icon(Icons.phone_android),
                              ),
                            ),
                            const SizedBox(height: tFormHeight - 20.0),
                            TextFormField(
                              controller: password,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                labelText: tPassword,
                                prefixIcon: const Icon(Icons.fingerprint),
                                // suffixIcon: GestureDetector(
                                //   onTap: _togglePasswordVisibility,
                                //   child: Icon(
                                //     _obscureText
                                //         ? Icons.visibility
                                //         : Icons.visibility_off,
                                //   ),
                                // ),
                                suffixIcon: GestureDetector(
                                  onTap: _togglePasswordVisibility,
                                  child: Icon(
                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: tFormHeight),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Tạo đối tượng UserModel mới
                                  final userChange = UserModel(
                                    id: user.id,
                                    email: email.text.trim(),
                                    fullName: fullName.text.trim(),
                                    phoneNo: phoneNo.text.trim(),
                                    password: password.text.trim(),
                                    joinedAt: user.joinedAt,
                                    devices: user.devices,
                                  );

                                  // Gọi hàm cập nhật dữ liệu
                                  await controller.updateRecord(userChange);
                                },
                                child: const Text(tEditProfile),
                              ),
                            ),
                            const SizedBox(height: tFormHeight),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Hiển thị ngày tham gia
                                Text.rich(
                                  TextSpan(
                                    text: tJoined,
                                    style: TextStyle(fontSize: 12),
                                    children: [
                                      TextSpan(
                                        text: joinedAt,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Nút để xử lý việc xóa tài khoản
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Colors.redAccent.withOpacity(0.1),
                                    elevation: 0,
                                    foregroundColor: Colors.red,
                                    shape: const StadiumBorder(),
                                    side: BorderSide.none,
                                  ),
                                  child: const Text(tDelete),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}


