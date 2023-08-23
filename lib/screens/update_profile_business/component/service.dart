
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/update_profile_business/controller/controller.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/app_field.dart';
import 'package:provider_app/widgets/app_text.dart';
import 'package:provider_app/widgets/back_button.dart';




class UpdateService extends StatefulWidget {
  const UpdateService({Key? key}) : super(key: key);


  @override
  State<UpdateService> createState() => _UpdateServiceState();
}

class _UpdateServiceState extends State<UpdateService> {

  final addServiceController = Get.put(UpdatePageController());
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    var size = Get.size;
    return DraggableScrollableSheet(
      initialChildSize:isKeyBoard? 0.9:0.7,
      minChildSize:isKeyBoard? 0.9:0.7,
      maxChildSize:isKeyBoard? 0.9:0.7,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.WHITE_COLOR,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02, horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              AppText(
                title: "Select Services",
                size: Get.height*0.018,
                fontFamily: Weights.semi,
                fontWeight: FontWeight.w600,
                color: AppColor.DARK_TEXT_COLOR,
              ),


              SizedBox(
                height: Get.height * 0.025,
              ),
              // AppTextFied(
              //   isFill: true,
              //   onChange: (val) {
              //     setState(() {
              //       profileController.serviceJobData(id: val.toString());
              //     });
              //   },
              //   isborderline: true,
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   isborderline2: true,
              //   padding: EdgeInsets.symmetric(
              //       horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
              //   borderRadius: BorderRadius.circular(10),
              //   borderRadius2: BorderRadius.circular(10),
              //   borderColor: AppColor.greyColor,
              //   hint: "Search services",
              //   prefixIcon: Padding(
              //     padding: const EdgeInsets.all(12.0),
              //     child: Icon(Icons.search),
              //   ),
              //   isPrefix: true,
              //   hintColor: AppColor.DARK_TEXT_COLOR.withOpacity(0.5),
              //   textInputType: TextInputType.emailAddress,
              //   textInputAction: TextInputAction.done,
              //   hintSize: 13,
              //   fontFamily: Weights.semi,
              //   borderColor2: AppColor.primaryColor,
              //   maxLines: 1,
              // ),
              // SizedBox(height: Get.height * 0.025),
              Expanded(
                child: Obx(() {
                  return
                    profileController
                        .isServiceBusinessAll.value
                        ? loader(height: Get.height*0.2)
                        :
                    profileController.servicesList.isNotEmpty?
                    ListView.builder(
                        itemCount:
                        profileController.servicesList.length,
                        shrinkWrap: true,
                        padding:
                        EdgeInsets.zero,
                        primary: false,
                        itemBuilder:
                            (BuildContext
                        context,
                            int index) {
                          return Column(
                            children: [
                              SizedBox(
                                height:
                                Get.height *
                                    0.02,
                              ),
                              GestureDetector(
                                onTap: () {


                                  addServiceController.updateServiceName(profileController.servicesList[
                                  index]
                                      .name);
                                  addServiceController.updatePriceId(profileController.servicesList[
                                  index]
                                      .id.toString());

                                  addServiceController.serviceController.text = profileController.servicesList[
                                  index]
                                      .name??"";
                                  Get.back();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Obx(() {
                                          return profileController.servicesList[index].id.toString() == addServiceController.priceServiceId.value
                                              ? Icon(
                                            Icons.check_box_rounded,
                                            color: AppColor.primaryColor,
                                            size: Get.height * 0.03,
                                          )
                                              : Icon(
                                            Icons.check_box_outline_blank,
                                            color: AppColor.greyColor,
                                            size: Get.height * 0.03,
                                          );
                                        }),
                                        SizedBox(
                                          width:
                                          Get.width * 0.03,
                                        ),
                                        AppText(
                                          title: profileController.servicesList[index].name ?? "",
                                          size: Get.height*0.015,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins",
                                          color: AppColor.DARK_TEXT_COLOR,
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                Get.height *
                                    0.01,
                              ),
                              Divider(
                                color: AppColor
                                    .greyColor,
                              ),
                            ],
                          );
                        }):noData(height: Get.height*0.2);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }






}


