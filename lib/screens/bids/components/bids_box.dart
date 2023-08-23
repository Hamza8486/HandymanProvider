import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/bids/components/chat_with_customer.dart';

import '../../../res/app_colors.dart';

class BidsBox extends StatelessWidget {
  BidsBox({Key? key, this.data}) : super(key: key);
  var data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
      data.status == "3"?(){}:

          () async {
        Get.put(ProfileController()).updateUser(data.customer.id.toString());
        Get.put(ProfileController()).updateJob(data.jobId.toString());
        ApiManger().getAllNoti(job: data.jobId);
        Get.put(ProfileController()).chatData();
            Get.to(ChatWithCustomer(
                      data: data,
                    ));

      },
      child: Container(
        margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.2),
              blurRadius: 3.0,
              offset: const Offset(5.0, 0.0),
            ),
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.2),
              blurRadius: 3.0,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueColor),
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage("assets/images/persons.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                    data.job==null?"":
                    data.job.subName==null?"":
                              data.job.subName.toString(),
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: Get.height*0.016,
                                color: AppColors.blackColor,
                                overflow: TextOverflow.ellipsis,

                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),

                              textAlign: TextAlign.start,
                            ),
                            (Get.put(ProfileController())
                                .notificationList
                                .where((element) {
                              if(element.jobId == data.jobId)
                              {

                              }


                              return element.jobId == data.jobId;
                            })
                                .toList()).isNotEmpty?


                            Container(
                              height: 10.0,
                              width: 10.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.redColor,
                              ),

                            ):SizedBox.shrink(),
                          ],
                        ),
                        SizedBox(height: Get.height*0.01,),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            data.job==null?"":
                            data.job.description  ==null?"I am ready for do this job " :   data.job.description ,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: Get.height*0.015,
                              color: AppColors.blackColor,
                              overflow: TextOverflow.ellipsis,

                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
