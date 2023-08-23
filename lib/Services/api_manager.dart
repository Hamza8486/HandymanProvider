// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart' as dio;
import 'package:provider_app/Services/api_constants.dart';
import 'package:provider_app/Services/helper_function.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/model/business_model.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/model/notification.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/model/services_model.dart';
import 'package:provider_app/screens/BottomView/Jobs/controller/job_controller.dart';
import 'package:provider_app/screens/BottomView/Jobs/model/change_address.dart';
import 'package:provider_app/screens/BottomView/Jobs/model/job_model.dart';
import 'package:provider_app/screens/BottomView/Jobs/model/place_bid.dart';
import 'package:provider_app/screens/BottomView/Jobs/model/reject_bid.dart';
import 'package:provider_app/screens/BottomView/Jobs/model/search_model.dart';
import 'package:provider_app/screens/BottomView/Profile/controller/account_controller.dart';
import 'package:provider_app/screens/BottomView/Profile/model/sub_model.dart';
import 'package:provider_app/screens/BottomView/Profile/model/user_model.dart';
import 'package:provider_app/screens/BottomView/Support/model/model.dart';
import 'package:provider_app/screens/Home/view/home_view.dart';
import 'package:provider_app/screens/Portfolio/Controller/controller.dart';
import 'package:provider_app/screens/Portfolio/Model/model.dart';
import 'package:provider_app/screens/auth/login/Model/city_model.dart';
import 'package:provider_app/screens/auth/login/Model/model.dart';
import 'package:provider_app/screens/auth/signup/Model/register_model.dart';
import 'package:provider_app/screens/auth/signup/signup_screen.dart';
import 'package:provider_app/screens/bids/Model/bid_model.dart';
import 'package:provider_app/screens/bids/Model/chats_model.dart';
import 'package:provider_app/screens/bids/Model/reject_model.dart';
import 'package:provider_app/screens/bids/Model/request_done_model.dart';
import 'package:provider_app/screens/bids/controller/bids_controller.dart';
import 'package:provider_app/screens/update_profile_business/controller/controller.dart';
import 'package:provider_app/screens/verification_page/controller/verification_page_controller.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/SnackBar/snack_bar.dart';
import 'package:provider_app/widgets/app_text.dart';

class ApiManger extends GetConnect {
  var isLoading = false.obs;

  static var client = http.Client();

  static Uri uriPath({required String nameUrl}) {
    return Uri.parse(ApiConstants.baseURL + nameUrl);
  }

  static Future<LoginResponse?> loginResponse(
      {var phone, var token, required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> body = <String, dynamic>{};
    body['phone_no'] = phone;
    body['token'] = token;
    var response =
        await client.post(uriPath(nameUrl: ApiConstants.loginURI), body: body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(response.body);
      print(jsonString["data"]["id"]);
      HelperFunctions.saveInPreference(
          "id", jsonString["data"]["id"].toString());
      prefs.setString('id', jsonString["data"]["id"].toString());
      HelperFunctions.saveInPreference(
          "address", jsonString["data"]["address"].toString());
      Get.offAll(PersisNavBar(currentIndex: 0));

      return loginResponseFromJson(response.body);
    } else if (response.statusCode == 404) {
      Get.offAll(SignupScreen(
        phone: phone,
      ));
      Get.back();

      //show error message
      return null;
    } else {
      Get.back();
      showErrorToast("Нет соединения");

      //show error message
      return null;
    }
  }

  // Provider Register
  static Future<RegisterResponse?> registerResponse(
      {var phone,
      var name,
      var city,
      var token,
      required BuildContext context}) async {
    Map<String, dynamic> body = <String, dynamic>{};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    body['phone_no'] = phone;
    body['full_name'] = name;
    body['city'] = city;
    body['token'] = token;
    var response = await client.post(uriPath(nameUrl: ApiConstants.registerURI),
        body: body);
    print(response.statusCode);
    print(response.body);
    print(response.body);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(response.body);
      print(jsonString["data"]["id"]);
      HelperFunctions.saveInPreference(
          "id", jsonString["data"]["id"].toString());
      prefs.setString('id', jsonString["data"]["id"].toString());

      HelperFunctions.saveInPreference(
          "address", jsonString["data"]["address"].toString());
      Get.offAll(PersisNavBar(
        currentIndex: 0,
      ));
      successToast("Аккаунт создан успешно!");

      return registerResponseFromJson(response.body);
    } else if (response.statusCode == 400) {
      var jsonString = jsonDecode(response.body);
      showErrorToast(jsonString['error']['message'].toString());

      Get.back();

      //show error message
      return null;
    } else {
      Get.back();
      showErrorToast("Нет соединения");

      //show error message
      return null;
    }
  }

  static Future<CityResponse?> cityResponse() async {
    Map<String, dynamic> body = <String, dynamic>{};

    var response = await client.get(
      uriPath(nameUrl: ApiConstants.city),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return cityResponseFromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }




  static Future<GetNotificationAll?> getNotificationAll() async {

    var response = await client.get(
      uriPath(nameUrl: "${ApiConstants.noti}${Get.put(ProfileController()).userId.value}"),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);

      return GetNotificationAll.fromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<HomeResponse?> homeResponse() async {
    Map<String, dynamic> body = <String, dynamic>{};

    var response = await client.get(
      uriPath(nameUrl: ApiConstants.homeURI),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return homeResponseFromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  Future<GetPortfolioResponse?> portfolioResponse({id}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['pro_id'] = id;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.viewPort), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return getPortfolioResponseFromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }



 static Future<GetProviderChatModel?> getChatListaLL() async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['pro_id'] = Get.put(ProfileController()).userId.value;
    body['cus_id'] = Get.put(ProfileController()).userIds.value;
    body['job_id'] = Get.put(ProfileController()).jobId.value;

    var response =
    await client.post(uriPath(nameUrl: ApiConstants.CHAT), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {

      var jsonString = response.body;
      Get.put(ProfileController()).scrollToLastMessage();

      return getProviderChatModelFromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }



  sendMessage({required BuildContext context,chats}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'pro_id':Get.put(ProfileController()).userId.value,
          'cus_id': Get.put(ProfileController()).userIds.value,
          'job_id': Get.put(ProfileController()).jobId.value,
          'message': chats.toString(),
          Get.put(ProfileController()).file4==null?"":
          'file': Get.put(ProfileController()).file4 == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(ProfileController()).file4!.path),
        });
        var response = await dio.Dio().post(
          ApiConstants.baseURL + ApiConstants.SEND,
          data: data,
        );
        print(response);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Get.put(ProfileController()).chatData();
          Get.put(ProfileController()).file4=null;
          Get.put(ProfileController()).updateChatLoading(false);
        }
      } on dio.DioError catch (e) {
        Get.put(ProfileController()).chatData();
        Get.put(ProfileController()).file4=null;
        Get.put(ProfileController()).updateChatLoading(false);

        debugPrint("e.response");
        debugPrint(e.response.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(ProfileController()).chatData();
      Get.put(ProfileController()).file4=null;
      Get.put(ProfileController()).updateChatLoading(false);
      showErrorToast("${e.response?.data["message"]}");

      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }




  static Future<ServicesModel?> servicesResponse({id}) async {
    var response =
        await client.get(uriPath(nameUrl: "${ApiConstants.services}/${id.toString()}"));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return servicesModelFromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  Future<GetRejectResponse?> rejectResponse({id}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['pro_id'] = id;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.reject), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return getRejectResponseFromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<ProfileResponse?> profileResponse({var id}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['pro_id'] = id;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.profile), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return profileResponseFromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<BusinessProfileResponse?> profileBusResponse({var id}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['pro_id'] = id;

    var response = await client.post(uriPath(nameUrl: ApiConstants.profileBus),
        body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return businessProfileResponseFromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<BidListResponse?> bidListResponse({id}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['pro_id'] = id;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.bidList), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return bidListResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  Future<ReqDoneResponse?> reqDoneResponse({id, jobId}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['pro_id'] = id;
    body['job_id'] = jobId;

    var response = await client.post(uriPath(nameUrl: ApiConstants.requestDone),
        body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      Get.put(JobController()).homeData();
      Get.put(ProfileController()).profBusinessData(Get.put(ProfileController()).userId.value);
      Get.put(ProfileController()).profData(Get.put(ProfileController()).userId.value);
      Get.put(BidsController()).bidData(Get.put(ProfileController()).userId.value);
      Get.put(ProfileController())
          .searchJobData("all", Get.put(ProfileController()).userId.value);
      Get.offAll(PersisNavBar(currentIndex: 0));
      successToast("Работа завершена !");

      return reqDoneResponseFromJson(response.body);
    } else if (response.statusCode == 404) {
      var jsonString = jsonDecode(response.body);
      Get.back();
      showErrorToast("${jsonString["message"].toString()}!");

      print(response.statusCode);

      //show error message
      return null;
    }
  }

  Future<ReqDoneResponse?> delteBidResponse({id}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['bid_id'] = id;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.deleteBid), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      Get.put(JobController()).homeData();
      Get.put(ProfileController()).profBusinessData(Get.put(ProfileController()).userId.value);
      Get.put(ProfileController()).profData(Get.put(ProfileController()).userId.value);
      Get.put(BidsController()).bidData(Get.put(ProfileController()).userId.value);
      Get.put(ProfileController())
          .searchJobData("all", Get.put(ProfileController()).userId.value);
      Get.offAll(PersisNavBar(currentIndex: 0));
      showErrorToast("Отклик удален !");

      return reqDoneResponseFromJson(response.body);
    } else if (response.statusCode == 404) {
      var jsonString = jsonDecode(response.body);
      Get.back();
      showErrorToast(jsonString.toString());

      print(response.statusCode);
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  // Edit Profile
  editProfile(
      {var userId,
      var name,
      var email,
      var image,
      required BuildContext context}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'pro_id': userId.toString(),
          'first_name': name,
          'email': email,
          'profile_image': await dio.MultipartFile.fromFile(image.path),
        });
        var response = await dio.Dio().post(
          ApiConstants.baseURL + ApiConstants.editProfile,
          data: data,
        );
        print(response);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Get.put(ProfileController())
              .profData(Get.put(ProfileController()).userId.value);
          Get.back();
          Navigator.pop(context);
          successToast("Успешно обновлено");
        } else {
          Get.back();
        }
      } on dio.DioError catch (e) {
        showErrorToast(e.response?.data['response']);

        Get.back();

        //
        // showSnackBar(context, e.response?.data['response']);
        print("e.response");
        print(e.response);
      }
    } on dio.DioError catch (e) {
      print(e.toString());
      Get.back();
    }
  }

  static Future<SearchJobResponse?> searchResponse({var id, var proId}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['cat_id'] = id;
    body['pro_id'] = proId;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.searchCat), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return searchJobResponseFromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  Future<PlaceBidResponse?> placeBidResponse(
      {var id, var custId, var jobId, var price, var des}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['customer_id'] = custId;
    body['provider_id'] = id;
    body['description'] = des;
    body['price'] = price;
    body['job_id'] = jobId;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.placeBid), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      Get.put(BidsController()).bidData(Get.put(BidsController()).userId.value);
      Get.put(JobController()).homeData();

      Get.put(ProfileController())
          .searchJobData("all", Get.put(ProfileController()).userId.value);

      Get.offAll(PersisNavBar(currentIndex: 1));
      successToast("Успешно");


      return placeBidResponseFromJson(jsonString);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      var jsonString = jsonDecode(response.body);
      print(response.statusCode);
      Get.back();
      showErrorToast("Не доступно");

      //show error message
      return null;
    } else {
      print(response.statusCode);
      Get.back();
      showErrorToast("connection error");

      //show error message
      return null;
    }
  }

  Future<RejectBidResponse?> rejectBidResponse({var id, var idJob}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['pro_id'] = id;
    body['job_id'] = idJob;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.rejectJob), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Get.put(JobController()).homeData();

      Get.put(ProfileController())
          .searchJobData("all", Get.put(ProfileController()).userId.value);

      var jsonString = jsonDecode(response.body);
      successToast("Отменен");
      Get.offAll(PersisNavBar(currentIndex: 0));


      return rejectBidResponseFromJson(jsonString);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      var jsonString = jsonDecode(response.body);
      print(response.statusCode);
      Get.back();
      showErrorToast("Работа недоступна");
      //show error message
      return null;
    } else {
      print(response.statusCode);
      Get.back();
      showErrorToast("connection error");
      //show error message
      return null;
    }
  }

  // Edit Profile

  createProfile({
    var name,
    var about,
    required BuildContext context,
    required List appointment,
  }) async {
    try {
      try {
        dio.FormData data = dio.FormData.fromMap({
          'pro_id': Get.put(ProfileController()).userId.value,
          'name': name,
          'about_me': about,
          'dob':
          Get.put(VerificationPageController()).dayController.text,
          'profile_image': await dio.MultipartFile.fromFile(
              Get.put(ProfileController()).file!.path),
          'front_passport_image': await dio.MultipartFile.fromFile(
              Get.put(ProfileController()).file1!.path),
          'back_passport_image': await dio.MultipartFile.fromFile(
              Get.put(ProfileController()).file2!.path),
         // 'sub_cat': jsonEncode(appointment),
          'cat_sub': Get.put(ProfileController()).selectIndex,
        });
        if (Get.put(ProfileController()).selectIndex.isNotEmpty) {
          for (int i = 0; i < Get.put(ProfileController()).selectIndex.length; i++) {
            data.fields
                .add(MapEntry('cat_sub[$i]', Get.put(ProfileController()).selectIndex[i].toString()));
          }
        }
        var response = await dio.Dio().post(
          ApiConstants.baseURL + ApiConstants.createProfile,
          data: data,
        );
        print(response);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Get.put(ProfileController()).selectIndex.clear();
          Get.put(ProfileController()).selectName.clear();
          Get.put(ProfilePageController()).clearAllValue();

          Get.put(ProfileController())
              .profBusinessData(Get.put(ProfileController()).userId.value);
          Get.offAll(PersisNavBar(currentIndex: 0));

          showErrorToast(
              "Профиль специалиста создан. Подождите проверки администатором");
        } else {
          Get.back();
        }
      } on dio.DioError catch (e) {
        print(e);
        showErrorToast(e.response?.data['message']);
        // showSnackBar(context, e.response?.data['response']);
        Get.back();

        //
        // showSnackBar(context, e.response?.data['response']);
        print("e.response");
        print(e.response);
      }
    } on dio.DioError catch (e) {
      showErrorToast(e.response?.data['message']);
      // showSnackBar(context, e.response?.data['response']);
      Get.back();
      // Get.back();
    }
  }

  addServiceProfile({
    required BuildContext context,
    required List appointment,
  }) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'pro_id': Get.put(ProfileController()).userId.value,
        'sub_cat': jsonEncode(appointment),
      });

      var response = await dio.Dio().post(
        ApiConstants.baseURL + ApiConstants.addService,
        data: data,
      );
      print(data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.put(ProfilePageController()).clearAllValue();


        Get.put(ProfileController())
            .profBusinessData(Get.put(ProfileController()).userId.value);
        Navigator.pop(context);
        Navigator.pop(context);

        successToast("Услуга добавлена успешно! ");
      }
    } on dio.DioError catch (e) {
      print(e);
      print(e.response?.statusCode);
      showErrorToast(e.response?.data['message']);
      // showSnackBar(context, e.response?.data['response']);
      Get.back();

      //
      // showSnackBar(context, e.response?.data['response']);
      print("e.response");
      print(e.response);
    }
  }






  delServiceProvider({
    var jobId,
    required BuildContext context,
  }) async {

    try {
      dio.FormData data = dio.FormData.fromMap({
        'service_id': jobId,
        'pro_id': Get.put(ProfileController()).userId.value,
      });
      var response = await dio.Dio().post(
        ApiConstants.baseURL + ApiConstants.deleteService,
        data: data,
      );
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.back();
        Get.put(ProfileController())
            .profBusinessData(Get.put(ProfileController()).userId.value);
        successToast("Услуга удалена");
      } else {
        Get.back();
      }
    } on dio.DioError catch (e) {
      print(e.response);
      Get.back();
    }
  }



  moveTop({
    var id,
    required BuildContext context,
  }) async {

    try {
      dio.FormData data = dio.FormData.fromMap({
        'provider_id': id.toString(),
      });
      var response = await dio.Dio().post(
        ApiConstants.baseURL + ApiConstants.moveTop,
        data: data,
      );
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.put(ProfileController())
            .profBusinessData1(Get.put(ProfileController()).userId.value);
        print(response.data);

      } else {

      }
    } on dio.DioError catch (e) {
      print(e.response);

    }
  }

  Future<ChangeAddressResponse?> changeAddressResponse(
      {var address, required BuildContext context}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['pro_id'] = Get.put(ProfileController()).userId.value;
    body['city_id'] = address;

    var response = await client
        .post(uriPath(nameUrl: ApiConstants.addressChange), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      Get.back();
      successToast(jsonString['message'].toString());
      HelperFunctions.saveInPreference(
          "address", jsonString['data']['address'].toString());
      Get.put(ProfileController())
          .updateAddress(jsonString['data']['address'].toString());
      Get.put(JobController())
          .homeData();
      Get.put(ProfileController())
          .searchJobData("all",  Get.put(ProfileController()).userId.value);


      return changeAddressResponseFromJson(response.body);
    } else if (response.statusCode == 400) {
      var jsonString = jsonDecode(response.body);
      Get.back();
      showErrorToast(jsonString['error']['message'].toString());

      print(response.statusCode);

      //show error message
      return null;
    }
  }

  updateBusProfile({
    var name,
    var about,
    required BuildContext context,
    required List appointment,
  }) async {
    try {
      try {
        dio.FormData data = dio.FormData.fromMap({
          'pro_id': Get.put(ProfileController()).userId.value,
          'name': name,
          'about_me': about,
          'profile_image': Get.put(ProfileController()).file3 == null
              ? ""
              : await dio.MultipartFile.fromFile(
                  Get.put(ProfileController()).file3!.path),
          Get.put(ProfileController()).selectIndex.isEmpty ? "" : 'sub_cat':
              jsonEncode(appointment),
        });
        print(jsonEncode(appointment));

        print("Data::::: ${data.fields}");
        if (Get.put(UpdatePageController()).selectList.isNotEmpty) {
          data.fields.add(MapEntry('del_sub_cat',
              jsonEncode(Get.put(UpdatePageController()).selectList)));
        }
        var response = await dio.Dio().post(
          ApiConstants.baseURL + ApiConstants.update,
          data: data,
        );
        print(response);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Get.back();
          Get.back();
          successToast("Успешно обновлено");
          Get.put(ProfileController())
              .profBusinessData(Get.put(ProfileController()).userId.value);
        } else {
          // Get.back();
        }
      } on dio.DioError catch (e) {
        print(e);
        // showSnackBar(context, e.response?.data['response']);
        // Get.back();

        //
        // showSnackBar(context, e.response?.data['response']);
        print("e.response");
        print(e.response);
      }
    } on dio.DioError catch (e) {
      print(e.toString());
      // Get.back();
    }
  }

  addPortfolioResp(
      {List<dynamic>? image, required BuildContext context}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      List<dio.MultipartFile> multiPartPics = [];
      // if (postVideo != null) {
      // }

      if (image != null) {
        for (var i = 0; i < image.length; i++) {
          multiPartPics.add(await dio.MultipartFile.fromFile(image[i].path));
        }
      }
      try {
        dio.FormData data = dio.FormData.fromMap({
          'pro_id': Get.put(ProfileController()).userId.value,
          'portfolio_image[]': multiPartPics,
        });

        var response =
            await dio.Dio().post(ApiConstants.baseURL + ApiConstants.addPort,
                data: data,
                options: dio.Options(headers: {
                  "Accept": "application/json",
                }));

        debugPrint(response.toString());

        debugPrint(response.statusCode.toString());
        if (response.statusCode == 200) {
          Get.back();
          Navigator.pop(context);
          Get.put(PortfolioController())
              .imageData(Get.put(PortfolioController()).userId.value);
          Get.put(ProfileController())
              .profBusinessData(Get.put(PortfolioController()).userId.value);
          successToast("Изображение добавлено");

          debugPrint(response.statusMessage);
        } else {
          Get.back();
        }
      } on dio.DioError catch (e) {
        Get.back();

        showErrorToast(e.response.toString());

        debugPrint(e.response.toString());
      }
    } on dio.DioError catch (e) {
      print(e.toString());
    }
  }

  deletePortfolioResp({var id, required BuildContext context}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'portfolio_id': id,
      });

      var response =
          await dio.Dio().post(ApiConstants.baseURL + ApiConstants.deletePort,
              data: data,
              options: dio.Options(headers: {
                "Accept": "application/json",
              }));

      debugPrint(response.toString());

      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.back();
        // Navigator.pop(context);
        Get.put(PortfolioController())
            .imageData(Get.put(PortfolioController()).userId.value);
        Get.put(ProfileController())
            .profBusinessData(Get.put(PortfolioController()).userId.value);
        showErrorToast("Изображение удалено");

        debugPrint(response.statusMessage);
      } else {
        Get.back();
      }
    } on dio.DioError catch (e) {
      Get.back();
      showErrorToast(e.response.toString());

      debugPrint(e.response.toString());
    }
  }

  sendNotif({desc, Id}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'cus_id': Id,
        'message': desc,
      });
      var response = await dio.Dio().post(
        ApiConstants.baseURL + ApiConstants.notif,
        data: data,
      );
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
      } else {}
    } on dio.DioError catch (e) {
      //showErrorToast (e.response!.data.toString());
      print(e.response);
    }
  }

  static Future<SubCatResponse?> subCatRes({var category}) async {
    Map<String, dynamic> body = <String, dynamic>{};
    body['cat_id'] = category;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.subCat), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(response.body);

      return subCatResponseFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<SubCatResponse?> subCategoryRes({var category}) async {
    Map<String, dynamic> body = <String, dynamic>{};
    body['search'] = category;

    var response = await client
        .post(uriPath(nameUrl: ApiConstants.searchSubCat), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(response.body);

      return subCatResponseFromJson(response.body);
    } else {
      return null;
    }
  }

  agreeResponse({required BuildContext context, job}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'job_id': job,
      });
      print(data);

      var response = await dio.Dio().post(
        ApiConstants.baseURL + ApiConstants.selectUser,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.put(BidsController()).bidData(Get.put(ProfileController()).userId.value);
       Navigator.pop(context);
       Navigator.pop(context);

        successToast("User Selected You Successfully!");
      }
    } on dio.DioError catch (e) {
      Get.back();
      showErrorToast("${e.response?.data["message"]}");

      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }


  static Future<HomeResponse?> homeAlResponse() async {
    Map<String, dynamic> body = <String, dynamic>{};

    var response = await client.get(
      uriPath(nameUrl: ApiConstants.homeURI),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return homeResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }
  getAllNoti({job}) async {
    try {
      var response = await dio.Dio().get(
        "${ApiConstants.baseURL + ApiConstants.readAll}${job.toString()}",
      );
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Hamza");
        print(response.data);
        Get.put(ProfileController()).notData();
        print(response.data);
      } else {}
    } on dio.DioError catch (e) {
      print(e.response);
    }
  }


  static Future<SupportListResponse?> supportResponse() async {
    Map<String, dynamic> body = <String, dynamic>{};

    var response = await client.get(
      uriPath(nameUrl: ApiConstants.support),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return supportListResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }
}
