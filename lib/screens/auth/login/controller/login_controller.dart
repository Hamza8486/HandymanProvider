import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider_app/Services/api_manager.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var cityList = [].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    cityData();



  }
  TextEditingController numberController = TextEditingController();
  cityData() async{


    try{
      isLoading(true);

      var cityViewData =await ApiManger.cityResponse();
      if(cityViewData!=null){
        cityList.value = cityViewData.data;
        update();
        print("testtstss");


        print(cityViewData.data.length);



      }
      else{

      }
    }
    catch(e){print(e.toString());}
    finally{
      isLoading(false);
    }




  }
}