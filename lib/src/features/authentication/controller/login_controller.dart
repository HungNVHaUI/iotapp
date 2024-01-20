import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';
class LoginController extends GetxController{
  static LoginController get instance => Get.find();


  final email =  TextEditingController();
  final password =  TextEditingController();
  final fullName =  TextEditingController();
  final phoneNo =  TextEditingController();


  void loginUser(String email, String password){
    String? error = AuthenticationRepository.instance.loginUserWithEmailAndPassword(email, password) as String?;
    if(error != null){
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }


  void phoneAuthentication(String phoneNo){
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}