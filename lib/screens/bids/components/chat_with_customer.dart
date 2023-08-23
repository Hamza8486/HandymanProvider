// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/component/portfolio_detail.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';

import 'package:provider_app/widgets/Colors/app_colors.dart';
import 'package:provider_app/widgets/Dialogue/dialogue.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/Loader/loader.dart';
import 'package:provider_app/widgets/app_dimensions.dart';
import 'package:provider_app/widgets/expand.dart';

import '../../../res/app_colors.dart';
import '../controller/bids_controller.dart';
import 'provider_action.dart';

class ChatWithCustomer extends StatefulWidget {
  ChatWithCustomer({Key? key, this.data}) : super(key: key);

  var data;

  @override
  State<ChatWithCustomer> createState() => _ChatWithCustomerState();
}

class _ChatWithCustomerState extends State<ChatWithCustomer> {

  final profileController = Get.put(ProfileController());
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();

  handleChooseFromGallery() async {
    Navigator.pop(context);
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() async {
      if (image != null) {


        profileController.file4 = File(image.path);
        profileController.updateChatLoading(true);

        ApiManger().sendMessage(context: context,chats:messageController.text );
        profileController.updateScrollLoading(true);
      } else {
        print('No image selected.');
      }
    });
  }

  handleTakePhoto() async {
    Navigator.pop(context);
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() async {
      if (image != null) {
        profileController.file4 = File(image.path);
        print("This is file ${profileController.file4}");
        profileController.updateChatLoading(true);

        ApiManger().sendMessage(context: context,chats:messageController.text );
        profileController.updateScrollLoading(true);

      } else {
        print('No image selected.');
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
                child: const Text("Галерея"),
                onPressed: handleChooseFromGallery,
              ),
              SimpleDialogOption(
                child: const Text("Отмена"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }






  final bidsController = Get.put(BidsController());
  TextEditingController messageController = TextEditingController();
  List chatList = [];
  
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.chatData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.scrollController.animateTo(
        profileController.scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    });
  }


  
  bool isScrolled = true;

  @override
  Widget build(BuildContext context) {
    print(widget.data.customer.id.toString());
    print(widget.data.customer.id.toString());


    final double width = MediaQuery.of(context).size.width;

    return Scaffold(


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Material(
            color: AppColor.WHITE_COLOR,
            elevation: 1,
            child: SizedBox(
              width: Get.width,
              height: Get.height / 8.5 ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.02,
                        vertical: Get.height * 0.01 ),
                    child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10),
                        child:    Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Icon(Icons.arrow_back_outlined,
                                    size: AppDimensions.FONT_SIZE_30,
                                  ),
                                )),
                            SizedBox(width: Get.width*0.04,),
                            Container(
                              decoration:BoxDecoration(
                                  border: Border.all(color: AppColors.blueColor,
                                  ),
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl:  widget.data.customer.image==null?"":
                                  widget.data.customer.image??"",
                                  height: Get.height * 0.05,
                                  width: Get.height * 0.05,
                                  fit: BoxFit.cover,
                                  errorWidget:(context, url, error) => ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      'assets/images/person.png',
                                      height: Get.height * 0.05,
                                      width: Get.height * 0.05,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  placeholder: (context, url) =>


                                  const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.blueColor,
                                      )),



                                ),





                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 12.0),
                                  Text(
                                    widget.data.customer.firstName,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: profileController.scrollController,
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  BidExpand(),
                  const SizedBox(height: 16.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColors.greyColor.withOpacity(0.4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Ink(
                          width: width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Text(
                            widget.data.description??"Я готов(а) выполнить работу",
                            style: TextStyle(
                              fontSize: 13.0,
                              color: AppColors.blackColor,
                              fontFamily: Weights.medium,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Ink(
                          width: width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 1.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Бюджет :  ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: AppColors.blackColor,
                                  fontFamily: Weights.medium,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                'от ${widget.data.price ?? ""} сом',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: AppColors.blackColor,
                                  fontFamily: Weights.semi,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  Obx(
                    () {
                      return
                        profileController
                            .chatList.where((p0) => p0.message=="You was selected for the job.").isNotEmpty
                            || widget.data.agree!=null
                            ?


                        GestureDetector(
                        onTap: ()async{
                          await FlutterPhoneDirectCaller.callNumber(widget.data.customer.phoneNo.toString());


                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: AppColors.greyColor.withOpacity(0.4),
                          ),
                          child: Ink(
                            width: width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Вас выбрали в этой заявке.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,

                                    color: AppColors.blackColor,
                                    fontFamily:"Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 2,),
                                Text(
                                  "ПОЗВОНИТЬ КЛИЕНТУ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.0,

                                    color: AppColors.blueColor,
                                    fontFamily:"Poppins",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ):SizedBox.shrink();
                    }
                  ),
                  Obx(
                    () {
                      return ListView.builder(
                        shrinkWrap: profileController.chatList.isEmpty?true:true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: profileController.chatList.length,
                        reverse: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15),
                        itemBuilder: (context, index) {
                          // print(jsonEncode(jobController.activeList[index]));
                          // print(jsonEncode(P));

                          return
                            profileController
                                .chatList[index].message=="You was selected for the job."?SizedBox.shrink():


                            Row(
                            mainAxisAlignment: profileController
                                .chatList[index].messageFromModal ==
                                "Provider"
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.only(
                                    left: 12,
                                    right: 12,
                                    top: 10,
                                    bottom: 10),
                                decoration: BoxDecoration(
                                    color: profileController
                                        .chatList[index].messageFromModal ==
                                        "Provider"
                                        ? AppColors.blueColor
                                        : AppColors.greyColor
                                        .withOpacity(.5),
                                    // AppColors.greyColor.withOpacity(.5),
                                    borderRadius: profileController
                                        .chatList[index].messageFromModal ==
                                        "Provider"
                                        ? const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))
                                        : const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight:
                                        Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    profileController
                                        .chatList[index].img != null
                                        ? GestureDetector(
                                      onTap: () {
                                        Get.to(PortfolioDetail(data: profileController
                                            .chatList[index].img,));

                                        /////////  Open image View  imgeUrl: chatList[index]["media"]
                                      },
                                      child: Container(
                                        height: 250,
                                        width: 200,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          profileController
                                              .chatList[index].img??"",
                                          fit: BoxFit.cover,
                                          placeholder: (context,
                                              url) =>
                                          const Center(
                                              child:
                                              CircularProgressIndicator(
                                                color: Colors.red,
                                              )),
                                        ),
                                      ),
                                    )
                                        :
                                      Container(
                                      width: profileController
                                          .chatList[index].message.toString().length >27? 200:null,
                                      child: Text(
                                        profileController
                                            .chatList[index].message.toString(),
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          // color: AppColors.blackColor,
                                          color: profileController
                                              .chatList[index].messageFromModal ==
                                              "Provider"
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      profileController
                                          .chatList[index].createdAt.toString(),
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        // color: AppColors.blackColor,
                                        color: profileController
                                            .chatList[index].messageFromModal ==
                                            "Provider"
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  ),
                  SizedBox(height: Get.height*0.07,)
                ],
              ),
            ),
          ),
          Container(
            height: 120.0,
            width: width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.data.agree==null?
                        ProviderAction(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                text:
                                "Вы договорились с заказчиком ?",
                                yesOnTap: () {
                                  Get.back();
                                  appLoader(context, Colors.blue);
                                  print(widget.data.id.toString());
                                  ApiManger().agreeResponse(
                                      context: context,
                                      job: widget.data.jobId.toString());
                                });

                          },
                          text: 'Договорились',
                          textColor: Colors.green,
                          iconData: Icons.check,
                          iconColor: Colors.green,
                        ):SizedBox.shrink(),
                        SizedBox(width: Get.width*0.04,),
                        widget.data.agree==null?SizedBox.shrink():
                        ProviderAction(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                text:
                                "Вы хотите завершить работу ?",
                                yesOnTap: () {
                                  Get.back();
                                  appLoader(context, Colors.blue);
                                  ApiManger().reqDoneResponse(
                                      id: bidsController.userId.value,
                                      jobId: widget.data.jobId.toString());
                                });
                          },
                          text: 'Выполнено',
                          textColor: Colors.green,
                          iconData: Icons.check,
                          iconColor: Colors.green,
                        ),
                        widget.data.agree==null?
                        ProviderAction(
                          onTap: () {
                            showAlertDialog(
                                context: context,
                                text: "Вы хотите удалить отклик ?",
                                yesOnTap: () {
                                  Get.back();
                                  appLoader(context, Colors.blue);
                                  ApiManger().delteBidResponse(
                                      id: widget.data.id.toString());
                                });
                          },
                          text: 'Удалить отклик',
                          textColor: AppColors.redColor,
                          iconData: Icons.delete,
                          iconColor: AppColors.redColor,
                          borderColor: AppColors.redColor,
                        ):SizedBox.shrink(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Expanded(
                        child: Container(
                          height: 45.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(
                              color: AppColors.greyColor,
                              width: 1.5,
                            ),
                          ),
                          child: TextFormField(
                            controller: messageController,
                            onChanged: (v) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                left: 16.0,top: 8,bottom: 0),
                              hintText: 'Ваше сообщение',
                              hintStyle: const TextStyle(
                                fontSize: 14.0,
                                color: AppColors.greyColor,
                                fontWeight: FontWeight.w500,
                              ),
                              // suffixIcon: IconButton(
                              //   onPressed:() =>
                              //       selectImage(context)
                              //   ,
                              //   icon: const Icon(Icons.add,
                              //       color: AppColors.greyColor),
                              // ),
                              suffixIcon: IconButton(
                                onPressed: () => selectImage(context),
                                icon: const Icon(Icons.add,
                                    color: AppColors.greyColor),
                              ),
                            ),

                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),

                      Obx(
                        () {
                          return
                            profileController.isChatLoading.value
                                ? Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColor.primaryColor,

                                  ),
                                ))
                                :
                            GestureDetector(
                            onTap: messageController.text.isEmpty
                                ? () {}
                                : () {
                              profileController.updateChatLoading(true);

                              ApiManger().sendMessage(context: context,chats:messageController.text );
                              messageController.clear();
                            },
                            child: Container(
                              height: 45.0,
                              width: 45.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: messageController.text.isNotEmpty
                                    ? Colors.green
                                    : AppColors.greyColor.withOpacity(0.6),
                              ),
                              child: const Center(
                                child: Icon(Icons.send,
                                    color: Colors.white, size: 20.0),
                              ),
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget leadingButton() => GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          height: 36.0,
          width: 36.0,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.greyColor.withOpacity(0.5),
          ),
          child: const Center(
            child: Icon(Icons.arrow_back, color: Colors.white, size: 24.0),
          ),
        ),
      );

  Widget menuButton() => GestureDetector(
        onTap: () {},
        child: Container(
          height: 36.0,
          width: 36.0,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.greyColor.withOpacity(0.5),
          ),
          child: const Center(
            child: Icon(Icons.more_horiz, color: Colors.white, size: 24.0),
          ),
        ),
      );

  Widget appBarRow() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration:BoxDecoration(
                border: Border.all(color: AppColors.blueColor,
                ),
                borderRadius: BorderRadius.circular(100)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl:  widget.data.customer.image==null?"":
                widget.data.customer.image??"",
                height: Get.height * 0.05,
                width: Get.height * 0.05,
                fit: BoxFit.cover,
                errorWidget:(context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/person.png',
                    height: Get.height * 0.05,
                    width: Get.height * 0.05,
                    fit: BoxFit.cover,
                  ),
                ),

                placeholder: (context, url) =>


                const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blueColor,
                    )),



              ),





            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 12.0),
                Text(
                  widget.data.customer.firstName,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
