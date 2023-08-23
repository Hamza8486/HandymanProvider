// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/Services/helper_function.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/BottomView/Jobs/controller/job_controller.dart';
import 'package:provider_app/screens/BottomView/Profile/components/sub_cat_LIST.dart';
import 'package:provider_app/screens/BottomView/Profile/controller/account_controller.dart';
import 'package:provider_app/screens/BottomView/Support/controller/support_controller.dart';

import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/ImagePickerSheet.dart';
import 'package:provider_app/widgets/Loader/loader.dart';
import 'package:provider_app/widgets/SnackBar/snack_bar.dart';
import 'package:provider_app/widgets/app_text.dart';
import 'package:provider_app/widgets/custom_button.dart';

import '../../res/app_colors.dart';

import 'controller/verification_page_controller.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final pageController = Get.put(VerificationPageController());
  final profileController = Get.put(ProfileController());
  final addServiceController = Get.put(ProfilePageController());
  final jobController = Get.put(JobController());

  clear() {
    addServiceController.serviceController.clear();
    addServiceController.priceController.clear();
    addServiceController.updatePriceId("");
    addServiceController.updateServiceName("");
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    var size = Get.size;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
                        horizontal: Get.width * 0.04,
                        vertical: Get.height * 0.018),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back_outlined)),
                        SizedBox(
                          width: 20,
                        ),
                        AppText(
                            title: "Создать профиль специалиста",
                          size: Get.height * 0.018,
                          overFlow: TextOverflow.ellipsis,
                          color: AppColor.DARK_TEXT_COLOR,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (builder) => bottomSheet(onCamera: () {
                                Navigator.pop(context);
                                HelperFunctions.pickImage(
                                        ImageSource.camera, context)
                                    .then((value) {
                                  setState(() {
                                    profileController.file = value;
                                    debugPrint(
                                        profileController.file.toString());
                                  });
                                });
                              }, onGallery: () {
                                Navigator.pop(context);

                                HelperFunctions.pickImage(
                                        ImageSource.gallery, context)
                                    .then((value) {
                                  setState(() {
                                    profileController.file = value;
                                    debugPrint(
                                        profileController.file.toString());
                                  });
                                });
                              }));
                    },
                    child: SizedBox(
                      width: Get.width,
                      height: Get.height * 0.14,
                      child: Stack(
                        children: [
                          Center(
                            child: Material(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.1)),
                                  side:
                                      BorderSide(color: AppColor.primaryColor)),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.14,
                                width:
                                    MediaQuery.of(context).size.height * 0.14,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            MediaQuery.of(context).size.height *
                                                0.1))),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(1000)),
                                    child: profileController.file == null
                                        ? Image.asset(
                                            "assets/images/persons.jpg",
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            profileController.file as File,
                                            fit: BoxFit.cover,
                                          )),
                              ),
                            ),
                          ),
                          Positioned(
                              left: Get.width * 0.53,
                              top: Get.height * 0.1,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (builder) => bottomSheet(onCamera: () {
                                        Navigator.pop(context);
                                        HelperFunctions.pickImage(
                                            ImageSource.camera, context)
                                            .then((value) {
                                          setState(() {
                                            profileController.file = value;
                                            debugPrint(
                                                profileController.file.toString());
                                          });
                                        });
                                      }, onGallery: () {
                                        Navigator.pop(context);

                                        HelperFunctions.pickImage(
                                            ImageSource.gallery, context)
                                            .then((value) {
                                          setState(() {
                                            profileController.file = value;
                                            debugPrint(
                                                profileController.file.toString());
                                          });
                                        });
                                      }));
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: AppColor.primaryColor,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Имя, Фамилия',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  nameField(width),
                  const SizedBox(height: 24.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(
                      'О себе',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  lastNameField(width),
                  const SizedBox(height: 24.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Дата рождения',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    height: 50.0,
                    width: Get.width,
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      onTap: () async{
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialEntryMode: DatePickerEntryMode.calendarOnly,

                            builder: (BuildContext? context,
                                Widget? child) {
                              return Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    width: 350.0,
                                    height: 500.0,
                                    child: Theme(
                                      data: ThemeData.light().copyWith(
                                        primaryColor:
                                        AppColor.DARK_TEXT_COLOR,

                                        colorScheme: ColorScheme.light(
                                          primary:
                                          AppColor.DARK_TEXT_COLOR,),
                                        buttonTheme: ButtonThemeData(
                                            buttonColor:
                                            AppColor.primaryColor),
                                      ),
                                      child: child!,
                                    ),
                                  ));
                            },
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2050),
                          locale:  Locale("ru", "RU"),
                        );


                        if (pickedDate != null) {
                          pageController.dayController.text =
                              DateFormat('yyyy-MM-dd')
                                  .format(pickedDate);
                        }
                      },
                      readOnly: true,
                      showCursor: false,
                      controller: pageController.dayController,
                      style: TextStyle(fontFamily: Weights.medium),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
                        hintText: 'Выберите дату рождения',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Выбрать специальности',
                      style: TextStyle(
                        fontSize: 15.0,

                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                Obx(
                  () {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: jobController.catListAll.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) =>  SubCatViewList(data:jobController.catListAll[index]));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 9
                                 ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  border: Border.all(color: AppColor.primaryColor,width: 0.5)
                                ),

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                                    child: Center(child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          jobController.catListAll[index].name,
                                          style: TextStyle(
                                            fontSize: 15.0,

                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 15,),
                                        Icon(Icons.arrow_drop_down,color: AppColors.blackColor,
                                        size: Get.height*0.023,
                                        )
                                      ],
                                    ),),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    );
                  }
                ),

                  Obx(
                    () {
                      return  SizedBox(height:
                      profileController.selectName.isEmpty?8:

                      8.0);
                    }
                  ),
                  Obx(
                    () {
                      return
                        profileController.selectName.isNotEmpty?

                        SizedBox(
                        height: Get.height * 0.07,
                        child:


                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              itemCount: profileController.selectName.length,
                              itemBuilder: (context, index) {
                                return Obx(
                                  () {
                                    return GestureDetector(
                                      onTap: () {
                                        // Get.to(SubCategoryPage(
                                        //   data: profileController.selectName[index],
                                        // ));
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: index == 0 ? 20.0 : 10,
                                              right:    profileController.selectName.isNotEmpty?8:    8.0,
                                              top: 6.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.0),
                                            border: Border.all(color: AppColor.primaryColor),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  profileController.selectName[index]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.blackColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 14,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      profileController.selectName
                                                          .removeAt(index);
                                                    },
                                                    child: Icon(Icons.delete_outline,
                                                        color: AppColors.blueColor))
                                              ],
                                            ),
                                          )),
                                    );
                                  }
                                );
                              },
                            )
                      ):SizedBox.shrink();
                    }
                  ),

                  SizedBox(height: 24.0),
                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Загрузите фото паспорта',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Передняя сторона*',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.008,
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (builder) =>
                                          bottomSheet(onCamera: () {
                                            Navigator.pop(context);
                                            HelperFunctions.pickImage(
                                                    ImageSource.camera, context)
                                                .then((value) {
                                              setState(() {
                                                profileController.file1 =
                                                    value!;
                                              });
                                            });
                                          }, onGallery: () {
                                            Navigator.pop(context);
                                            HelperFunctions.pickImage(
                                                    ImageSource.gallery,
                                                    context)
                                                .then((value) {
                                              setState(() {
                                                profileController.file1 =
                                                    value!;
                                              });
                                            });
                                          }));
                                },
                                child: Container(
                                  width: size.width,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.greyColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: profileController.file1 == null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            "assets/fonts/front.png",
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            profileController.file1 as File,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Задняя сторона*',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.008,
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (builder) =>
                                          bottomSheet(onCamera: () {
                                            Navigator.pop(context);
                                            HelperFunctions.pickImage(
                                                    ImageSource.camera, context)
                                                .then((value) {
                                              setState(() {
                                                profileController.file2 =
                                                    value!;
                                              });
                                            });
                                          }, onGallery: () {
                                            Navigator.pop(context);
                                            HelperFunctions.pickImage(
                                                    ImageSource.gallery,
                                                    context)
                                                .then((value) {
                                              setState(() {
                                                profileController.file2 =
                                                    value!;
                                              });
                                            });
                                          }));
                                },
                                child: Container(
                                  width: size.width,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.greyColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: profileController.file2 == null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            "assets/fonts/back.png",
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            profileController.file2 as File,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    width: width,
                    margin: const EdgeInsets.symmetric(horizontal: 40.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 16.0),
                    decoration: BoxDecoration(
                      color: AppColors.blueColor.withOpacity(0.1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.verified_user,
                            color: Colors.green, size: 32.0),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 12.0),
                            child: Text(
                              'Ваши данные нигде не будут использованы. Требуется только для подтверждения личности.',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: AppColors.blueColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          isKeyBoard ? SizedBox.shrink() : const SizedBox(height: 10.0),
          isKeyBoard
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, bottom: 16.0, right: 24.0),
                  child: CustomButton(
                    onTap: () {
                      if (validateAll()) {
                        appLoader(context, AppColor.primaryColor);

                        ApiManger().createProfile(
                          context: context,
                          appointment: List<dynamic>.from(addServiceController
                              .addLocItem
                              .map((e) => e.toMap())),
                          name: pageController.nameController.text,
                          about: pageController.aboutController.text,
                        );
                      }
                    },
                    width: width,
                    btnText: 'Создать',
                    btnColor: AppColors.blueColor,
                  ),
                ),
        ],
      ),
    );
  }

  bool validateItems() {
    if (addServiceController.priceServiceId.value.isEmpty) {
      showErrorToast("Выберите услугу");
      return false;
    }
    if (addServiceController.priceController.text.isEmpty) {
      showErrorToast("Напишите цену");
      return false;
    }

    return true;
  }

  bool validateAll() {
    if (profileController.file == null) {
      showErrorToast('Требуется фото');

      return false;
    }
    if (pageController.nameController.text.isEmpty) {
      showErrorToast('Напишите Имя, фамилию');

      return false;
    }
    if (pageController.aboutController.text.isEmpty) {
      showErrorToast('Напишите о себе');

      return false;
    }
    if (pageController.dayController.text.isEmpty &&
        pageController.monthController.text.isEmpty &&
        pageController.yearController.text.isEmpty) {
      showErrorToast('Укажите дату рождения');

      return false;
    }
    if (profileController.selectName.isEmpty) {
      showErrorToast('Выберите специальность');

      return false;
    }
    if (profileController.file1 == null) {
      showErrorToast('Требуется фото паспорта, передняя часть');

      return false;
    }
    if (profileController.file2 == null) {
      showErrorToast('Требуется фото паспорта, задняя часть');

      return false;
    }
    return true;
  }

  Widget nameField(width) => Container(
        height: 50.0,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: TextFormField(
          controller: pageController.nameController,
          style: TextStyle(fontFamily: Weights.medium),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 16.0),
            hintText: 'Напишите имя, фамилию',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
              fontSize: 14.0,
            ),
          ),
        ),
      );

  Widget lastNameField(width) => Container(
        height: 50.0,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: TextFormField(
          maxLines: 3,
          controller: pageController.aboutController,
          style: TextStyle(fontFamily: Weights.medium),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
            hintText: 'Напишите немного о себе',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
              fontSize: 14.0,
            ),
          ),
        ),
      );





}
