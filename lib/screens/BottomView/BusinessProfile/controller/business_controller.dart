import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/Services/helper_function.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/model/business_model.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/model/notification.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/model/services_model.dart';
import 'package:provider_app/screens/BottomView/Profile/model/user_model.dart';
import 'package:provider_app/screens/bids/Model/chats_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var isChatLoading = false.obs;
  ScrollController scrollController = ScrollController();
  void scrollToLastMessage() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  updateChatLoading(val){
    isChatLoading.value=val;
    update();

  }
  var scrollLoading = true.obs;
  updateScrollLoading(val){
    scrollLoading.value=val;
    update();
  }
  var isLoadingAll = false.obs;
  var valueStart = "".obs;
  var readData = "0".obs;
  updateReadData(val){
    readData.value=val;
    update();
  }

  updateValueStart(val) {
    valueStart.value = val;
    update();
  }

  var isTop=0.obs;
  updateTop(val){
    isTop.value=val;
    update();

  }

  var isBusinessAll = false.obs;
  var isServiceBusinessAll = false.obs;

  ProfileModel? profileData;
  BusinessData? businessData;

  var subCatList = [].obs;
  var selectIndex = [].obs;
  var selectName = [].obs;
  var selectName1 = [].obs;
  var servicesList = <ServiceDataAll>[].obs;
  var chatList = <ChatsAllModels>[].obs;

  updateValue(var val) {
    if (selectIndex.contains(val)) {
      selectIndex.remove(val);
    } else {
      selectIndex.add(val);
    }
    update();
  }

  updateName(var val) {
    if (selectName.contains(val)) {
      selectName.remove(val);
    } else {
      selectName.add(val);
    }
    update();
  }

  updateName1(var val) {
    if (selectName1.contains(val)) {
      selectName1.remove(val);
    } else {
      selectName1.add(val);
    }
    update();
  }

  File? file;
  File? file1;
  File? file2;
  File? file3;
  File? file4;

  var catList = [].obs;
  var notificationList = <DataNotification>[].obs;
  var userId = "".obs;
  var userIds = "".obs;
  var jobId = "".obs;
  var addressId = "".obs;
  updateAddress(val) {
    addressId.value = val;
    update();
  }
  updateUser(val) {
    userIds.value = val;
    update();
  }
  updateJob(val) {
    jobId.value = val;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    HelperFunctions.getFromPreference("id").then((value) {
      userId.value = value;
      profData(userId.value);

      profBusinessData(userId.value);
      notData();
      profBusinessData1(userId.value);
      searchJobData("all", userId.value);
      update();
    });
    HelperFunctions.getFromPreference("address").then((value) {
      addressId.value = value;
      update();
    });

    serviceJobData(id: "");
  }

  notData() async {
    try {
      isLoading(true);
      update();

      var profileViewData = await ApiManger.getNotificationAll();
      if (profileViewData != null) {
        notificationList.value = profileViewData.data as dynamic;
        // profileViewData.data!.where((element) => element.isRead==null).isNotEmpty?
        // updateReadData("0"):updateReadData("1");
        update();
        print("testtstss");

        print("This is notification");
        print(profileViewData.data);
      } else {
        isLoading(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
      update();
    }
    update();
  }



  chatData() async {
    try {


      var profileViewData = await ApiManger.getChatListaLL();
      if (profileViewData != null) {
        chatList.value = profileViewData.data?.chats as dynamic;
        Get.put(ProfileController()).scrollToLastMessage();
        update();

        print(profileViewData.data?.chats);
      } else {

      }
    } catch (e) {
      print(e.toString());
    } finally {

    }
    update();
  }



  profData(userId) async {
    try {
      isLoading(true);
      update();

      var profileViewData = await ApiManger.profileResponse(id: userId);
      if (profileViewData != null) {
        profileData = profileViewData.data;
        update();
        print("testtstss");

        print(profileViewData.data);
      } else {
        isLoading(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
      update();
    }
    update();
  }

  profBusinessData(userId) async {
    try {
      isBusinessAll(true);
      update();

      var profileViewData = await ApiManger.profileBusResponse(id: userId);
      if (profileViewData != null) {
        businessData = profileViewData.data;
        updateTop("This is to data${profileViewData.data?.isTop}");
        update();
        print("testtstss");

        print(profileViewData.data);
      } else {
        isBusinessAll(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isBusinessAll(false);
      update();
    }

    update();
  }


  profBusinessData1(userId) async {
    try {


      var profileViewData = await ApiManger.profileBusResponse(id: userId);
      if (profileViewData != null) {
        businessData = profileViewData.data;
        updateTop(profileViewData.data?.isTop);
        update();
        print("testtstss");

        print(profileViewData.data);
      } else {

      }
    } catch (e) {
      print(e.toString());
    } finally {

      update();
    }

    update();
  }

  var jobList = [].obs;
  searchJobData(idCat, proId) async {
    try {
      isLoadingAll(true);
      update();

      var jobViewData = await ApiManger.searchResponse(id: idCat, proId: proId);
      if (jobViewData != null) {
        jobList.value = jobViewData.data?.jobs as dynamic;
        update();
        print("testtstss");

        print(jobViewData.data?.jobs?.length);
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isLoadingAll(false);
      update();
    }

    update();
  }

  serviceJobData({id}) async {
    try {
      isServiceBusinessAll(true);
      update();

      var jobViewData = await ApiManger.servicesResponse(id: id);
      if (jobViewData != null) {
        servicesList.value = jobViewData.data as dynamic;
        update();
        print("testtstss");

        print(jobViewData.data?.length);
      } else {
        isServiceBusinessAll(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isServiceBusinessAll(false);
      update();
    }

    update();
  }



  RxBool status = false.obs;

  var selectDate = DateTime.now().obs;

  void toggle(bool val) {
    status.value = val;
  }

  chooseDate({required BuildContext context}) async {
    DateTime? pickDate = await showDatePicker(
      context: Get.context!,

      initialDate: selectDate.value,
      firstDate: DateTime.now(),
      locale: const Locale("ru", "RU"),
      lastDate: DateTime(2030),
    );
    if(pickDate != null && pickDate != selectDate.value){
      selectDate.value = pickDate;
    }
  }
}
