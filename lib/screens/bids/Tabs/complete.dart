import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/screens/bids/components/complete_box.dart';
import 'package:provider_app/screens/bids/controller/bids_controller.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/app_text.dart';
import 'package:provider_app/widgets/back_button.dart';



class CompleteJob extends StatelessWidget {
  CompleteJob({Key? key}) : super(key: key);

  final  jobController = Get.put(BidsController());

  @override
  Widget build(BuildContext context) {
    return  Obx(
            () {
          return
            jobController.isBidLoading.value
                ? loader()
                :jobController.completeList.isNotEmpty?
            ListView.builder(
              itemCount: jobController.completeList.length,
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              itemBuilder: (context, index) {

                return  CompleteBox(
                    data:jobController.completeList[index]
                );
              },
            ):Column(
              children: [
                SizedBox(
                  height: Get.height * 0.35,
                ),
                Center(
                    child: AppText(
                      title: "No Complete Jobs",
                      color: AppColor.DARK_TEXT_COLOR,
                      fontFamily: Weights.medium,
                    )),
              ],
            );
        }
    );
  }


}

