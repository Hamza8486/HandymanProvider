import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {

  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxBool status = false.obs;

  void toggle(bool val) {
    status.value = val;
  }

}