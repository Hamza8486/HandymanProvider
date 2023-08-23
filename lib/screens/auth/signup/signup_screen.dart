// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/Services/helper_function.dart';
import 'package:provider_app/screens/auth/login/controller/login_controller.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/Loader/loader.dart';
import 'package:provider_app/widgets/SnackBar/snack_bar.dart';
import 'package:provider_app/widgets/app_button.dart';
import 'package:provider_app/widgets/app_dimensions.dart';
import 'package:provider_app/widgets/app_text.dart';

import '../../../res/app_colors.dart';

class SignupScreen extends StatefulWidget {
   SignupScreen({Key? key,this.phone}) : super(key: key);
  var phone;
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final loginController = Get.put(LoginController());
  var _selectedValue;



  String ? token;
  void getToken() async{
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    HelperFunctions.saveInPreference("token", token!);
    print("token");
    print(token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    HelperFunctions.getFromPreference("tokem").then(
            (value){
          setState(() {
            token = value;
          });
          print(token);
          print(token);
          print(token);


        });
    setState(() {
      phoneController.text = widget.phone.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery
        .of(context)
        .size
        .width;
    var size = Get.size;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05, vertical: Get.height * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            Center(
              child: AppText(
                title: "Регистрация",
                color: AppColor.BLACK_COLOR,
                size: AppDimensions.FONT_SIZE_20,
                fontFamily: Weights.semi,
              ),
            ),
            SizedBox(
              height: size.height * 0.004,
            ),
            Center(
              child: AppText(
                title: "Заполните данные для завершения регистрации",
                color: AppColor.BLACK_COLOR,
                size: AppDimensions.FONT_SIZE_14,
                fontFamily: Weights.regular,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
       Expanded(child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           SizedBox(
             height: size.height * 0.07,
           ),
           Text(
             'Ваше имя',
             style: TextStyle(
               fontSize: 15.0,
               color: AppColors.blackColor,
               fontFamily: Weights.medium,
             ),
           ),
           TextFormField(
             controller: nameController,
             style: TextStyle(
               fontSize: AppDimensions.FONT_SIZE_15,
               color: AppColor.DARK_TEXT_COLOR,
               fontFamily: Weights.medium,

             ),
             keyboardType: TextInputType.name,
             textInputAction: TextInputAction.next,
             autofocus: true,
             decoration: const InputDecoration(
               prefixIcon: Padding(
                 padding: EdgeInsets.only(right: 16.0),
                 child: Icon(Icons.person,
                     color: AppColors.blueColor),
               ),
               contentPadding: EdgeInsets.only(top: 16.0, left: 0.0),
               prefixStyle: TextStyle(
                 fontSize: 15.0,
                 color: AppColors.blackColor,
               ),
               hintText: 'Имя',
               hintStyle: TextStyle(
                 fontSize: 15.0,
                 color: AppColors.greyColor,
               ),
             ),
           ),
             SizedBox(
               height: size.height * 0.03,
             ),
             Text(
               'Город',
               style: TextStyle(
                 fontSize: 15.0,
                 color: AppColors.blackColor,
                 fontFamily: Weights.medium,
               ),
             ),


             Obx(
               () {
                 return DropdownButtonFormField(
                     decoration: InputDecoration(
                       prefixIcon: Icon(Icons.pin_drop,color: AppColor.primaryColor,),


                       contentPadding: EdgeInsets.symmetric(
                           vertical: size.height * 0.018,
                           horizontal: 10),



                     ),
                     value: _selectedValue,
                     hint: Text(
                       'Выберите город',
                       style: TextStyle(
                         fontSize: AppDimensions.FONT_SIZE_15,
                         color: loginController.cityList.isEmpty?AppColor.DARK_TEXT_COLOR:AppColor.DARK_TEXT_COLOR,
                         fontFamily: Weights.regular,
                       ),
                     ),
                     isExpanded: true,
                     onChanged: ( value) {
                       setState(() {
                         _selectedValue = value!;
                       });
                     },

                     items:nameDataList(dataList: loginController.cityList)



                 );
               }
             ),
           SizedBox(
             height: size.height * 0.03,
           ),
           Text(
             'Номер телефона',
             style: TextStyle(
               fontSize: 15.0,
               color: AppColors.blackColor,
               fontFamily: Weights.medium,
             ),
           ),
           TextFormField(
             controller: phoneController,
             readOnly: true,
             style: TextStyle(
               fontSize: AppDimensions.FONT_SIZE_15,
               color: AppColor.DARK_TEXT_COLOR,
               fontFamily: Weights.medium,
             ),
             keyboardType: TextInputType.number,
             autofocus: true,
             textInputAction: TextInputAction.next,

             decoration: const InputDecoration(
               prefixIcon: Padding(
                 padding: EdgeInsets.only(right: 16.0),
                 child: Icon(Icons.phone_android_outlined,
                     color: AppColors.blueColor),
               ),
               contentPadding: EdgeInsets.only(top: 16.0, left: 0.0),
               prefixStyle: TextStyle(
                 fontSize: 15.0,
                 color: AppColors.blackColor,
               ),
             ),
           ),

           SizedBox(
             height: size.height * 0.07,
           ),
           AppButton(
             buttonWidth: size.width,

             buttonRadius: BorderRadius.circular(10),
             fontFamily: Weights.semi,
             textSize: size.height * 0.02,
             buttonName: 'Продолжить',
             buttonColor: AppColor.primaryColor,

             textColor: AppColor.WHITE_COLOR,
             onTap: () {
               if (validate()) {
                 print(_selectedValue.toString());
                 appLoader(context,AppColor.primaryColor);
                 ApiManger.registerResponse(context: context,
                     phone: widget.phone,
                     name: nameController.text,

                     city: _selectedValue.toString(),
                     token: token

                 );
               }
             },

           ),

         ],),
       ))
          ],
        ),
      ),
    );
  }
  List<DropdownMenuItem<int>> nameDataList({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: AppText(
            title: dataList[i].name,
            size: AppDimensions.FONT_SIZE_15,
            color: AppColor.DARK_TEXT_COLOR,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          )));
    }
    return outputList;
  }
  bool validate() {

    if (nameController.text.isEmpty) {
      showErrorToast("Full Name required");


      return false;
    }
    if (_selectedValue == null) {
      showErrorToast("Select City");


      return false;
    }



    return true;
  }
}
