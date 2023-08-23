import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_app/res/app_colors.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/controller/business_controller.dart';
import 'package:provider_app/screens/BottomView/BusinessProfile/view/business_profile.dart';
import 'package:provider_app/screens/BottomView/Jobs/controller/job_controller.dart';
import 'package:provider_app/screens/BottomView/Jobs/view/job_screen.dart';
import 'package:provider_app/screens/BottomView/Profile/view/user_profile.dart';
import 'package:provider_app/screens/BottomView/Support/controller/support_controller.dart';
import 'package:provider_app/screens/BottomView/Support/support_screen.dart';
import 'package:provider_app/screens/add_portfolio/controller/portfolio_controller.dart';
import 'package:provider_app/screens/bids/bids_screen.dart';
import 'package:provider_app/screens/bids/controller/bids_controller.dart';
import 'package:provider_app/widgets/app_dimensions.dart';





class PersisNavBar extends StatefulWidget {
  late int currentIndex;

  PersisNavBar({Key? key, required this.currentIndex}) : super(key: key);


  @override
  _PersisNavBarState createState() => _PersisNavBarState();
}

class _PersisNavBarState extends State<PersisNavBar> {
  final profileController = Get.put(ProfileController());
  final bidController = Get.put(BidsController());
  final  jobController = Get.put(JobController());
  final  support = Get.put(SupportSectionController());


  final List _screens = [
    JobScreen(),
    BidsScreen(),
    ProfileScreen(),
    SupportSectionScreen(),
    AccountScreen(),
  ];

  void _selectedPage(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(widget.currentIndex==0){
          return true;
        }
        setState(() {
          widget.currentIndex=0;
        });
        return false;

      },
      child: Stack(
        children: [
          Scaffold(
            bottomNavigationBar: Container(
              height: 70.0,
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedItemColor: AppColors.blueColor,
                unselectedItemColor: AppColors.greyColor,
                onTap: _selectedPage,
                currentIndex: widget.currentIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                   BottomNavigationBarItem(
                    activeIcon: Icon(Icons.home),
                    icon: Icon(Icons.home),
                    label: "Заказы",
                    tooltip: "Jobs",
                  ),
                   BottomNavigationBarItem(
                    icon:  Icon(Icons.bookmark),
                    activeIcon: Icon(Icons.bookmark),
                    label: "Отклики",
                    tooltip: "Bids",
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.stars_rounded),
                    label: "Профиль",
                    tooltip: "Profile",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.contact_support_rounded),
                    label: "Помощь",
                    tooltip: "Support",
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person),
                    label: "Аккаунт",
                    tooltip: "Account",
                  ),
                ],
              ),
            ),
            body: _screens[widget.currentIndex],
          ),
          Obx(
                  () {
                return
                  Get.put(ProfileController()).notificationList.where((p0) =>p0.isRead==null).isNotEmpty?
                  Positioned(
                      bottom: Get.height*0.055,
                      left: Get.width*0.305,
                      child: Container(
                        height: 10.0,
                        width: 10.0,
                        decoration: BoxDecoration(color: Colors.red,
                            borderRadius: BorderRadius.circular(40)
                        ),
                      )):Positioned(
                      bottom: Get.height*0.055,
                      left: Get.width*0.305,
                      child: SizedBox.shrink());
              }
          )

        ],
      ),
    );
  }
}
