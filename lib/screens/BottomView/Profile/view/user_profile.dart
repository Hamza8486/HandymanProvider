import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider_app/Services/helper_function.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/BottomView/Jobs/controller/job_controller.dart';
import 'package:provider_app/screens/BottomView/Profile/components/account_buttons.dart';
import 'package:provider_app/screens/BottomView/Profile/components/serviceList.dart';
import 'package:provider_app/screens/BottomView/Profile/components/edit_profile.dart';
import 'package:provider_app/screens/BottomView/Profile/components/privacy_policy.dart';
import 'package:provider_app/screens/BottomView/Support/controller/support_controller.dart';
import 'package:provider_app/screens/Home/view/home_view.dart';
import 'package:provider_app/screens/Portfolio/Controller/controller.dart';
import 'package:provider_app/screens/Portfolio/View/portfolio.dart';
import 'package:provider_app/screens/account/controller/account_controller.dart';
import 'package:provider_app/screens/auth/login/View/login_view.dart';
import 'package:provider_app/screens/auth/login/controller/login_controller.dart';
import 'package:provider_app/screens/bids/controller/bids_controller.dart';
import 'package:provider_app/screens/update_profile_business/controller/controller.dart';

import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/SnackBar/snack_bar.dart';
import 'package:provider_app/widgets/app_text.dart';
import 'package:provider_app/widgets/custom_button.dart';
import 'package:share_plus/share_plus.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  final accountController = Get.put(AccountController());
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    var size = Get.size;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Material(
            color: AppColor.WHITE_COLOR,
            elevation: 1,
            child: SizedBox(
              width: size.width,
              height: size.height / 8.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.018),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AppText(
                          title: "Профиль",
                          size: size.height * 0.022,
                          overFlow: TextOverflow.ellipsis,
                          color: AppColor.DARK_TEXT_COLOR,
                          fontFamily: Weights.semi),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            return profileController.isLoading.value
                ? Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.4,
                      ),
                      const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.blueColor,
                      )),
                    ],
                  )
                : profileController.userId.value.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.4,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(const LoginScreen());
                              },
                              child: AppText(
                                  title: "Войти",
                                size: Get.height * 0.018,
                                overFlow: TextOverflow.ellipsis,
                                color: AppColor.DARK_TEXT_COLOR,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,),
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  const SizedBox(height: 16.0),
                                  profileData(),
                                  const SizedBox(height: 12.0),
                                  const Divider(
                                    thickness: 0.7,
                                    color: AppColors.greyColor,
                                  ),
                                  AccountButtons(
                                    onTap: () {
                                      Share.share(
                                          'https://yamaster.kg/legal');
                                    },
                                    title: 'Пригласить друга',
                                    icon: Icons.person,
                                  ),
                                  const Divider(
                                    thickness: 0.7,
                                    color: AppColors.greyColor,
                                  ),
                                  AccountButtons(
                                    onTap: () {},
                                    title: 'Уведомления',
                                    icon: Icons.notifications,
                                  ),
                                  const Divider(
                                    thickness: 0.7,
                                    color: AppColors.greyColor,
                                  ),
                                  AccountButtons(
                                    onTap: () {
                                      Get.to(PrivacyPolicy(),
                                          transition: Transition.rightToLeft);
                                    },
                                    title: 'Правила сервиса',
                                    icon: Icons.policy,
                                  ),
                                  const Divider(
                                    thickness: 0.7,
                                    color: AppColors.greyColor,
                                  ),
                                  AccountButtons(
                                    onTap: () {
                                      if (profileController.businessData ==
                                          null) {
                                        showErrorToast(
                                            "Создайте профиль специалиста для откликов на заказы");
                                        Get.offAll(
                                            PersisNavBar(currentIndex: 2));
                                      } else if (profileController
                                              .businessData?.status ==
                                          "0") {
                                        showErrorToast(
                                            "Пожалуйста подождите активации профиля");
                                      } else {
                                        Get.put(UpdatePageController())
                                            .addLocItem
                                            .clear();
                                        Get.to(AddServicesView(),
                                            transition: Transition.rightToLeft);
                                      }
                                    },
                                    title: 'Услуги и цены',
                                    icon: Icons.design_services,
                                  ),
                                  const Divider(
                                    thickness: 0.7,
                                    color: AppColors.greyColor,
                                  ),
                                  AccountButtons(
                                    onTap: () {
                                      if (profileController.businessData ==
                                          null) {
                                        showErrorToast(
                                            "Создайте профиль специалиста для откликов на заказы");
                                        Get.offAll(
                                            PersisNavBar(currentIndex: 2));
                                      } else if (profileController
                                              .businessData?.status ==
                                          "0") {
                                        showErrorToast(
                                            "Пожалуйста подождите активации профиля");
                                      } else {
                                        Get.to(PortfolioScreen(),
                                            transition: Transition.rightToLeft);
                                      }
                                    },
                                    title: 'Фото работ',
                                    icon: Icons.supervised_user_circle,
                                  ),
                                  const Divider(
                                    thickness: 0.7,
                                    color: AppColors.greyColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: CustomButton(
                                onTap: () {},
                                width: width,
                                height: 55.0,
                                btnColor: AppColors.blueColor,
                                btnText: 'Приложение клиента',
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            GestureDetector(
                              onTap: () async {
                                await Get.delete<ProfileController>();
                                await Get.delete<BidsController>();
                                await Get.delete<JobController>();
                                await Get.delete<SupportSectionController>();
                                await Get.delete<AccountController>();
                                await Get.delete<LoginController>();
                                await Get.delete<UpdatePageController>();
                                await Get.delete<PortfolioController>();

                                HelperFunctions.clearPrefs();
                                Get.offAll(LoginScreen());
                              },
                              child: Center(
                                child: Text(
                                  'Выход',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.blackColor,
                                    fontFamily: Weights.semi,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
          })
        ],
      ),
    );
  }

  Widget profileData() {
    final profileController = Get.put(ProfileController());
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: profileController.profileData?.image ?? "",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/person.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.blueColor,
                          )),
                        ),
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: Container(
                  //     width: 23,
                  //     height: 23,
                  //     decoration: const BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: AppColors.blueColor,
                  //     ),
                  //     child: Icon(
                  //       Icons.camera_alt_rounded,
                  //       color: AppColor.WHITE_COLOR,
                  //       size: 12,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profileController.profileData?.firstName ?? "",
                    style: const TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    profileController.profileData?.phoneNo ?? "",
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    profileController.profileData?.email ?? "email@gmail.com",
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(
                    EditProfileScreen(
                      data: profileController.profileData,
                    ),
                    transition: Transition.rightToLeft);
              },
              child: const Text(
                'Изменить',
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.blueColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ));
  }
}
