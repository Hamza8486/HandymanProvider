import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:givestarreviews/givestarreviews.dart';
import 'package:intl/intl.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';


class ReviewBox extends StatelessWidget {
  ReviewBox({Key? key,this.data}) : super(key: key);

  var data;

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.parse(
      data.createdAt,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: Get.height*0.06,
                width: Get.height*0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(color: AppColor.primaryColor,width: 1.2)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: data.image??"" , fit: BoxFit.cover,
                    errorWidget:(context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/person.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    placeholder: (context, url) =>


                     Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        )),



                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data.name??"",
                          style:  TextStyle(
                            fontSize: 15.0,
                            color: AppColor.BLACK_COLOR,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text("${DateFormat('dd MMM yyyy').format(
                            time
                        )} ",
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: AppColors.greyColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StarRating(
                          value: 5,
                          starCount: double.parse(data.rating.toString()).toInt(),
                          size: 16,
                          spaceBetween: 1.0,
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(data.description??"",
            style: TextStyle(
              fontSize: 14.0,
              color: AppColor.BLACK_COLOR,
              fontWeight: FontWeight.w700,
            ),
          ),

        ],
      ),
    );
  }
}
