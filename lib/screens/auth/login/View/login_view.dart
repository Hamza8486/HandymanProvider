// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/screens/BottomView/Profile/components/service_rule.dart';
import 'package:provider_app/screens/auth/OtpScreen/otp_screen.dart';
import 'package:provider_app/screens/auth/login/components/code.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/Paddings/padding.dart';
import 'package:provider_app/widgets/SnackBar/snack_bar.dart';
import 'package:provider_app/widgets/app_button.dart';
import 'package:provider_app/widgets/app_dimensions.dart';
import 'package:provider_app/widgets/app_text.dart';


import 'package:flutter/services.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  late String phoneNumber;
  String value = '+996';

  TextEditingController textEditingController1 = TextEditingController();

  String _comingSms = 'Unknown';





  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.symetric,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * .38,
              ),

              SizedBox(
                height: size.height * .003,
              ),
              AppText(
                title: 'Войти в аккаунт',
                size: AppDimensions.FONT_SIZE_18,
                color: AppColor.DARK_TEXT_COLOR,
                fontFamily: Weights.medium,
                fontWeight: FontWeight.w600,
              ),

              SizedBox(
                height: size.height * .04,
              ),

              SizedBox(
                height: size.height * .01,
              ),
              CountryCodeWid(
                onPickCode: (code) {
                  setState(() {
                    value = code.toString();
                  });
                },
                phoneController: phoneController,
              ),
              SizedBox(
                height: size.height * .02,
              ),
              GestureDetector(
                onTap: (){
                  Get.to(ServiceRule(),
                  transition: Transition.rightToLeft
                  );
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        //title: 'Login as Guest',
                        title: 'Нажимая "Продолжить" вы соглашаетесь с ',
                        fontWeight: FontWeight.w700,
                        size:  AppDimensions.FONT_SIZE_11,
                        color: Colors.grey,

                        fontFamily:"Poppins",
                      ),
                      AppText(
                        //title: 'Login as Guest',
                        title: 'правилами сервиса',
                        fontWeight: FontWeight.w700,
                        size:  AppDimensions.FONT_SIZE_11,
                        color: AppColor.primaryColor,
                        fontFamily: "Poppins",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .04,
              ),

              isLoading == false?
              AppButton(
                buttonWidth: size.width,
                buttonHeight: size.height*0.06,

                buttonRadius: BorderRadius.circular(10),
                fontFamily: Weights.semi,
                textSize: size.height * 0.02,
                buttonName: "Продолжить",
                buttonColor: AppColor.primaryColor,

                textColor: AppColor.WHITE_COLOR,
                onTap: () {
                  if (validate()) {
                    String number = value + phoneController.text;

                    Get.to(OtpScreen(
                      phone:value + phoneController.text ,
                    ));
                    successToast("Код отправлен на мобильный номер");
                  }
                },

              ): Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColor.primaryColor.withOpacity(0.4),
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppColor.primaryColor ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    phoneNumber = phoneController.text;
    if (phoneNumber.isEmpty) {
      showErrorToast("Требуется номер телефона");


      return false;
    }
    return true;
  }


}
