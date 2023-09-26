
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/view/dashboard_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/game_mannual.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/winners.dart';
import 'package:mr_bet/app/bottom_tabs/profile/view/profile_view.dart';
import 'package:mr_bet/app/bottom_tabs/scanner.dart';
import 'package:mr_bet/app/bottom_tabs/statastic/view/stats_view.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';


class Home extends StatefulWidget {
   Home({super.key,this.currentTab=0});
  int currentTab ;


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeController = Get.put(HomeController());
  // Properties & Variables needed

   // to keep track of active tab index
  final List<Widget> screens = [
    DashboardView(),
    Winners(),
    StatsView(),

    ProfileView(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashboardView(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
        color: AppColor.primaryColor.withOpacity(0.25)
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FloatingActionButton(
            backgroundColor: AppColor.primaryColor,
            child: Image.asset("assets/images/scans.png",height: Get.height*0.03,),
            onPressed: () {
              setState(() {
                currentScreen =
                    ScanQrPage(); // if user taps on this dashboard tab will be active
                widget.currentTab  = 4;
              });

            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 2,
        child: Container(
          height: Get.height*0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 70,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            DashboardView(); // if user taps on this dashboard tab will be active
                       widget.currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/home.png",height: Get.height*0.027,
                          color:
                          widget.currentTab  == 0 ?AppColor.primaryColor:
                          AppColor.tabColor,),
                        SizedBox(height: 5,),
                        AppText(
                          title: "Home",
                          size: AppSizes.size_11,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w400,
                          color:
                          widget.currentTab  == 0 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),

                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 85,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            GameManual(); // if user taps on this dashboard tab will be active
                        widget.currentTab  = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/mannual.png",height: Get.height*0.027,
                          color:
                          widget.currentTab  == 1 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),
                        SizedBox(height: 5,),
                        AppText(
                          title: "Manual",
                          size: AppSizes.size_11,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w400,
                          color:
                          widget.currentTab  == 1 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),



              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 70,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            StatsView(); // if user taps on this dashboard tab will be active
                        widget.currentTab  = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/stat.png",height: Get.height*0.027,
                          color:
                          widget.currentTab  == 2 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),
                        SizedBox(height: 5,),
                        AppText(
                          title: "Stats",
                          size: AppSizes.size_11,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w400,
                          color:
                          widget.currentTab  == 2 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 85,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Winners(); // if user taps on this dashboard tab will be active
                        widget.currentTab  = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/winner.png",height: Get.height*0.027,
                          color:
                          widget.currentTab  == 3 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),
                        SizedBox(height: 5,),
                        AppText(
                          title: "Winner",
                          size: AppSizes.size_11,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w400,
                          color:
                          widget.currentTab  == 3 ?AppColor.primaryColor:
                          AppColor.tabColor,
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
    );
  }
}