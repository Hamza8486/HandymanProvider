import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/screens/bids/components/bids_box.dart';
import 'package:provider_app/screens/bids/controller/bids_controller.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/app_text.dart';
import 'package:provider_app/widgets/back_button.dart';

class Active extends StatelessWidget {
  Active({Key? key}) : super(key: key);

  final jobController = Get.put(BidsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return jobController.isBidLoading.value
          ? loader()
          : jobController.activeList.isNotEmpty
              ? ListView.builder(
                  itemCount: jobController.activeList.length,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  itemBuilder: (context, index) {
                    // print(jsonEncode(jobController.activeList[index]));
                    // print(jsonEncode(P));

                    return BidsBox(data: jobController.activeList[index]);
                  },
                )
              : Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.35,
                    ),
                    Center(
                        child: AppText(
                      title: "No Active Bids",
                      color: AppColor.DARK_TEXT_COLOR,
                      fontFamily: Weights.medium,
                    )),
                  ],
                );
    });
  }
}
