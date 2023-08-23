
// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/BottomView/Profile/components/add_service.dart';
import 'package:provider_app/screens/Portfolio/Component/add_portfolio.dart';
import 'package:provider_app/screens/Portfolio/Controller/controller.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Dialogue/dialogue.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/Loader/loader.dart';
import 'package:provider_app/widgets/app_text.dart';
import 'package:provider_app/widgets/back_button.dart';



class AddServicesView extends StatefulWidget {
  AddServicesView({Key? key}) : super(key: key);

  @override
  State<AddServicesView> createState() => _AddServicesViewState();
}

class _AddServicesViewState extends State<AddServicesView> {

  final portController = Get.put(PortfolioController());
  final  profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.backColor,

        body:  Column(
                children: [
                  Material(
                    color: AppColor.WHITE_COLOR,
                    elevation: 1,
                    child: SizedBox(
                      width: size.width,
                      height: size.height / 8.5 ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.018 ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child:    Row(
                                children: [
                                  GestureDetector(
                                      onTap: (){
                                        Get.back();
                                      },
                                      child: Icon(Icons.arrow_back_outlined)),
                                  SizedBox(width: 20,),
                                  AppText(
                                      title: "Услуги",
                                      size: size.height * 0.022,
                                      overFlow: TextOverflow.ellipsis,
                                      color: AppColor.DARK_TEXT_COLOR,
                                      fontFamily: Weights.semi),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.02),
                        child:SingleChildScrollView(
                          child: Column(
                            children: [

                              Obx(
                                () {
                                  return
                                    profileController.isBusinessAll.value?loader():



                                    ListView.builder(
                                      itemCount: profileController.businessData?.services?.length,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                          child: Card(
                                            margin: EdgeInsets.zero,
                                            color: AppColor.WHITE_COLOR,

                                            elevation: 1.5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),

                                                side: BorderSide(
                                                    color: Colors.grey.withOpacity(0.1)

                                                )
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: Get.height*0.01,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(profileController.businessData?.services?[index].name??"",
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: AppColors.blackColor,
                                                          fontFamily: "Poppins",
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                      Text("${profileController.businessData?.services?[index].price.toString().split(".").first} сом",
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: AppColors.blackColor,
                                                          fontFamily: "Poppins",
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: Get.height*0.015,),
                                                  profileController.businessData?.services?.length==1?SizedBox.shrink():
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                        onTap:(){
                                                          showAlertDialog(context: context,
                                                              text: "Вы хотите удалить услугу?",
                                                              yesOnTap: () {
                                                                Get.back();
                                                                appLoader(context, AppColor.primaryColor);
                                                                ApiManger().delServiceProvider(context: context,
                                                                    jobId: profileController.businessData?.services?[index].id.toString()
                                                                );
                                                              }
                                                          );

                                                        },
                                                        child: Container(
                                                          height: Get.height * 0.042,
                                                          width: Get.height * 0.042,
                                                          decoration: BoxDecoration(
                                                              color: AppColor.primaryColor,
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(Get.height * 0.1))),
                                                          child: const Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                              ),
                            ],
                          ),
                        )



                    ),
                  ),
                ],
              ),


        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.03),
          child: FloatingActionButton(
            backgroundColor: AppColor.primaryColor,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: (){
              print(profileController.businessData?.id.toString());
              profileController.serviceJobData(id: profileController.businessData?.id.toString());

              Get.to(ServicesView(),
                  transition: Transition.rightToLeft
              );
            },
          ),
        )



    );


  }


}