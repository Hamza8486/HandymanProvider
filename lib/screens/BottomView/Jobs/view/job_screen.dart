// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/BottomView/Jobs/components/address_update.dart';
import 'package:provider_app/screens/auth/login/controller/login_controller.dart';
import 'package:provider_app/screens/bids/controller/bids_controller.dart';

import 'package:provider_app/screens/request_detail/request_detail_screen.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/app_dimensions.dart';
import 'package:provider_app/widgets/app_slider.dart';
import 'package:provider_app/widgets/app_text.dart';

import '../controller/job_controller.dart';

class JobScreen extends StatefulWidget {
   const JobScreen({Key? key}) : super(key: key);

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  final profController = Get.put(ProfileController());
  final bidController = Get.put(BidsController());
  final  jobController = Get.put(JobController());
  Future<void> _pullRefresh() async {

    setState(() {
      jobController.homeData();
      profController.profData(profController.userId.value);
      profController.profBusinessData(profController.userId.value);
      profController.searchJobData("all",profController.userId.value);
    });
  }

  final  loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Scaffold(
      backgroundColor: AppColors.backColor,

      body:


             Column(
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: size.height * 0.02),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                  child: Image.asset(
                                    "assets/images/location.png",
                                    height: size.height * 0.028,

                                    color: AppColors.blackColor,
                                  )),
                              SizedBox(
                                width: size.width * 0.03,
                              ),

                              GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) => GetAddressView(

                                      ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(
                                      () {
                                        return AppText(
                                            title: profController.addressId.value,
                                          size: Get.height * 0.018,
                                          overFlow: TextOverflow.ellipsis,
                                          color: AppColor.DARK_TEXT_COLOR,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,);
                                      }
                                    )

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                 SizedBox(height: 18.0),
                Obx(
                  () {
                    return Expanded(child: RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [

                            Obx(
                              () {
                                return
                                  jobController.isCatLoading.value?

                                  SizedBox(
                                      height:80.0,
                                      child:
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount:jobController.catList.isEmpty?6: 6,
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index){
                                          return getShimmerAllLoading();
                                        },
                                      )

                                  ):
                                  SizedBox(
                                  height: Get.height*0.12,
                                  child:



                                          jobController.catList.isEmpty?SizedBox.shrink():
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemCount: jobController.catList.length+1,
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index){
                                              return index == 0? GestureDetector(
                                                onTap: (){

                                                  profController.searchJobData("all",profController.userId.value);
                                                  jobController.updateName("");
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 10.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),
                                                    color: AppColors.blueColor.withOpacity(0.01),
                                                            border: Border.all(color: AppColors.blueColor,width: 1)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(16.0),
                                                          child: Image.asset(
                                                            "assets/images/cat.png",
                                                           color: AppColor.primaryColor,
                                                           height: Get.height*0.031,
                                                            //color: AppColors.redColor,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8.0),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 3.0),
                                                        child: Text("Все",
                                                          style: TextStyle(
                                                            fontSize: 13.0,

                                                            color: AppColors.blackColor.withOpacity(0.7),

                                                            fontFamily: "Poppins",

                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ):


                                              GestureDetector(
                                                onTap: (){

                                                  profController.searchJobData(jobController.catList[index-1].id.toString(),profController.userId.value);
                                                  print(jobController.catList[index-1].id.toString());
                                                  jobController.updateName(jobController.catList[index-1].name);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 9.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),
                                                            border: Border.all(color: AppColors.blueColor,width: 1)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(2.0),
                                                          child: ClipRRect(
                                                            borderRadius:BorderRadius.circular(40),
                                                            child: CachedNetworkImage(
                                                              imageUrl: jobController.catList[index-1].image,
                                                              height: 55.0,
                                                              width: 55.0,
                                                              fit: BoxFit.fill,

                                                              errorWidget:
                                                                  (context, url, error) =>
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius.circular(100),
                                                                    child: Image.asset(
                                                                      "assets/images/cat.png",
                                                                      height: Get.height*0.02,
                                                                      scale: 25,

                                                                    ),
                                                                  ),
                                                              placeholder: (context, url) =>
                                                              const Center(
                                                                  child:
                                                                  CircularProgressIndicator(
                                                                    color: AppColors.blueColor,
                                                                  )),
                                                            )






                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 6.0),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 3.0),
                                                        child: SizedBox(
                                                          width:Get.width*0.2,
                                                          child: Text(jobController.catList[index-1].name??"name",

                                                            style: TextStyle(
                                                              fontSize: AppSizes.size_12,

                                                              color: AppColors.blackColor.withOpacity(0.7),

                                                              fontFamily: "Poppins",


                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )

                                );
                              }
                            ),
                            SizedBox(height: 10.0),
                            profController.isLoadingAll.value
                                ? ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: 12,
                                itemBuilder: (BuildContext context, int index) {
                                  return  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                    margin: const EdgeInsets.only( bottom: 10),
                                    child: getShimmerLoading(),
                                  );
                                })
                                :
                             profController.jobList.isNotEmpty?


                              ListView.builder(

                                itemCount: profController.jobList.length,
                                shrinkWrap: true,
                                primary: false,
                                physics:  BouncingScrollPhysics(),
                                padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                itemBuilder: (context, index){
                                  return categoryBox(data: profController.jobList[index]);
                                },
                              ):  Column(
                                children: [
                                  SizedBox(height: Get.height*0.25,),
                                  Center(
                                      child: AppText(
                                        title: "Пока нет работ ${jobController.name.value}",
                                        color: AppColor.DARK_TEXT_COLOR,
                                        size: Get.height*0.02,
                                        fontFamily: Weights.semi,
                                      )),
                                ],
                              )

                          ],
                        ),
                      ),
                    ));
                  }
                )

              ],
          )

    );
  }

  Widget categoryBox({data}) => GestureDetector(
    onTap: (){
      jobController.updateJob(data.id);
      Get.to(RequestDetailScreen(data: data,));
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(5.0, 0.0),
          ),
          BoxShadow(
            blurRadius: 4.0,
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    const SizedBox(height: 4.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:  [
                        Icon(Icons.location_on, color: AppColors.greyColor, size: 18.0),
                        SizedBox(width: 4.0),
                        SizedBox(
                          width: Get.width*0.5,
                          child: Text(data.address,

                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                            fontSize: 13.0,


                            color: AppColors.blackColor,
                          fontFamily: Weights.regular
                          ),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                DateFormat('dd MMM yyyy').format(
                  data.createdAt,
                ),

                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor.withOpacity(0.5),
                    fontFamily: Weights.semi),
              ),
            ],
          ),
           SizedBox(height: 8.0),
           Text(data.description,
            maxLines: 2,
            style: TextStyle(
              fontSize: 15.0,


                color: AppColors.blackColor,
                fontFamily: Weights.regular
            ),),
           SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Container(
                width: 50,
                height: 50,

                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      data.customer == null?"":
                    data.customer.image??"",
                      fit: BoxFit.cover,
                      errorBuilder: (context, exception, stackTrace) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/persons.jpg",
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                data.customer == null?"":
                data.customer.firstName,
                style: TextStyle(
                  fontSize: 14.0,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              data.budget == null?Text("Договорная", style:  TextStyle(
                fontSize: 14.0,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.w500,
              ),): Text("${data.budget.toString()} сом", style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
        ],
      ),
    ),
  );
}
