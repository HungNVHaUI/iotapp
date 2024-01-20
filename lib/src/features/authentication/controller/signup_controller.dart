import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/src/features/authentication/models/user_model.dart';
import 'package:testapp/src/repository/user_repository/user_repository.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';
import '../../screens/forget_password/forget_password_otp/otp_screen.dart';
class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();


  final email =  TextEditingController();
  final password =  TextEditingController();
  final fullName =  TextEditingController();
  final phoneNo =  TextEditingController();

  final userRepo = Get.put(UserRepository());


  void registerUser(String email, String password){
    String? error = AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password) as String?;
    if(error != null){
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }


  Future<void> createUserMail(UserModel user) async {
    await userRepo.createUser(user);

    // print("xxxxxxxxx" + user.phoneNo);
    registerUser(user.email,user.password);
  }
  Future<void> createUserPhone(UserModel user) async {
    await userRepo.createUser(user);

    // print("xxxxxxxxx" + user.phoneNo);
    phoneAuthentication(user.phoneNo);
    Get.to(() => const OTPScreen());
  }

  void phoneAuthentication(String phoneNo){
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}