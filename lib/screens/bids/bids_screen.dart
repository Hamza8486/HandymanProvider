// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/screens/bids/Tabs/active.dart';
import 'package:provider_app/screens/bids/Tabs/complete.dart';
import 'package:provider_app/screens/bids/Tabs/reject.dart';
import 'package:provider_app/screens/bids/controller/bids_controller.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/app_text.dart';



class BidsScreen extends StatefulWidget {
  const BidsScreen({Key? key}) : super(key: key);

  @override
  State<BidsScreen> createState() => _BidsScreenState();
}

class _BidsScreenState extends State<BidsScreen> {
  final bidController = Get.put(BidsController());
  Future<void> _pullRefresh() async {

    setState(() {
      bidController.bidData(bidController.userId.value);
    });
  }
  final select = Get.put(SelectTab());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh:_pullRefresh ,
        child: Column(
          children: [
            Material(
              color: AppColor.WHITE_COLOR,
              elevation: 1,
              child: SizedBox(
                width: Get.width,
                height: Get.height / 8.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.02,
                          vertical: Get.height * 0.018),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                                title: "Отклики и чаты",
                              size: Get.height * 0.018,
                              overFlow: TextOverflow.ellipsis,
                              color: AppColor.DARK_TEXT_COLOR,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,),
                            GestureDetector(
                              onTap: (){
                                bidController.bidData(bidController.userId.value);
                              },
                              child: Icon(Icons.refresh,
                              color: AppColor.DARK_TEXT_COLOR,
                                size: Get.height*0.03,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),



            Obx(
                    () {
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15),
                    child: Material(


                      shape: RoundedRectangleBorder(    borderRadius: BorderRadius.circular(10),

                          side: BorderSide(color: AppColor.BLACK_COLOR.withOpacity(0.2))
                      ),

                      child: SizedBox(
                          width: Get.width,


                          height: Get.height * 0.06,
                          child:    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                tabBusinessList(
                                  text: "Активные",
                                  onTap: () {
                                    select.updateTab(0);
                                  },
                                  color: !(select.tab.value == 0)
                                      ? AppColor.WHITE_COLOR
                                      : AppColor.primaryColor,
                                  color1: !(select.tab.value == 0)
                                      ? AppColor.BLACK_COLOR
                                      : AppColor.WHITE_COLOR,
                                ),

                                tabBusinessList(
                                  text: "Завершен",
                                  onTap: () {
                                    select.updateTab(1);
                                  },
                                  color: !(select.tab.value == 1)
                                      ? AppColor.WHITE_COLOR
                                      : AppColor.primaryColor,
                                  color1: !(select.tab.value == 1)
                                      ? AppColor.BLACK_COLOR
                                      : AppColor.WHITE_COLOR,
                                ),

                                tabBusinessList(
                                  text: "Отменен",
                                  onTap: () {
                                    select.updateTab(2);
                                  },
                                  color: !(select.tab.value == 2)
                                      ? AppColor.WHITE_COLOR
                                      : AppColor.primaryColor,
                                  color1: !(select.tab.value == 2)
                                      ? AppColor.BLACK_COLOR
                                      : AppColor.WHITE_COLOR,
                                ),

                              ],
                            ),
                          )
                      ),
                    ),
                  );
                }
            ),

            Obx(
                    () {
                  return
                     Expanded(child: select.tab.value == 0? Active():select.tab.value == 1?
                    CompleteJob():
                    RejectJobList(),

                    );

                }
            )
          ],
        ),
      ),
    );
  }
}
Widget tabBusinessList({text, color, color1, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.06, vertical: 10),
        child: Center(
          child: AppText(
            title: text,
            color: color1,
            size: Get.height*0.015,
            fontFamily: Weights.semi,
          ),
        ),
      ),
    ),
  );
}


class SelectTab extends GetxController {
  var tab = 0.obs;
  var timer = 0.obs;

  var text = "Deal Of The Day ".obs;
  RxBool isActive = true.obs;

  updateTab(val) {
    tab.value = val;

    update();
  }
  var isLoading = false.obs;

  updateTime(val) {
    timer.value = val;

    update();
  }

  toggleActiveStatus() {
    isActive.toggle();
    update();
  }



}