
// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/screens/Portfolio/Component/add_portfolio.dart';
import 'package:provider_app/screens/Portfolio/Controller/controller.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Dialogue/dialogue.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/Loader/loader.dart';
import 'package:provider_app/widgets/app_text.dart';
import 'package:provider_app/widgets/back_button.dart';



class PortfolioScreen extends StatefulWidget {
  PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {

  final portController = Get.put(PortfolioController());

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,

      body: Obx(
        () {
          return Column(
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
                                  title: "Фото работ",
                                size: Get.height * 0.018,
                                overFlow: TextOverflow.ellipsis,
                                color: AppColor.DARK_TEXT_COLOR,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,),
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
                  child:
                        portController.isLoading.value
                            ? loader()
                            :
                        portController.imageList.isNotEmpty?


                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.3,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10),
                          itemCount: portController.imageList.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GestureDetector(
                              onTap: (){

                                showAlertDialog(context: context,text: "Вы хотите удалить фото...??",
                                    yesOnTap: (){
                                      Get.back();
                                      appLoader(context, AppColor.primaryColor);
                                      ApiManger().deletePortfolioResp(context: context,
                                          id: portController.imageList[index].id.toString()
                                      );
                                    }
                                );

                              },
                              child:
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColor.primaryColor),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    height:Get.height,
                                    width: Get.height,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: portController.imageList[index].image , fit: BoxFit.cover,

                                        placeholder: (context, url) =>


                                        const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.blueColor,
                                            )),



                                      ),
                                    ),
                                  ),
                                  Positioned(

                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: Get.height * 0.17,
                                            left: Get.width * 0.37),
                                        child: Container(
                                          decoration: BoxDecoration(


                                          ),
                                          child: Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )),)
                                ],
                              ),




                            );
                          }):

                        Column(
                          children: [
                            SizedBox(height: Get.height*0.4,),
                            Center(
                                child: AppText(
                                  title: "Пока нет фото",
                                  color: AppColor.DARK_TEXT_COLOR,
                                  fontFamily: Weights.medium,
                                )),
                          ],
                        )



                ),
              ),
            ],
          );
        }
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
              Get.to(AddImages(),
              transition: Transition.rightToLeft
              );
            },
          ),
        )



    );


  }


}