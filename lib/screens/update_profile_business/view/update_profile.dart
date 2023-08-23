

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/update_profile_business/controller/controller.dart';
import 'package:provider_app/screens/update_profile_business/model/update_model.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/Loader/loader.dart';
import 'package:provider_app/widgets/SnackBar/snack_bar.dart';
import 'package:provider_app/widgets/app_text.dart';
import 'package:provider_app/widgets/custom_button.dart';



class UpdateEditBusinessProfile extends StatefulWidget {
  UpdateEditBusinessProfile({Key? key,this.data}) : super(key: key);

  var data;

  @override
  State<UpdateEditBusinessProfile> createState() => _UpdateEditBusinessProfileState();
}

class _UpdateEditBusinessProfileState extends State<UpdateEditBusinessProfile> {
  TextEditingController emailController = TextEditingController();

  clear(){
    updateController.serviceController.clear();
    updateController.priceController.clear();
    updateController.updatePriceId("");
    updateController.updateServiceName("");
  }
  final profileController = Get.put(ProfileController());
  final updateController = Get.put(UpdatePageController());
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  handleChooseFromGallery() async {
    Navigator.pop(context);
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 30);
    setState(() {
      if (image != null) {
        profileController.file3 = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  handleTakePhoto() async {
    Navigator.pop(context);
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 30);
    setState(() {
      if (image != null) {
        profileController.file3 = File(image.path);
      } else {
        print('Фото не выбрано.');
      }
    });
  }

  clearImage() {
    setState(() {});
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              "Выберите фото",
            ),
            backgroundColor: Colors.white,
            children: <Widget>[
              SimpleDialogOption(
                child: const Text(
                  "Камера",
                ),
                onPressed: handleTakePhoto,
              ),
              SimpleDialogOption(
                child: Text("Галерея"),
                onPressed: handleChooseFromGallery,
              ),
              SimpleDialogOption(
                child: Text("Отмена"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data.services!.isNotEmpty) {
      print(widget.data.services);
      updateController.addLocItem.clear();
      for (int i = 0; i < widget.data.services!.length; i++) {

        updateController.addLocItem.add(UpdateCatModel(
          id: widget.data.services![i].id.toString() ,
          name: widget.data.services![i].name.toString() ,
          price: widget.data.services![i].price.toString(),
          idObject: widget.data.services![i].objectId.toString(),


        ));
      }
    }
    setState(() {
      nameController.text = widget.data.name??"";
      emailController.text = widget.data.aboutMe??"";
    });
  }


  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    var size = Get.size;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,

      body: Column(
        children: [
          Material(
            color: AppColor.WHITE_COLOR,
            elevation: 1,
            child: SizedBox(
              width: size.width,
              height: size.height / 8.5 ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.018 ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
                      child:    Row(
                        children: [
                          GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: Icon(Icons.arrow_back_outlined)),
                          SizedBox(width: 20,),
                          AppText(
                              title: "Изменить профиль",
                              size: size.height * 0.02,
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.15,
                    child: Stack(
                      children: [
                        Center(
                          child: Material(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    MediaQuery.of(context).size.height * 0.1)),
                                side:
                                BorderSide(color: AppColors.blueColor)),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.1))),
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1000)),
                                  child: widget.data.image != null
                                      ? Image.network(
                                    widget.data.image,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.file(profileController.file3 as File,fit: BoxFit.cover,)


                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            left: size.width * 0.56,
                            top: size.height * 0.1,
                            child: InkWell(
                              onTap: () => selectImage(context),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColors.blueColor,
                                child: Icon(
                                  Icons.add,
                                  color: AppColor.WHITE_COLOR,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 36.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Имя, фамилия',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.person,
                              color: AppColors.blueColor),
                        ),
                        contentPadding: EdgeInsets.only(top: 16.0, left: 0.0),
                        prefixStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.blackColor,
                        ),
                        hintText: 'Напишите имя и фамилию',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'О себе',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.description,
                              color: AppColors.blueColor),
                        ),
                        contentPadding: EdgeInsets.only(top: 16.0, left: 0.0),
                        prefixStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.blackColor,
                        ),
                        hintText: 'description',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: Get.height * 0.03,
                  // ),
                  // const Padding(
                  //   padding: EdgeInsets.only(left: 24.0),
                  //   child: Text(
                  //     'Select Multiple Service',
                  //     style: TextStyle(
                  //       fontSize: 16.0,
                  //       color: AppColors.blackColor,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 8.0),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: Get.width*0.04),
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10)
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 10),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         SizedBox(
                  //           height: Get.height * 0.015,
                  //         ),
                  //         AppText(
                  //           title: "Select Service *",
                  //           size: Get.height*0.016,
                  //           fontFamily: Weights.semi,
                  //           fontWeight: FontWeight.w600,
                  //           color: AppColor.DARK_TEXT_COLOR,
                  //         ),
                  //         SizedBox(
                  //           height: Get.height * 0.01,
                  //         ),
                  //
                  //         AppTextFied(
                  //           fillColor: Colors.transparent,
                  //           isFill: true,
                  //           controller: updateController.serviceController,
                  //           isReadOnly: true,
                  //           onTap: () {
                  //             showModalBottomSheet(
                  //                 backgroundColor: Colors.transparent,
                  //                 isScrollControlled: true,
                  //                 isDismissible: true,
                  //                 context: context,
                  //                 builder: (context) => const UpdateService());
                  //           },
                  //           isborderline: true,
                  //           isSuffix: true,
                  //           isShowCursor: false,
                  //           suffixIcon: Icon(Icons.arrow_drop_down),
                  //           borderColor: AppColor.DARK_TEXT_COLOR,
                  //           isborderline2: true,
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: Get.width * 0.04,
                  //               vertical: Get.height * 0.01),
                  //           isVisible: true,
                  //           autovalidateMode: AutovalidateMode.onUserInteraction,
                  //           fontFamily: Weights.medium,
                  //           borderRadius: BorderRadius.circular(10),
                  //           borderRadius2: BorderRadius.circular(10),
                  //           hint: "Select Service",
                  //           hintColor: AppColor.DARK_TEXT_COLOR,
                  //           borderColor2: AppColor.DARK_TEXT_COLOR,
                  //           maxLines: 1,
                  //           hintSize: Get.height*0.015,
                  //         ),
                  //         SizedBox(
                  //           height: Get.height * 0.02,
                  //         ),
                  //         AppText(
                  //           title: "Price *",
                  //           size: Get.height*0.016,
                  //           fontFamily: Weights.semi,
                  //           fontWeight: FontWeight.w600,
                  //           color: AppColor.DARK_TEXT_COLOR,
                  //         ),
                  //         SizedBox(
                  //           height: Get.height * 0.01,
                  //         ),
                  //         Row(
                  //           children: [
                  //             Expanded(
                  //               child:   AppTextFied(
                  //                 fillColor: Colors.transparent,
                  //                 isFill: true,
                  //                 controller: updateController.priceController,
                  //
                  //                 onChange: (val) {
                  //                   if (int.parse(val.toString()) <= 0){
                  //                     setState(() {
                  //                       updateController.priceController.clear();
                  //                     });
                  //                   }
                  //                 },
                  //
                  //                 isborderline: true,
                  //                 isSuffix: true,
                  //                 isShowCursor: true,
                  //
                  //                 borderColor: AppColor.DARK_TEXT_COLOR,
                  //                 isborderline2: true,
                  //                 padding: EdgeInsets.symmetric(
                  //                     horizontal: Get.width * 0.04,
                  //                     vertical: Get.height * 0.01),
                  //                 isVisible: true,
                  //                 autovalidateMode: AutovalidateMode.onUserInteraction,
                  //                 fontFamily: Weights.medium,
                  //                 textInputType: TextInputType.phone,
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 borderRadius2: BorderRadius.circular(10),
                  //                 hint: "Enter Price",
                  //                 textInputAction: TextInputAction.done,
                  //                 hintColor: AppColor.DARK_TEXT_COLOR,
                  //                 borderColor2: AppColor.DARK_TEXT_COLOR,
                  //                 maxLines: 1,
                  //                 hintSize: Get.height*0.015,
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: Get.width * 0.03,
                  //             ),
                  //             Obx(() {
                  //               return addButton(
                  //                   color: updateController
                  //                       .priceServiceId.value.isEmpty
                  //                       ? AppColor.primaryColor
                  //                       : AppColor.primaryColor,
                  //                   onTap: () {
                  //                     var contains = updateController.addLocItem
                  //                         .where((p0) =>
                  //                     p0.id ==
                  //                         updateController.priceServiceId.value);
                  //
                  //
                  //                       UpdateCatModel appointModel =
                  //                       UpdateCatModel(
                  //
                  //                         id: updateController
                  //                             .priceServiceId.value,
                  //                         price: updateController.priceController.text,
                  //                         name:
                  //                         updateController.serviceName.value,
                  //
                  //                       );
                  //                       if (contains.isEmpty) {
                  //                         updateController.addLocItem
                  //                             .add(appointModel);
                  //                        clear();
                  //                       } else {
                  //                         showErrorToast( "Service Already Added");
                  //                       }
                  //
                  //                   });
                  //             })
                  //           ],
                  //         ),
                  //         SizedBox(
                  //           height: Get.height * 0.015,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Obx(() {
                  //   return updateController.addLocItem.isEmpty
                  //       ? Container()
                  //       : SizedBox(
                  //     height: Get.height * 0.02,
                  //   );
                  // }),
                  // Obx(() {
                  //   return updateController.addLocItem.isEmpty
                  //       ? Container()
                  //       : SizedBox(
                  //     height: Get.height * 0.04,
                  //     child: Padding(
                  //       padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                  //       child: ListView.builder(
                  //           itemCount:
                  //           updateController.addLocItem.length,
                  //           scrollDirection: Axis.horizontal,
                  //           itemBuilder:
                  //               (BuildContext context, int index) {
                  //             return GestureDetector(
                  //               onTap: () {
                  //                 updateController.addLocItem
                  //                     .removeAt(index);
                  //                 updateController.selectList.add(updateController
                  //                     .addLocItem[index].idObject);
                  //               },
                  //               child: Container(
                  //                 margin: EdgeInsets.symmetric(
                  //                     horizontal: index == 0 ? 0 : 12),
                  //                 decoration: BoxDecoration(
                  //                     borderRadius:
                  //                     BorderRadius.circular(6),
                  //                     border: Border.all(
                  //                       color: AppColor.primaryColor,
                  //                     )),
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(6.0),
                  //                   child: Row(
                  //                     children: [
                  //                       AppText(
                  //                         title: updateController
                  //                             .addLocItem[index].name??"",
                  //                         overFlow: TextOverflow.ellipsis,
                  //                         maxLines: 1,
                  //                         textAlign: TextAlign.center,
                  //                         color: AppColor.DARK_TEXT_COLOR,
                  //                         size: Get.height*0.014,
                  //                         fontFamily: Weights.semi,
                  //                       ),
                  //                       AppText(
                  //                         title: " - ",
                  //                         color: AppColor.DARK_TEXT_COLOR,
                  //                         size: Get.height*0.013,
                  //                         fontFamily: Weights.medium,
                  //                       ),
                  //                       AppText(
                  //                         title: updateController
                  //                             .addLocItem[index]
                  //                             .price,
                  //                         color: AppColor.DARK_TEXT_COLOR,
                  //                         size: Get.height*0.014,
                  //                         fontFamily: Weights.semi,
                  //                       ),
                  //                       const SizedBox(
                  //                         width: 6,
                  //                       ),
                  //                       Icon(
                  //                         Icons.cancel,
                  //                         color: AppColor.DARK_TEXT_COLOR,
                  //                         size: Get.height * 0.02,
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  //           }),
                  //     ),
                  //   );
                  // }),


                ],
              ),
            ),
          ),
          isKeyBoard?SizedBox.shrink(): SizedBox(height: 10.0),
          isKeyBoard?SizedBox.shrink():
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomButton(
              onTap: (){
                if(validateUpdate()){
                  appLoader(context, AppColors.blueColor);

                  ApiManger().updateBusProfile(
                      appointment: List<dynamic>.from(
                          updateController.addLocItem.map((e) => e.toMap())),

                      name: nameController.text,
                      about: emailController.text,
                      context: context
                  );
                }


              },
              width: width,
              height: 55.0,
              btnColor: AppColors.blueColor,
              btnText: 'Обновить профиль',
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  bool validateUpdate() {
    if (nameController.text.isEmpty) {
      showErrorToast( 'Пожалуйста имя');

      return false;
    }

    return true;
  }
}