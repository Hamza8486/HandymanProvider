import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/Portfolio/Component/add_portfolio.dart';
import 'package:provider_app/screens/Portfolio/Controller/controller.dart';
import 'package:provider_app/screens/bids/components/bid_button.dart';
import 'package:provider_app/screens/update_profile_business/component/service.dart';
import 'package:provider_app/screens/update_profile_business/controller/controller.dart';
import 'package:provider_app/screens/update_profile_business/model/update_model.dart';
import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/Loader/loader.dart';
import 'package:provider_app/widgets/SnackBar/snack_bar.dart';
import 'package:provider_app/widgets/app_button.dart';
import 'package:provider_app/widgets/app_field.dart';
import 'package:provider_app/widgets/app_text.dart';



class ServicesView extends StatefulWidget {
  ServicesView({Key? key}) : super(key: key);

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {

  final portController = Get.put(PortfolioController());
  final profileController = Get.put(ProfileController());
  final updateController = Get.put(UpdatePageController());
  clear(){
    updateController.serviceController.clear();
    updateController.priceController.clear();
    updateController.updatePriceId("");
    updateController.updateServiceName("");
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      nameController.text = profileController.businessData?.name??"";
      emailController.text = profileController.businessData?.aboutMe??"";
    });
  }

  @override
  Widget build(BuildContext context) {
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
                                title: "Добавление услуг",
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
              child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.02),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * 0.015,
                          ),

                          SizedBox(
                            height: Get.height * 0.01,
                          ),

                          AppTextFied(
                            fillColor: Colors.transparent,
                            isFill: true,
                            controller: updateController.serviceController,
                            isReadOnly: true,
                            onTap: () {
                              profileController.serviceJobData(id: profileController.businessData?.id.toString());
                              setState(() {

                              });
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  context: context,
                                  builder: (context) => const UpdateService());
                            },
                            isborderline: true,
                            isSuffix: true,
                            isShowCursor: false,
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            borderColor: AppColor.DARK_TEXT_COLOR,
                            isborderline2: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.04,
                                vertical: Get.height * 0.01),
                            isVisible: true,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            borderRadius: BorderRadius.circular(10),
                            borderRadius2: BorderRadius.circular(10),
                            hint: "Выберите услугу",
                            hintColor: AppColor.DARK_TEXT_COLOR,
                            borderColor2: AppColor.DARK_TEXT_COLOR,
                            maxLines: 1,
                            hintSize: Get.height*0.015,
                          ),

                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.WHITE_COLOR,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child:   Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Get.height * 0.015,
                                ),
                                AppText(
                                  title: "Стоимость *",
                                  size: Get.height*0.016,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.DARK_TEXT_COLOR,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextFied(
                                        fillColor: Colors.transparent,
                                        isFill: true,
                                        controller: updateController.priceController,

                                        onChange: (val) {
                                          if (int.parse(val.toString()) <= 0){
                                            setState(() {
                                              updateController.priceController.clear();
                                            });
                                          }
                                        },

                                        isborderline: true,
                                        isSuffix: true,
                                        isShowCursor: true,

                                        borderColor: AppColor.DARK_TEXT_COLOR,
                                        isborderline2: true,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.04,
                                            vertical: Get.height * 0.01),
                                        isVisible: true,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        fontFamily: Weights.medium,
                                        textInputType: TextInputType.phone,
                                        borderRadius: BorderRadius.circular(10),
                                        borderRadius2: BorderRadius.circular(10),
                                        hint: "Укажите цену",
                                        textInputAction: TextInputAction.done,
                                        hintColor: AppColor.DARK_TEXT_COLOR,
                                        borderColor2: AppColor.DARK_TEXT_COLOR,
                                        maxLines: 1,
                                        hintSize: Get.height*0.015,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                    Obx(() {
                                      return addButton(
                                          color: updateController
                                              .priceServiceId.value.isEmpty
                                              ? AppColor.primaryColor
                                              : AppColor.primaryColor,
                                          onTap: () {
                                            var contains = updateController.addLocItem
                                                .where((p0) =>
                                            p0.id ==
                                                updateController.priceServiceId.value);


                                            UpdateCatModel appointModel =
                                            UpdateCatModel(

                                              id: updateController
                                                  .priceServiceId.value,
                                              price: updateController.priceController.text,
                                              name:
                                              updateController.serviceName.value,

                                            );
                                            if (contains.isEmpty) {
                                              updateController.addLocItem
                                                  .add(appointModel);
                                              clear();
                                            } else {
                                              showErrorToast( "Услуга уже добавлена");
                                            }

                                          });
                                    })
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.015,
                                ),
                              ],
                            ),
                          ),
                        )

                        ],
                      ),
                      Obx(() {
                        return updateController.addLocItem.isEmpty
                            ? Container()
                            : SizedBox(
                          height: Get.height * 0.02,
                        );
                      }),
                      Obx(() {
                        return updateController.addLocItem.isEmpty
                            ? Container()
                            : SizedBox(
                          height: Get.height * 0.04,
                          child: ListView.builder(
                              itemCount:
                              updateController.addLocItem.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    updateController.addLocItem
                                        .removeAt(index);
                                    updateController.selectList.add(updateController
                                        .addLocItem[index].idObject);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: index == 0 ? 0 : 12),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(6),
                                        border: Border.all(
                                          color: AppColor.primaryColor,
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        children: [
                                          AppText(
                                            title: updateController
                                                .addLocItem[index].name??"",
                                            overFlow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            color: AppColor.DARK_TEXT_COLOR,
                                            size: Get.height*0.014,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins",
                                          ),
                                          AppText(
                                            title: " - ",
                                            color: AppColor.DARK_TEXT_COLOR,
                                            size: Get.height*0.013,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins",
                                          ),
                                          AppText(
                                            title: "${updateController
                                                .addLocItem[index]
                                                .price} сом",
                                            color: AppColor.DARK_TEXT_COLOR,
                                            size: Get.height*0.014,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Icon(
                                            Icons.cancel,
                                            color: AppColor.DARK_TEXT_COLOR,
                                            size: Get.height * 0.02,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
                      SizedBox(height: Get.height*0.05,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Obx(
                                () {
                              return AppButton(buttonName:


                              "Продолжить", buttonColor:

                              updateController.addLocItem.isNotEmpty?AppColor.primaryColor:
                              AppColor.primaryColor, textColor: AppColor.WHITE_COLOR,
                                onTap:(){
                                  if(validateUpdate()){
                                    appLoader(context, AppColors.blueColor);

                                    ApiManger().addServiceProfile(
                                        appointment: List<dynamic>.from(
                                            updateController.addLocItem.map((e) => e.toMap())),
                                        context: context
                                    );
                                  }
                                },
                                buttonWidth: Get.width,
                                buttonRadius: BorderRadius.circular(10),
                              );
                            }
                        ),
                      )
                    ],
                  )



              ),
            ),

          ],
        )





    );


  }
  bool validateUpdate() {
    if (updateController.addLocItem.isEmpty) {
      showErrorToast( 'Пожалуйста добавьте услугу');

      return false;
    }

    return true;
  }

}