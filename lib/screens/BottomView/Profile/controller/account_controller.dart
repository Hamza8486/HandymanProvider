import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/model/cat_model.dart';
import 'package:provider_app/screens/BottomView/Profile/model/sub_model.dart';
import 'package:provider_app/screens/verification_page/controller/verification_page_controller.dart';

class ProfilePageController extends GetxController {

  var addLocItem = <CatModel>[].obs;
  var isLoading = false.obs;
  var isSubLoading = false.obs;
  TextEditingController serviceController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var searchList = [].obs;
  var subList = <SubCatModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    searchSubCat(searchKeyword: "all");
    super.onInit();
  }

  searchSubCat({var searchKeyword}) async {
    try {
      isSubLoading(true);
      update();

      var searchData =
      await ApiManger.subCatRes(category: searchKeyword);
      if (searchData != null) {
        subList.value = searchData.data;
        print(searchList);
      } else {
        isSubLoading(false);
        update();
      }
    } catch (e) {
      isSubLoading(false);
      update();
      print(e.toString());
    } finally {
      isSubLoading(false);
      update();
    }
    update();
  }
  var priceServiceId = "".obs;
  updatePriceId(val){
    priceServiceId.value = val;
    update();
  }
  var price = "".obs;
  updatePrice(val){
    price.value = val;
    update();
  }
  var serviceName = "".obs;
  updateServiceName(val){
    serviceName.value = val;
    update();
  }

  searchUpdate(var searchKeyword) async {
    try {
      isLoading(true);

      var searchData =
      await ApiManger.subCategoryRes(category: searchKeyword);
      if (searchData != null) {
        searchList.value = searchData.data;
        print(searchList);
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }


  clearAllValue(){
    addLocItem.clear();
    priceController.clear();
    serviceController.clear();
    priceServiceId.value = "";
    serviceName.value = "";

    Get.put(ProfileController()).file=null;
    Get.put(VerificationPageController()).nameController.clear();
    Get.put(VerificationPageController()).aboutController.clear();
    Get.put(VerificationPageController()).dayController.clear();
    Get.put(VerificationPageController()).monthController.clear();
    Get.put(VerificationPageController()).yearController.clear();
    Get.put(ProfileController()).file=null;
    Get.put(ProfileController()).file=null;
    Get.put(ProfileController()).file1=null;
    Get.put(ProfileController()).file2=null;
  }
}