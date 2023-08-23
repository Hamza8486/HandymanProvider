import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/res/app_images.dart';



class JobController extends GetxController {


  var jobId = 0.obs;
  updateJob(val){
    jobId.value = val;
    update();
  }

  List<String> topImages = [
    AppImages.categoryOneImage,
    AppImages.categoryTwoImage,
    AppImages.categoryThirdImage,
    AppImages.categoryFourImage,
    AppImages.categoryFiveImage,
    AppImages.categorySixImage,
    AppImages.categorySevenImage,
    AppImages.categoryEightImage,
    AppImages.categoryNineImage,
    AppImages.categoryTenImage,
  ];

  List<Widget> items = [
    Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ];

  var name = "".obs;
  updateName(val){
    name.value = val;
    update();
  }
  var isLoading = false.obs;
  var isCatLoading = false.obs;
  var catList = [].obs;
  var catListAll = [].obs;
  var jobList = [].obs;
  var bannerList = [].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    homeData();
    homeData1();



  }

  homeData() async{


    try{
      isCatLoading(true);
      update();

      var homeViewData =await ApiManger.homeResponse();
      if(homeViewData!=null){
        catList.value = homeViewData.data.category;
        bannerList.value = homeViewData.data.banner;
        update();
        print("testtstss");


        print(homeViewData.data.category.length);
        print(homeViewData.data.banner.length);



      }
      else{
        isCatLoading(false);
        update();
      }
    }
    catch(e){print(e.toString());
    isCatLoading(false);
    update();
    }
    finally{
      isCatLoading(false);
      update();
    }

    update();



  }


  var cityList = [].obs;
  homeData1() async {
    try {
      update();

      var homeViewData = await ApiManger.homeAlResponse();
      if (homeViewData != null) {
        catListAll.value = homeViewData.data.category;
        update();
        print("testtstss");

        print(homeViewData.data.category.length);
        print(homeViewData.data.banner.length);
      } else {

        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {

      update();
    }

    update();
  }


}