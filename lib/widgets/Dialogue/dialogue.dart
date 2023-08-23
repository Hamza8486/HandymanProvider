import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/app_button.dart';



showAlertDialog(
    {required BuildContext context,
    required String text,
    required VoidCallback yesOnTap,
    bool isBoth = true}) {
  // set up the buttons
  Widget cancelButton = AppButton(
      buttonName: "ok",
      buttonWidth: 100,
      buttonHeight: 40,
      buttonRadius: BorderRadius.circular(10),
      buttonColor: AppColor.primaryColor,
      textColor: Colors.white,
      onTap: yesOnTap);
  Widget continueButton = AppButton(
      buttonName: "No",
      buttonWidth: 100,
      buttonHeight: 40,
      buttonRadius: BorderRadius.circular(10),
      buttonColor: Colors.transparent,
      textColor: AppColor.primaryColor,
      borderColor: AppColor.primaryColor,
      onTap: () {
        Get.back();
      });
  AlertDialog alert = AlertDialog(
    content: Text(text,style: TextStyle(fontFamily: Weights.medium),),
    actions: [
      cancelButton,
      isBoth ? continueButton : Container(),
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
