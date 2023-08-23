
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/BottomView/Profile/controller/account_controller.dart';
import 'package:provider_app/screens/update_profile_business/controller/controller.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/app_field.dart';
import 'package:provider_app/widgets/app_text.dart';
import 'package:provider_app/widgets/back_button.dart';




class SubCatViewList extends StatefulWidget {
   SubCatViewList({Key? key,required this.data}) : super(key: key);
  var data;


  @override
  State<SubCatViewList> createState() => _SubCatViewListState();
}

class _SubCatViewListState extends State<SubCatViewList> {

  final addServiceController = Get.put(UpdatePageController());
  final profileController = Get.put(ProfileController());
  final profilePageController = Get.put(ProfilePageController());
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
                title: "Выберите специальность",
                size: Get.height*0.018,
                fontFamily: Weights.semi,
                fontWeight: FontWeight.w600,
                color: AppColor.DARK_TEXT_COLOR,
              ),

              SizedBox(height: Get.height * 0.025),
              Expanded(
                child:

                    widget.data.subCategory.isNotEmpty?
                    ListView.builder(
                        itemCount:
                        widget.data.subCategory.length,
                        shrinkWrap: true,
                        padding:
                        EdgeInsets.zero,
                        primary: false,
                        itemBuilder:
                            (BuildContext
                        context,
                            int index) {
                          return Obx(
                            () {
                              return Column(
                                children: [
                                  SizedBox(
                                    height:
                                    profileController.selectName.isEmpty?Get.height *
                                        0.02:      Get.height *
                                        0.02,
                                  ),
                                  GestureDetector(
                                    onTap: () {


                                      profileController
                                          .updateName(widget.data.subCategory[index].name);
                                      profileController
                                          .updateValue(widget.data.subCategory[index].id);
                                      print(profileController.selectIndex.length);

                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            profileController.selectName
                                                .contains(widget.data.subCategory[index]
                                                .name)?
                                            Icon(
                                              Icons.check_box,
                                              color: AppColor.primaryColor,
                                              size: Get.height * 0.03,
                                            ):
                                            Icon(
                                                Icons.check_box_outline_blank,
                                                color: AppColor.greyColor,
                                                size: Get.height * 0.03,
                                              ),
                                            SizedBox(
                                              width:
                                              Get.width * 0.03,
                                            ),
                                            AppText(
                                              title: widget.data.subCategory[index].name ?? "",
                                              size: Get.height*0.015,
                                              fontFamily:"Poppins",
                                              fontWeight: FontWeight.w500,
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
                            }
                          );
                        }):noData(height: Get.height*0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }






}


