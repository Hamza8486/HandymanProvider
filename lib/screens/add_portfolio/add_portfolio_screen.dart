import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/res/app_colors.dart';

import '../../res/app_images.dart';
import 'controller/portfolio_controller.dart';

class AddPortfolioScreen extends GetView<PortFolioController> {
  AddPortfolioScreen({Key? key}) : super(key: key);

  final PortFolioController portFolioController = Get.put(PortFolioController());

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Container(
            height: 40.0,
            width: 40.0,
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.greyColor.withOpacity(0.5),
            ),
            child: const Center(
              child: Icon(Icons.arrow_back, color: Colors.white, size: 24.0),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Container(
              height: 40.0,
              width: 40.0,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greyColor.withOpacity(0.5),
              ),
              child: const Center(
                child: Icon(Icons.more_vert_outlined, color: Colors.white, size: 24.0),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: (){},
        child: const Center(
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1 / 1.1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: 10,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        itemBuilder: (context, index){
          return Container(
            height: height * 0.2,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: const DecorationImage(
                image: AssetImage(AppImages.personImage),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: (){},
                  icon: Container(
                    height: 18.0,
                    width: 18.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.close, color: Colors.grey, size: 12.0),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}