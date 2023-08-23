import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/res/app_images.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/component/portfolio_detail.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/component/review_box.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/BottomView/Profile/components/serviceList.dart';
import 'package:provider_app/screens/Portfolio/Controller/controller.dart';
import 'package:provider_app/screens/Portfolio/View/portfolio.dart';
import 'package:provider_app/screens/update_profile_business/controller/controller.dart';
import 'package:provider_app/screens/update_profile_business/view/update_profile.dart';

import 'package:provider_app/screens/verification_page/verification_page.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/SnackBar/snack_bar.dart';
import 'package:provider_app/widgets/app_text.dart';
import 'package:provider_app/widgets/back_button.dart';
import 'package:provider_app/widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.put(ProfileController());

  final portController = Get.put(PortfolioController());

  final updateController = Get.put(UpdatePageController());

  String calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.backColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            profileController.businessData == null ?
            Material(
              color: AppColor.WHITE_COLOR,
              elevation: 1,
              child: SizedBox(
                width: Get.width,
                height: Get.height / 8.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.02,
                          vertical: Get.height * 0.018),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                                title: "Профиль специалиста",
                              size: Get.height * 0.018,
                              overFlow: TextOverflow.ellipsis,
                              color: AppColor.DARK_TEXT_COLOR,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,),

                       Container()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ):profileController.businessData?.status == "0"?Material(
              color: AppColor.WHITE_COLOR,
              elevation: 1,
              child: SizedBox(
                width: Get.width,
                height: Get.height / 8.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.02,
                          vertical: Get.height * 0.018),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                                title: "Профиль специалиста",
                              size: Get.height * 0.018,
                              overFlow: TextOverflow.ellipsis,
                              color: AppColor.DARK_TEXT_COLOR,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,),

                            Container()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ):Material(
              color: AppColor.WHITE_COLOR,
              elevation: 1,
              child: SizedBox(
                width: Get.width,
                height: Get.height / 8.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.02,
                          vertical: Get.height * 0.018),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                                title: "Профиль специалиста",
                                size: Get.height * 0.022,
                                overFlow: TextOverflow.ellipsis,
                                color: AppColor.DARK_TEXT_COLOR,
                                fontFamily: Weights.semi),

                            GestureDetector(
                              onTap: () {
                                Get.to(UpdateEditBusinessProfile(
                                  data: profileController.businessData,
                                ));

                              },
                              child:


                              Container(
                                height: Get.height * 0.042,
                                width: Get.height * 0.042,
                                decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Get.height * 0.1))),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
             profileController.businessData == null
                      ? noProfile()
                      : profileController.businessData?.status == "0"
                          ? SizedBox(
                              height: height * 0.7,
                              width: width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: height * 0.2,
                                    width: height * 0.2,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AppImages.profileIcon,
                                        color: AppColors.greyColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 23.0),
                                  const Text(
                                    'Ваш профиль будет активирован после модерации',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Obx(
                            () {
                              return
                                profileController.isBusinessAll.value?loader():

                                Expanded(
                                  child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.06),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        Center(
                                          child: Container(
                                            height: Get.height * 0.15,
                                            width: Get.height * 0.15,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColor.BLACK_COLOR),
                                                borderRadius:
                                                    BorderRadius.circular(80)),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                child: CachedNetworkImage(
                                                  imageUrl: profileController
                                                          .businessData?.image ??
                                                      "",
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(100),
                                                    child: Image.asset(
                                                      'assets/images/person.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                    color: AppColors.blueColor,
                                                  )),
                                                )),
                                          ),
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${profileController.businessData?.name ?? ""},",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: AppColors.blackColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: Weights.semi,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.02,
                                            ),
                                            Text(
                                              "${calculateAge(DateTime.parse(profileController.businessData?.dob ?? ""))} лет",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: AppColors.blackColor,
                                                fontFamily: Weights.semi,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 8.0),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.check_circle,
                                                size: 22.0,
                                                color: AppColor.primaryColor),
                                            const SizedBox(width: 7),
                                            Text(
                                              "Паспорт",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: AppColors.blackColor,
                                                fontFamily: Weights.regular,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            const SizedBox(width: 12.0),
                                            const Icon(
                                              Icons.star,
                                              size: 18.0,
                                              color: Colors.orangeAccent,
                                            ),
                                            Text(
                                              "${profileController.businessData!.rating.toString()}.0",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(width: 12.0),
                                            Icon(CupertinoIcons.chat_bubble,
                                                size: 18.0,
                                                color: AppColors.blackColor),
                                            const SizedBox(width: 7),
                                            Text(
                                              profileController
                                                  .businessData!.countReview
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height*0.02,),
                                        Obx(
                                          () {
                                            return
                                              profileController.isTop.value==1?
                                              Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey.withOpacity(0.7),
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(10))),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 14,vertical: 8),
                                                          child: Text(
                                                            "Поднять в топ",
                                                            style: TextStyle(
                                                              fontSize: Get.height*0.019,
                                                              color: AppColor.WHITE_COLOR.withOpacity(0.7),
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                    SizedBox(height: 6,),
                                                    Text(
                                                      "Следующее поднятие доступно завтра",
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: AppColors.blueColor,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ):
                                              GestureDetector(
                                              onTap: (){

                                                ApiManger().moveTop(context: context,id: profileController.userId.value);
                                                successToast("Успешно поднято");
                                                profileController.updateTop(1);

                                              },
                                              child: Center(
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColor.primaryColor,
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 8),
                                                    child: Text(
                                                      "Поднять в топ",
                                                      style: TextStyle(
                                                        fontSize: Get.height*0.02,
                                                        color: AppColor.WHITE_COLOR,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  )
                                                ),
                                              ),
                                            );
                                          }
                                        ),



                                        // Align(
                                        //   alignment: Alignment.center,
                                        //   child: Text(DateFormat('yyyy-MM-dd').format(
                                        //       profileController
                                        //           .businessData!.dob),
                                        //     style:  TextStyle(
                                        //       fontSize: Get.height*0.02,
                                        //       fontFamily: Weights.medium,
                                        //       color: AppColors.blackColor,
                                        //
                                        //     ),
                                        //
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),

                                        Text(
                                          "О СЕБЕ :",
                                          style: TextStyle(
                                            fontSize: Get.height * 0.017,
                                            fontFamily: Weights.semi,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.WHITE_COLOR,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 3),
                                            child: Text(
                                              profileController
                                                      .businessData?.aboutMe ??
                                                  "",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: Get.height * 0.019,
                                                fontFamily: Weights.medium,
                                                color: AppColors.blackColor,
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "УСЛУГИ :",
                                              style: TextStyle(
                                                fontSize: Get.height * 0.017,
                                                fontFamily: Weights.semi,
                                                color: AppColors.blackColor,
                                              ),
                                            ),
                                            profileController.businessData!.services!.isNotEmpty?
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  updateController.addLocItem
                                                      .clear();
                                                });
                                                Get.to(AddServicesView(),
                                                    transition:
                                                        Transition.rightToLeft);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text("Добавить",
                                                          style: TextStyle(
                                                            fontSize:
                                                                Get.height * 0.016,
                                                            fontFamily:
                                                                Weights.semi,
                                                            color: AppColor
                                                                .WHITE_COLOR,
                                                          )),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ):SizedBox.shrink(),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                    profileController.businessData!.services!.isEmpty?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Добавьте усулги\n и получайте больше заказов",
                                          style: TextStyle(
                                            fontSize: Get.height * 0.015,
                                            fontFamily: Weights.medium,
                                            color: AppColors.blueColor,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              updateController.addLocItem
                                                  .clear();
                                            });
                                            Get.to(AddServicesView(),
                                                transition:
                                                Transition.rightToLeft);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text("Добавить",
                                                      style: TextStyle(
                                                        fontSize:
                                                        Get.height * 0.016,
                                                        fontFamily:
                                                        Weights.semi,
                                                        color: AppColor
                                                            .WHITE_COLOR,
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )      :
                                        Container(
                                          width: width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.greyColor
                                                    .withOpacity(0.2),
                                                blurRadius: 7.0,
                                                offset: const Offset(0.0, 7.0),
                                              ),
                                            ],
                                          ),
                                          child: ListView.builder(
                                              itemCount: profileController
                                                  .businessData?.services?.length,
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              primary: false,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16, vertical: 12),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        profileController
                                                                .businessData
                                                                ?.services?[index]
                                                                .name ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          color:
                                                              AppColors.blackColor,
                                                          fontFamily: Weights.semi,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${profileController.businessData?.services?[index].price.toString().split(".").first} сом",
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          color:
                                                              AppColors.blackColor,
                                                          fontFamily: Weights.semi,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.035,
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //           Get.to(PortfolioScreen(),
                                            //     transition: Transition.rightToLeft
                                            // );
                                            Text(
                                              "ФОТО РАБОТ",
                                              style: TextStyle(
                                                fontSize: Get.height * 0.017,
                                                fontFamily: Weights.semi,
                                                color: AppColors.blackColor,
                                              ),
                                            ),

                                            Obx(() {
                                                return
                                                  portController.imageList.isNotEmpty?
                                                  GestureDetector(
                                                  onTap: () {
                                                    Get.to(PortfolioScreen(),
                                                        transition:
                                                            Transition.rightToLeft);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColor.primaryColor,
                                                        borderRadius:
                                                            BorderRadius.circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            "Добавить",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Get.height * 0.016,
                                                              fontFamily: Weights.semi,
                                                              color:
                                                                  AppColor.WHITE_COLOR,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ):SizedBox.shrink();
                                              }
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        portController.imageList.isEmpty
                                            ?  Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Добавьте фото работ\n и получайте больше заказов",
                                              style: TextStyle(
                                                fontSize: Get.height * 0.015,
                                                fontFamily: Weights.medium,
                                                color: AppColors.blueColor,
                                              ),
                                            ),

                                            GestureDetector(
                                              onTap: () {
                                                Get.to(PortfolioScreen(),
                                                    transition:
                                                    Transition.rightToLeft);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.primaryColor,
                                                    borderRadius:
                                                    BorderRadius.circular(10)),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Text("Добавить",
                                                          style: TextStyle(
                                                            fontSize:
                                                            Get.height * 0.016,
                                                            fontFamily:
                                                            Weights.semi,
                                                            color: AppColor
                                                                .WHITE_COLOR,
                                                          )),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                            : SizedBox(
                                                height: Get.height * 0.13,
                                                child: ListView.builder(
                                                    itemCount: portController
                                                        .imageList.length,
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return GestureDetector(
                                                        onTap: (){
                                                          Get.to(PortfolioDetail(data:portController
                                                              .imageList[
                                                          index]
                                                              .image ,));
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.symmetric(
                                                                  horizontal: index ==
                                                                          0
                                                                      ? 0
                                                                      : Get.width *
                                                                          0.02,
                                                                  vertical: 10),
                                                          width: Get.width * 0.25,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10),

                                                          ),
                                                          child: ClipRRect(
                                                              borderRadius:
                                                              BorderRadius.circular(10),
                                                              child: CachedNetworkImage(
                                                                imageUrl: portController
                                                                    .imageList[
                                                                index]
                                                                    .image??
                                                                    "",
                                                                fit: BoxFit.cover,
                                                                errorWidget:
                                                                    (context, url, error) =>
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius.circular(100),
                                                                      child: Image.asset(
                                                                        'assets/images/person.png',
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                placeholder: (context, url) =>
                                                                const Center(
                                                                    child:
                                                                    CircularProgressIndicator(
                                                                      color: AppColors.blueColor,
                                                                    )),
                                                              )),
                                                        ),
                                                      );
                                                    }),
                                              ),

                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),

                                        Text(
                                          "ОТЗЫВЫ :",
                                          style: TextStyle(
                                            fontSize: Get.height * 0.017,
                                            fontFamily: Weights.semi,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        (profileController.businessData?.review??[]).isEmpty?
                                        Center(
                                          child: Text(
                                            "Пока нет отзывов",
                                            style: TextStyle(
                                              fontSize: Get.height * 0.018,
                                              fontFamily: Weights.medium,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ):
                                        Container(
                                          width: width,

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.greyColor.withOpacity(0.2),
                                                blurRadius: 7.0,
                                                offset: const Offset(0.0, 7.0),
                                              ),
                                            ],
                                          ),
                                          child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: profileController.businessData?.review?.length,
                                              shrinkWrap: true,
                                              primary: false,
                                              itemBuilder: (context, index) {
                                                return ReviewBox(data: profileController.businessData?.review?[index],);
                                              }
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                            }
                          )
          ],
        ));
  }
}

Widget noProfile() {
  return SizedBox(
    height: Get.height * 0.7,
    width: Get.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: Get.height * 0.2,
          width: Get.height * 0.2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: SvgPicture.asset(
              AppImages.profileIcon,
              color: AppColors.greyColor,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Создать профиль специалиста',
          style: TextStyle(
            fontSize: 24.0,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.0),
          child: Text(
            'Чтобы начать работать, создайте профиль специалиста',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: CustomButton(
            onTap: () {
              Get.to(const VerificationPage());
            },
            width: Get.width,
            height: 55.0,
            btnColor: Colors.white,
            btnText: 'Создать профиль',
            borderColor: AppColors.blueColor,
            borderWidth: 2.0,
            textColor: AppColors.blueColor,
          ),
        ),
      ],
    ),
  );
}
