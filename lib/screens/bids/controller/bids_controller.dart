import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/Services/helper_function.dart';

class BidsController extends GetxController {
 var isLoading = false.obs;
  var isBidLoading = false.obs;
  var activeList = [].obs;
  var completeList = [].obs;
  var rejectList = [].obs;
  var rejectJobList = [].obs;
  TextEditingController fromController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  var userId = "".obs;
  @override
  void onInit() async {
    HelperFunctions.getFromPreference("id").then((value) {
      userId.value = value;
      bidData(userId.value);
      rejectData(userId.value);
      update();
    });
    super.onInit();

  }

  bidData(userIds) async {
    try {
      isBidLoading(true);
      update();

      var bidViewData = await ApiManger.bidListResponse(id: userIds);
      if (bidViewData != null) {
        activeList.value = bidViewData.data?.active as dynamic;
        rejectList.value = bidViewData.data?.rejected as dynamic;
        completeList.value = bidViewData.data?.completed as dynamic;
        update();
        print("testtstss");
      } else {
        isBidLoading(false);
        update();
      }
    } catch (e) {
      isBidLoading(false);
      update();
      print(e.toString());
    } finally {
      isBidLoading(false);
      update();
    }

    update();
  }

  rejectData(userIds) async {
    try {
      isLoading(true);

      var bidViewData = await ApiManger().rejectResponse(id: userIds);
      if (bidViewData != null) {
        rejectJobList.value = bidViewData.data;
        update();
        print("testtstss");
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
