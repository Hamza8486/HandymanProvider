import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/app_text.dart';

Widget backBtn({required BuildContext context, required VoidCallback onTap}) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: size.height * 0.05,
      width: size.width * 0.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.LIGHT_GREY_COLOR.withOpacity(0.5),
          )),
      child: Center(
          child: Padding(
        padding: EdgeInsets.only(left: 6),
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColor.DARK_TEXT_COLOR,
          size: 16,
        ),
      )),
    ),
  );
}

Widget loader({double?height}){
  return Column(
    children: [
      SizedBox(
        height: height??Get.height * 0.35,
      ),
      Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.black26,
            valueColor: AlwaysStoppedAnimation<Color>(
                AppColor.primaryColor //<-- SEE HERE

            ),
          )),
    ],
  );
}
Widget noData({double?height}){
  return Column(children: [
    SizedBox(height: height??Get.height * 0.3),
    SvgPicture.asset(
      "assets/images/notfound.svg",
      height: Get.height * 0.05,
    ),
    SizedBox(height: Get.height * 0.015),
    Center(
        child: AppText(
          title: "No Record Found",
          size: Get.height * 0.014,
          color: AppColor.DARK_TEXT_COLOR,
          fontFamily: Weights.semi,
        )),
    SizedBox(height: Get.height * 0.01),
  ]);
}