// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';

class AppDimensions {
  static const double FONT_SIZE_10 = 10.0;
  static const double FONT_SIZE_11 = 11.0;
  static const double FONT_SIZE_12 = 12.0;
  static const double FONT_SIZE_13 = 13.0;
  static const double FONT_SIZE_14 = 14.0;
  static const double FONT_SIZE_15 = 15.0;
  static const double FONT_SIZE_16 = 16.0;
  static const double FONT_SIZE_17 = 17.0;
  static const double FONT_SIZE_18 = 18.0;
  static const double FONT_SIZE_19 = 19.0;
  static const double FONT_SIZE_20 = 20.0;
  static const double FONT_SIZE_21 = 21.0;
  static const double FONT_SIZE_22 = 22.0;
  static const double FONT_SIZE_24 = 24.0;
  static const double FONT_SIZE_26 = 26.0;
  static const double FONT_SIZE_30 = 30.0;
}

Future<bool> showExitPopup(context ,index ,onChange) async{
  if(index==0){
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to exit?",style: TextStyle(color: AppColor.primaryColor,
                      fontFamily: Weights.medium
                  ),),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: const Text("No", style: TextStyle(color: Colors.black)),
                          )),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async{
                            // Get.back();
                            // exit(0);
                            // // await  MoveToBackground.moveTaskToBack();


                            // await HelperFunctions().clearPrefs();

                            // await  ApiManger.logoutResp(token: Get.put(HomeController()).token);
                            // Get.put(HomeController()).clearSave();
                            // Get.offAll(LoginView());



                          },
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.primaryColor),

                          child:  Text("Yes",style: TextStyle(color: AppColor.WHITE_COLOR),),
                        ),
                      ),


                    ],
                  )
                ],
              ),
            ),
          );
        });}
  else{
    onChange(0);
    return false;
  }
}
class AppSizes {
  static double size_10 = Get.height / 81.2;
  static double size_11 = Get.height / 73.8;
  static double size_12 = Get.height / 67.7;
  static double size_13 = Get.height / 62.5;
  static double size_14 = Get.height / 58;
  static double size_15 = Get.height / 54.1;
  static double size_16 = Get.height / 50.8;
  static double size_17 = Get.height / 47.8;
  static double size_18 = Get.height / 45.1;
  static double size_19 = Get.height / 42.7;
  static double size_20 = Get.height / 40.6;
  static double size_21 = Get.height / 38.7;
  static double size_22 = Get.height / 36.9;
  static double size_23 = Get.height / 35.3;
  static double size_24 = Get.height / 33.8;
  static double size_25 = Get.height / 32.5;
  static double size_26 = Get.height / 31.2;
  static double size_27 = Get.height / 30.1;
  static double size_28 = Get.height / 29;
  static double size_29 = Get.height / 28;
  static double size_30 = Get.height / 27.1;
}