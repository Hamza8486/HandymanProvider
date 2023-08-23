// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider_app/res/app_images.dart';
import 'package:provider_app/screens/bids/components/chat_with_customer.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';

import '../../../res/app_colors.dart';

class CompleteBox extends StatelessWidget {
  CompleteBox({Key? key,this.data}) : super(key: key);
  var data;

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.parse(
      data.job.date,
    );
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
                data.customer.image == null?
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

                    :  Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueColor),
                    borderRadius: BorderRadius.circular(10.0),
                    image:  DecorationImage(
                      image: NetworkImage(data.customer.image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
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
                            Text("${
                                data.customer==null?"":
                                data.customer.firstName} ${
                                data.customer==null?"":

                                data.customer.lastName}",
                              style:  TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 4.0),
                            Expanded(
                              child: Text("(Выполнен)",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.green,
                                  fontFamily: Weights.bold,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on_outlined,color: AppColors.blackColor,
                            size: 20,
                            ),
                            SizedBox(width: Get.width*0.01,),
                            SizedBox(
                              width: Get.width*0.5,
                              child: Text(
                                data==null?"":data.job==null?"":data.job.address==null?"":
                                data.job.address??"",
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox.shrink()

              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Text(
                  "Заказ создан : ",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyyy').format(time),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Text(
                  "Бюджет : ",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                    data.price==null?"":

                  data.price.toString(),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
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
