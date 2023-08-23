import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/res/app_images.dart';

import '../components/image_box.dart';


class RequestDetailController extends GetxController {

  RxInt currentIndex = 0.obs;

  List<Widget> items = [
   const ImageBox(imagePath: AppImages.jobImage),
   const ImageBox(imagePath: AppImages.jobImage),
   const ImageBox(imagePath: AppImages.jobImage),
   const ImageBox(imagePath: AppImages.jobImage),
   const ImageBox(imagePath: AppImages.jobImage),
  ];

}