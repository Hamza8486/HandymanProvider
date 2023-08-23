// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/res/app_images.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/BottomView/Jobs/controller/job_controller.dart';
import 'package:provider_app/screens/Home/view/home_view.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Dialogue/dialogue.dart';
import 'package:provider_app/widgets/Loader/loader.dart';
import 'package:provider_app/widgets/SnackBar/snack_bar.dart';
import 'package:provider_app/widgets/app_text.dart';
import 'package:provider_app/widgets/custom_button.dart';

import 'controller/request_detail_controller.dart';

class RequestDetailScreen extends StatefulWidget {
  RequestDetailScreen({Key? key, this.data}) : super(key: key);

  var data;

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  final jobController = Get.put(JobController());

  final profileController = Get.put(ProfileController());

  var priceController = TextEditingController();

  var desController = TextEditingController();

  final  detailController = Get.put(
      RequestDetailController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    desController.text = "Я готов(а) выполнить работу!";
  }



  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery
        .of(context)
        .size
        .height;
    final double width = MediaQuery
        .of(context)
        .size
        .width;
    DateTime now = DateTime.parse(widget.data.date);
    print(now);
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Column(
        children: [
          Material(
            color: AppColor.WHITE_COLOR,
            elevation: 1,
            child: SizedBox(
              width: Get.width,
              height: Get.height / 8.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.025,
                        vertical: Get.height * 0.008),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {

                            Get.back();
                          },
                          child: Container(
                            height: 35.0,
                            width: 35.0,
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColor.primaryColor),

                            ),
                            child: const Center(
                              child: Icon(Icons.arrow_back,
                                  color: AppColors.blueColor, size: 24.0),
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.02,),
                        AppText(
                          title: "О заказе",
                          size: Get.height * 0.018,
                          maxLines: 1,
                          overFlow: TextOverflow.ellipsis,
                          color: AppColor.DARK_TEXT_COLOR,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),


          Expanded(
            child: SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  widget.data.image == null ?
                  SizedBox.shrink() :
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.data.image,
                          fit: BoxFit.fill,

                          width: Get.width * 0.9,
                          height: Get.height * 0.25,

                          placeholder: (context, url) =>


                          const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.blueColor,
                              )),


                        ),


                      ),
                    ),
                  ),
                  widget.data.budget == null ? Container() :
                  const SizedBox(height: 24.0),
                  widget.data.budget == null ? Container() :
                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text('${widget.data.budget} сом',
                      style: TextStyle(
                        fontSize: Get.height*0.02,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text('Описание',
                      style: TextStyle(
                        fontSize: 17.0,

                        color: AppColors.blackColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  descText(width),
                  const SizedBox(height: 24.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text('Адрес',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: AppColors.blackColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: AppColor.primaryColor,),
                        SizedBox(width: Get.width * 0.01,),
                        Expanded(
                          child: Text(widget.data.address ?? "",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.blackColor,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text('Пользователь',
                      style: TextStyle(

                        fontSize: 16.0,
                        color: AppColors.blackColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  customerContainer(width),

                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text('Номер заказа.',
                                style: TextStyle(

                                  fontSize: 16.0,
                                  color: AppColors.blackColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(widget.data.jobNumber.toString(),
                                style: TextStyle(

                                  fontSize: 16.0,
                                  color: AppColors.blackColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text('Заказ создан',
                                style: TextStyle(

                                  fontSize: 16.0,
                                  color: AppColors.blackColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(DateFormat.yMMMMd(). format(now),
                                style: TextStyle(

                                  fontSize: 16.0,
                                  color: AppColors.blackColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomButton(
                    onTap:



                        () {
                      if(profileController.businessData == null){
                        showErrorToast( "Создайте профиль специалиста, чтобы откликатья на заказы");
                        Get.offAll(PersisNavBar(currentIndex: 2));
                      }
                      else if(
                      profileController.businessData?.status == "0"
                      ){
                        showErrorToast( "Пожалуйста подождите активации профиля");
                      }
                      else{
                        Get.bottomSheet(
                          budgetSheet(context: context),
                          enableDrag: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                        );
                      }

                    },
                    width: width,
                    textColor: Colors.white,
                    btnColor: AppColors.blueColor,
                    btnText: 'Откликнуться',
                  ),
                ),

                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomButton(
                    onTap:


                        () {
                      if(profileController.businessData == null){
                        showErrorToast( "Пожалуйста создайте профиль специалиста");
                        Get.offAll(PersisNavBar(currentIndex: 2));
                      }
                      else if(
                      profileController.businessData?.status == "0"
                      ){
                        showErrorToast( "Пожалуйста подождите модерации профиля");

                      }
                      else{
                        showAlertDialog(context: context,
                            text: "Вы хотите отказаться от заказа...??",
                            yesOnTap: () {
                              Get.back();
                              appLoader(context, AppColor.primaryColor);
                              ApiManger().rejectBidResponse(
                                  id: profileController.userId.value,
                                  idJob: jobController.jobId.value.toString()
                              );
                            }
                        );
                      }

                    },
                    width: width,
                    btnText: 'Отказаться',
                    textColor: AppColors.redColor,
                    borderColor: AppColors.redColor,
                    borderWidth: 1.5,
                    btnColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) =>
      Obx(() =>
          Container(
            height: 8,
            width: 8,
            margin: const EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: detailController.currentIndex.value == index
                  ? AppColors.blackColor : AppColors.greyColor,
            ),
          ));

  Widget descText(width) =>
      Container(
        width: width,
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: Text(widget.data.description,
          style: TextStyle(
            fontSize: 15.0,
            color: AppColors.blackColor,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  Widget addressContainer(width, height) =>
      Container(
        width: width,
        height: height * 0.16,
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.3),
              blurRadius: 3.0,
              offset: Offset(3.0, 3.0),
            ),
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.3),
              blurRadius: 3.0,
              offset: Offset(-3.0, -3.0),
            ),
          ],
          image: const DecorationImage(
            image: AssetImage(AppImages.mapImage),
            fit: BoxFit.fill,
          ),
        ),
        child: const Center(
          child: Chip(
            label: Text('Open on Map',
              style: TextStyle(
                fontSize: 16.0,
                color: AppColors.blueColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            avatar: Icon(
                Icons.location_on, color: AppColors.blueColor, size: 16.0),
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
        ),
      );

  Widget categoryContainer(width) =>
      Container(
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                          () {
                        return Text(jobController.name.value,
                          style: TextStyle(
                            fontSize: 17.0,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }
                  ),
                  SizedBox(height: 10.0),
                  Text('Requests from this category',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget customerContainer(width) =>
      Container(
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.primaryColor, width: 2)
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.data.customer==null?"":

                    widget.data.customer.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, exception, stackTrace) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/persons.jpg",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.data.customer==null?"":
                    widget.data.customer.firstName,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.blackColor,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('(${widget.data.reviews.toString()} отзывов)',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget budgetSheet({required BuildContext context}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24.0),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text('Какую цену вы предлагаете?',
              style: TextStyle(
                fontSize: 18.0,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColors.greyColor.withOpacity(0.4),
                border: Border.all(
                  color: AppColors.blueColor,
                  width: 1.5,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 16.0),
                  const Text('от',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      //controller: bidsController.fromController,
                      keyboardType: TextInputType.number,

                      controller: priceController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            bottom: 16.0, top: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  const Text('сом',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 16.0),

                ],
              ),
            ),
          ),

          const SizedBox(height: 16.0),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text('Комментарии',
              style: TextStyle(
                fontSize: 18.0,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              // controller: bidsController.commentController,
              maxLines: 5,
              controller: desController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 24.0),
                hintText: 'Я готов(а) выполнить работу!',
                hintStyle: const TextStyle(
                  fontSize: 14.0,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 24.0),
            child: ElevatedButton(
              onPressed: () {
                print("object");
                if (validate()) {
                  appLoader(context, AppColor.primaryColor);
                  ApiManger().placeBidResponse(
                      id: profileController.userId.value.toString(),
                      custId: widget.data.customer.id.toString(),
                      price: priceController.text,
                      jobId: jobController.jobId.value.toString(),
                      des: desController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(Get.width, 50.0),
                primary: AppColors.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Center(
                child: Text('Отправить',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  bool validate() {
    if (priceController.text.isEmpty) {
      Get.snackbar("Наишите цену услуги", "",
          colorText: AppColor.BLACK_COLOR,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.BOTTOM);

      return false;
    }
    return true;
  }
}