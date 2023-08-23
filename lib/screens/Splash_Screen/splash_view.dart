// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/Services/helper_function.dart';
import 'package:provider_app/screens/Home/view/home_view.dart';
import 'package:provider_app/screens/auth/login/View/login_view.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';


class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() =>
      _SplashScreenViewState();
}

class _SplashScreenViewState
    extends State<SplashScreenView> {
  String userID="";


  @override
  void initState() {
    super.initState();

    HelperFunctions.getFromPreference("id").then(
            (value){
          setState(() {
            userID = value;
            print("This is userId ${userID.toString()}");
          });
          moveToNext();
        });



  }
  void moveToNext() {
    Timer(Duration(seconds: 3), () {
      if (userID != "") {
        Get.off(
          PersisNavBar(currentIndex: 0),

        );
      }
      else {
        Get.offAll(
          LoginScreen(),

        );
      }
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.WHITE_COLOR,
      body: Column(
        children: [
          SizedBox(height: Get.height*0.47,),
          Center(
            child: Center(child: Image.asset("assets/images/splash.png",height: Get.height*0.07,)),
          ),
        ],
      ),
    );
  }
}
