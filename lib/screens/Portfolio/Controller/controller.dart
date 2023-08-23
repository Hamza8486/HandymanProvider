import 'package:get/get.dart';
import 'package:provider_app/Services/api_manager.dart';
import 'package:provider_app/Services/helper_function.dart';

class PortfolioController extends GetxController {


  var imageList = [].obs;
  var isLoading = false.obs;
  var userId = "".obs;
  @override
  void onInit() {
    HelperFunctions.getFromPreference("id").then(
            (value){
          userId.value = value;
          imageData(userId.value);
          update();

        });

    super.onInit();




  }

  imageData(ids) async{


    try{
      isLoading(true);

      var homeViewData =await ApiManger().portfolioResponse(id: ids);
      if(homeViewData!=null){
        imageList.value = homeViewData.data;
        update();
        print("testtstss");


        print(homeViewData.data.length);




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