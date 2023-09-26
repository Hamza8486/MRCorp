import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/component/transaction.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/claim_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/earn_refrence.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/faq_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/store_list.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/tap_pay.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/testmonials.dart';
import 'package:mr_bet/app/bottom_tabs/profile/view/profile_view.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/view/wallet_view.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/helper_function.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color:AppColor.primaryColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height:
                      Get.put(HomeController()).name.value.isNotEmpty
                          ? Get.height * 0.11
                          : Get.height * 0.11,
                      width: Get.height * 0.11,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.whiteColor,width: 3),
                        shape: BoxShape.circle,
                      ),
                      child:
                      Obx(
                        () {
                          return ClipRRect(
                            borderRadius:


                            BorderRadius.circular(

                                100),
                            child: CachedNetworkImage(
                              placeholder: (context, url) =>Center(
                                  child: SpinKitThreeBounce(
                                      size: 16, color: AppColor.primaryColor)
                              ),
                              imageUrl:Get.put(HomeController()).image.value,
                              fit: Get.put(HomeController()).image.value.isEmpty
                                  ? BoxFit.cover
                                  : BoxFit.cover,
                              errorWidget: (context, url, error) => ClipRRect(
                                borderRadius:


                                BorderRadius.circular(100),
                                child: Image.asset(
                                  "assets/images/persons.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }
                      )





                  ),
                  SizedBox(height: Get.height*0.01,),

                  Obx(
                    () {
                      return AppText(
                        title: Get.put(HomeController()).name.value,
                        size:
                        Get.put(HomeController()).name.value.isEmpty?AppSizes.size_17:
                        AppSizes.size_17,
                        fontFamily: AppFont.semi,
                        fontWeight: FontWeight.w600,
                        color: AppColor.whiteColor,
                      );
                    }
                  ),

                ],
              )),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(ProfileView(),
                        transition: Transition.rightToLeft
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/profile.png",
                          height: Get.height * 0.024,
                          color: AppColor.grey3Color,
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        AppText(
                          title: "Profile Setting",
                          size: AppSizes.size_15,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.boldBlackColor,
                        ),
                      ],
                    ),
                  ),
                ),

                Obx(() {
                  return Column(
                    crossAxisAlignment:
                        Get.put(HomeController()).slotProfileId.value.isEmpty
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.035,
                      ),
                      GestureDetector(
                        onTap: Get.put(HomeController())
                                .slotProfileId
                                .value
                                .isNotEmpty
                            ? () {
                                flutterToast(msg: "You don't have any reward!");
                              }
                            : () {
                                Get.to(ClaimView(),
                                    transition: Transition.rightToLeft);
                              },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/claim.svg",
                                height: Get.height * 0.028,
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              AppText(
                                title: "Claim",
                                size: AppSizes.size_15,
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w500,
                                color: AppColor.boldBlackColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    Get.put(HomeController()).getAllTest();
                    Get.to(Testimonials(), transition: Transition.rightToLeft);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/test.svg",
                        height: Get.height * 0.025,
                      ),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      AppText(
                        title: "Testimonials",
                        size: AppSizes.size_15,
                        fontFamily: AppFont.medium,
                        fontWeight: FontWeight.w500,
                        color: AppColor.boldBlackColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(WalletView(),
                    transition: Transition.rightToLeft
                    );

                  },
                  child: Container(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/card.svg",
                          height: Get.height * 0.025,

                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        AppText(
                          title: "Wallet",
                          size: AppSizes.size_15,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.boldBlackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const EarnRefrence(),
                        transition: Transition.rightToLeft);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/money.png",
                          height: Get.height * 0.025,
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        AppText(
                          title: "Earn & Reference ",
                          size: AppSizes.size_15,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.boldBlackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    Get.put(HomeController()).getTransData();
                    Get.to(const TransactionView(),
                        transition: Transition.rightToLeft);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.task,
                          size: Get.height * 0.025,
                          color: AppColor.grey3Color,
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        AppText(
                          title: "Orders & Bookings ",
                          size: AppSizes.size_15,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.boldBlackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(StoreList(),
                        transition: Transition.rightToLeft
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/banks.svg",
                          height: Get.height * 0.025,
                          color: AppColor.grey3Color,
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        AppText(
                          title: "Partners",
                          size: AppSizes.size_15,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.boldBlackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(TapPay(),
                        transition: Transition.rightToLeft
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.mobile_friendly,
                          size: Get.height * 0.027,
                          color: AppColor.grey3Color,
                        ),
                        SizedBox(
                          width: Get.width * 0.027,
                        ),
                        AppText(
                          title: "Tap to pay ",
                          size: AppSizes.size_15,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.boldBlackColor,
                        ),
                      ],
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(FaqView(),
                            transition: Transition.rightToLeft);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/claim.svg",
                              height: Get.height * 0.028,
                            ),
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                            AppText(
                              title: "FAQs",
                              size: AppSizes.size_15,
                              fontFamily: AppFont.medium,
                              fontWeight: FontWeight.w500,
                              color: AppColor.boldBlackColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.help,
                          size: Get.height * 0.027,
                          color: AppColor.grey3Color,
                        ),
                        SizedBox(
                          width: Get.width * 0.027,
                        ),
                        AppText(
                          title: "Help & Support ",
                          size: AppSizes.size_15,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.boldBlackColor,
                        ),
                      ],
                    ),
                  ),
                ),







                SizedBox(height: Get.height*0.034,),
                GestureDetector(
                  onTap: () {
                    showExit(
                        context: context,
                        onTap: () async {
                          await  Get.delete<HomeController>();

                          await  HelperFunctions().clearPrefs();
                          Get.offAll(LoginView());



                        });
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/logout.svg",
                          height: Get.height * 0.025,
                          color: AppColor.grey3Color,
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        AppText(
                          title: "Logout",
                          size: AppSizes.size_15,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.boldBlackColor,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.02,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
