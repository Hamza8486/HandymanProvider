import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/screens/bids/components/bids_box.dart';
import 'package:provider_app/screens/bids/components/reject.dart';
import 'package:provider_app/screens/bids/components/reject_new.dart';
import 'package:provider_app/screens/bids/controller/bids_controller.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/app_text.dart';
import 'package:provider_app/widgets/back_button.dart';



class RejectJobList extends StatelessWidget {
  RejectJobList({Key? key}) : super(key: key);

  final  jobController = Get.put(BidsController());

  @override
  Widget build(BuildContext context) {
    return  Obx(
            () {
          return
            jobController.isBidLoading.value
                ? loader():
            jobController.rejectList.isNotEmpty?
            ListView.builder(
              shrinkWrap: true,

              primary: false,

              itemCount: jobController.rejectList.length,
              padding:EdgeInsets.zero,
              itemBuilder: (context, index) {
                return  RejectNewJob(
                    data:jobController.rejectList[index]
                );
              },
            ):noData();
        }
    );
  }


}

