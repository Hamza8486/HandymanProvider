// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/res/app_images.dart';
import 'package:provider_app/screens/bids/components/chat_with_customer.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';

import '../../../res/app_colors.dart';

class RejectBox extends StatelessWidget {
  RejectBox({Key? key,this.data}) : super(key: key);
  var data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

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
                    image:  DecorationImage(
                      image: AssetImage("assets/images/persons.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                )

                ,
                SizedBox(width: 16.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            SizedBox(
                              width:Get.width*0.3,
                              child: Text(data.description,
                                maxLines: 1,
                                style:  TextStyle(
                                  fontSize: 15.0,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(width: 4.0),
                            Expanded(
                              child: Text("(Отменен)",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.red,
                                  fontFamily: Weights.bold,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text("${data.budget??""}.0",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.redColor,
                  ),
                  child:  Center(
                    child: Text(data.id.toString(),
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
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
