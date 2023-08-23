import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/res/app_images.dart';
import 'package:provider_app/screens/account/controller/account_controller.dart';
import 'package:provider_app/widgets/custom_button.dart';



class EditAccountProfileScreen extends StatelessWidget {
  EditAccountProfileScreen({Key? key}) : super(key: key);

  final  accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: AppBar(
        leading: const BackButton(
          color: AppColors.blackColor,
        ),
        elevation: 0.0,
        backgroundColor: AppColors.backColor,
        titleSpacing: 0.0,
        title: const Text('Изменить профиль',
        style: TextStyle(
          fontSize: 20.0,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w800,
        ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Bounceable(
                onTap: (){},
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage:  AssetImage(AppImages.personImage),
                      radius: 50.0,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 28.0,
                          width: 28.0,
                          decoration: const BoxDecoration(
                            color: AppColors.blueColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.camera_alt,
                              color: Colors.white,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Номер телефона',
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextFormField(
                controller: accountController.numberController,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: const InputDecoration(
                  prefixText: '+996   ',
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
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Имя, фамилия',
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextFormField(
                controller: accountController.nameController,
                keyboardType: TextInputType.name,
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
                  hintText: 'Ваше имя',
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Почта Email',
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextFormField(
                controller: accountController.emailController,
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                decoration: const InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.email,
                        color: AppColors.blueColor),
                  ),
                  contentPadding: EdgeInsets.only(top: 16.0, left: 0.0),
                  prefixStyle: TextStyle(
                    fontSize: 15.0,
                    color: AppColors.blackColor,
                  ),
                  hintText: 'abcd@gamil.com',
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomButton(
                onTap: (){},
                width: width,
                height: 55.0,
                btnColor: AppColors.blueColor,
                btnText: 'Обновить',
              ),
            ),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomButton(
                onTap: (){},
                width: width,
                height: 55.0,
                btnColor: Colors.white,
                btnText: 'Выход',
                borderColor: AppColors.redColor,
                borderWidth: 2.0,
                textColor: AppColors.redColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
