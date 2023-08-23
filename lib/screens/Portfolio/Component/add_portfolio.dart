// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/Services/helper_function.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/Loader/loader.dart';
import 'package:provider_app/widgets/SnackBar/snack_bar.dart';
import 'package:provider_app/widgets/app_button.dart';
import 'package:provider_app/widgets/app_text.dart';


class AddImages extends StatefulWidget {
  AddImages(
      {Key? key,})
      : super(key: key);

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];


  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      for (int i = 0; i < selectedImages.length; i++) {
        File file = File(selectedImages[i].path);
        int sizeInBytes = file.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        print('IMAGE SIZE : $sizeInMb');
        // if (sizeInMb > 1) {
        //   print('$i size is $sizeInMb');
        //   showSnackBar(context,'${selectedImages[i].name} is more than 1 MB');
        //   selectedImages.removeAt(i);
        // } else {
        imageFileList!.add(selectedImages[i]);
        // }
      }
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Column(
        children: [
          Material(
            color: AppColor.WHITE_COLOR,
            elevation: 1,
            child: SizedBox(
              width: size.width,
              height: size.height / 8.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.018),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.arrow_back_outlined)),
                          SizedBox(width: 20,),
                          AppText(
                              title: "Добавить фото",
                              size: size.height * 0.022,
                              overFlow: TextOverflow.ellipsis,
                              color: AppColor.DARK_TEXT_COLOR,
                              fontFamily: Weights.semi),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          DottedBorder(
            color: Colors.indigo,
            dashPattern: [8, 4],
            strokeWidth: 1.8,
            child: MaterialButton(
              color: Colors.grey,
              onPressed: () {
                selectImages();
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1, vertical: 30),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/loader.png",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppText(
                        title: "Выбрать фото",
                        fontFamily: Weights.medium,
                        color: AppColor.DARK_TEXT_COLOR,
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
              child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: imageFileList!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {

                             imageFileList
                                  ?.removeAt(index);


                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColor.primaryColor,
                                  width: 2),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    File(
                                        imageFileList![index]
                                        .path),
                                  )),
                            ),
                            child: GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: Get.height * 0.15,
                                      left: Get.width * 0.19),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColor.primaryColor)
                                    ),
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, vertical: size.height * 0.023),
            child: AppButton(
              buttonWidth: size.width,
              buttonHeight: size.height * 0.062,
              buttonName: "Добавить фото",
              buttonColor: AppColor.primaryColor,
              textSize: 16,
              textColor: AppColor.WHITE_COLOR,
              onTap: () {
               if(validate()){
                 appLoader(context, AppColor.primaryColor);
                 ApiManger().addPortfolioResp(
                   context: context,
                   image: imageFileList,
                 );
               }
              },
              buttonRadius: BorderRadius.circular(14),
            ),
          ),
        ],
      ),
    );
  }

  bool validate() {
    if (imageFileList!.isEmpty || imageFileList == null) {
      showErrorToast('Пожалуйста выберите фото');

      return false;
    }
    return true;
  }
}
