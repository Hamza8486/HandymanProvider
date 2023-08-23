import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import 'package:intl/intl.dart';
import 'package:provider_app/widgets/Fonts/app_fonts.dart';
import 'package:provider_app/widgets/SnackBar/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {


  static Future<File?> pickImage(ImageSource imageSource,context) async {
    File imageFile;
    XFile? file = await ImagePicker().pickImage(source: imageSource,
    imageQuality: 50

    );
    if (file != null) {
      File fileImage = File(file.path);
      int sizeInBytes = fileImage.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      print('IMAGE SIZE : $sizeInMb');
      if (sizeInMb > 1) {
        print('$file size is $sizeInMb');
        showErrorToast('image is more than 1 MB');
        file == null;

      }
      else{
        imageFile = File(file.path);
        return imageFile;
      }


    } else {
      print("No image selected");
    }
    return null;
  }



  static Future<bool> isNetworkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  static saveInPreference(String preName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(preName, value);
    print('Bismillah: In save preference function');
  }

  static Future<String> getFromPreference(String preName) async {
    String returnValue = "";

    final prefs = await SharedPreferences.getInstance();
    returnValue = prefs.getString(preName) ?? "";
    return returnValue;
  }

/*  static checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true; //connected to mobile data
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true; // connected to a wifi network.
    } else {
      return false;
    }
  }*/


  static showMessageWithImage(
      BuildContext context, String message, String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.width * 0.025),
            ),
          ),
          title: Container(
            height: MediaQuery.of(context).size.width * 0.17,
            width: MediaQuery.of(context).size.width * 0.17,
            child: Image(
              image: AssetImage(image),
            ),
          ),
          content: Text(
            message,
            style:
            TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  static bool isValidPassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,16}$';
    RegExp regex = new RegExp(pattern);
    if (!(value.contains(regex))) {
      return false;
    } else {
      return true;
    }
  }

  static bool isValidEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

    RegExp regex = new RegExp(pattern);
    if (!(value.contains(regex))) {
      return false;
    } else {
      return true;
    }
  }

  // static Future<dynamic> pickImage(ImageSource imageSource) async {
  //   File imageFile;
  //   final file = await ImagePicker().getImage(source: imageSource);
  //   if (file != null) {
  //     imageFile = File(file.path);
  //      return imageFile;
  //   } else {
  //     print("No image selected");
  //     return null;
  //   }

  // }

  // static Future<dynamic> videoPick(ImageSource imageSource) async {
  //   File videoFile;
  //   final file = await ImagePicker().getVideo(source: imageSource);
  //     if (file != null) {
  //       videoFile = File(file.path);
  //       return videoFile;
  //     } else {
  //       print("No video selected");
  //       return null;
  //   }

  // }

  static clearPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
Future<bool> signout() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  return true;
}


// Container(
//         height: MediaQuery.of(context).size.width * 0.09,
//         child: Image.asset('resources/images/logo.png',color: ColorConstants.darkBlue,)
//
//
//       ),


// showSnackBar(BuildContext context,String str){
//   final snackBar = SnackBar(
//     content: Text(str, style: TextStyle(color: Colors.white,fontFamily: Weights.medium),),
//     backgroundColor: Colors.black87,
//     duration: Duration(seconds: 2),
//   );
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }