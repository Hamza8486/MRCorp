
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/history/payment_history.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/profile/vendor_profile.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/qr/create_qr.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/stores/view/store_view.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/view/vend_dash.dart';

import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';


class VendorHome extends StatefulWidget {
  VendorHome({super.key,this.currentTab=0});
  int currentTab ;


  @override
  _VendorHomeState createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  // Properties & Variables needed

  // to keep track of active tab index

  final vendorController = Get.put(VendorController());
  final List<Widget> screens = [
    VendorDashboard(),
    StoreView(),
    Container(),

    Container(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = VendorDashboard(); // Our first view in viewport

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
                    QRCodeGenerator(); // if user taps on this dashboard tab will be active
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
                            VendorDashboard(); // if user taps on this dashboard tab will be active
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
                            StoreView(); // if user taps on this dashboard tab will be active
                        widget.currentTab  = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/loc.png",height: Get.height*0.027,
                          color:
                          widget.currentTab  == 1 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),
                        SizedBox(height: 5,),
                        AppText(
                          title: "stores",
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
                            VendorPayment(); // if user taps on this dashboard tab will be active
                        widget.currentTab  = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/his.png",height: Get.height*0.027,
                          color:
                          widget.currentTab  == 2 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),
                        SizedBox(height: 5,),
                        AppText(
                          title: "History",
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
                            VendorProfile(); // if user taps on this dashboard tab will be active
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
                          title: "Setting",
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