import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';


class EarnRefrence extends StatelessWidget {
  const EarnRefrence({Key? key}) : super(key: key);
  Future<void> share() async {
    await WhatsappShare.share(
      text: "📢 Hey friends! Check out our amazing MR App - it's mind-blowing! 😎 Sign up using my referral code  and get rewarded with \$1! 💸 Don't miss out on this awesome opportunity, share the love on WhatsApp now.\n# ${Get.put(HomeController()).referCode.value.toString()}    Use this",
      linkUrl: 'https://flutter.dev/',
      phone: '911234567890',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          TopBar(onTap1: (){},onTap: (){
            Get.back();
          },text: "Earn & Reference",
              image: "assets/icons/share.svg",color: AppColor.whiteColor
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height*0.025,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           AppText(
                             title: "Refer your friends",
                             size: AppSizes.size_12,
                             fontFamily: AppFont.medium,
                             fontWeight: FontWeight.w500,
                             color: AppColor.greyColors,
                           ),
                           SizedBox(height: 3),
                           AppText(
                             title: "Earn \$1 Each",
                             size: AppSizes.size_22,
                             fontFamily: AppFont.semi,
                             fontWeight: FontWeight.w700,
                             color: AppColor.primaryColor,
                           ),
                         ],
                       ),
                       SvgPicture.asset("assets/icons/coin.svg"),
                     ],
                   ),
                    SizedBox(height: Get.height*0.025,),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.primaryColor)
                      ),
                      child:Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                          child:   Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                             Row(
                               children: [
                                 AppText(
                                   title: "Total Reward  ",
                                   size: AppSizes.size_13,
                                   color: AppColor.boldBlackColor,
                                   fontFamily: AppFont.medium,


                                 ),
                                 SizedBox(width: Get.width*0.05,),
                                 Obx(
                                   () {
                                     return AppText(
                                       title: "\$${Get.put(HomeController()).totalEarning.value.toString()} ",
                                       size: AppSizes.size_24,
                                       color: AppColor.boldBlackColor,
                                       fontFamily: AppFont.medium,


                                     );
                                   }
                                 ),
                               ],
                             ),
                            Container()


                            ],
                          )
                      ) ,
                    ),
                    SizedBox(height: Get.height*0.03,),
                    Center(
                      child: AppText(
                        title: "Referral Code",
                        size: AppSizes.size_13,
                        fontFamily: AppFont.medium,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor,
                      ),
                    ),
                    SizedBox(height: Get.height*0.02,),
                    Center(
                      child: Obx(
                        () {
                          return GestureDetector

                            (
                            onTap:
                            Get.put(HomeController()).referCode.value.isEmpty?(){
                              flutterToastSuccess(msg: "Copied");
                              Clipboard.setData(ClipboardData(
                                  text: Get.put(HomeController()).referCode.value.toString()));
                            }:

                                (){
                              flutterToastSuccess(msg: "Copied");
                              Clipboard.setData(ClipboardData(
                                  text: Get.put(HomeController()).referCode.value.toString()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),

                              ),
                              child:Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                                  child:   Obx(
                                    () {
                                      return AppText(
                                        title: Get.put(HomeController()).referCode.value.toString(),
                                        size: AppSizes.size_17,
                                        color: AppColor.greyColors,
                                        fontFamily: AppFont.semi,


                                      );
                                    }
                                  )
                              ) ,
                            ),
                          );
                        }
                      ),
                    ),
                    SizedBox(height: Get.height*0.02,),

                    Center(
                      child: AppText(
                        title: "COPY OR SHARE YOUR REFERRAL CODE WITH FRIENDS",
                        size: AppSizes.size_10,
                        fontFamily: AppFont.medium,
                        fontWeight: FontWeight.w500,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    SizedBox(height: Get.height*0.025,),
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          share();
                        },
                        child: Image.asset("assets/icons/whats.png",
                        height: Get.height*0.05,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.03,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                      child: Row(

                        children: [
                          SvgPicture.asset("assets/icons/hand.svg"),
                          SizedBox(width: Get.width*0.02,),
                          AppText(
                            title: "How to refer a friend?",
                            size: AppSizes.size_13,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w500,
                            color: AppColor.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height*0.02,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(100),

                            ),
                            child:Padding(
                                padding:  EdgeInsets.all(10),
                                child:  SvgPicture.asset("assets/icons/copy.svg",
                                color: AppColor.grey3Color,
                                )
                            ) ,
                          ),
                          SizedBox(width: Get.width*0.02,),
                          Expanded(
                            child: AppText(
                              title: "Copy the referral code and share it with your friend.",
                              size: AppSizes.size_11,
                              fontFamily: AppFont.medium,
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height*0.02,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(100),

                            ),
                            child:Padding(
                                padding:  EdgeInsets.all(10),
                                child:  SvgPicture.asset("assets/icons/line2.svg",
                                color: AppColor.grey3Color,
                                )
                            ) ,
                          ),
                          SizedBox(width: Get.width*0.02,),
                          Expanded(
                            child: AppText(
                              title: "Ask your friend to register on App using the referral code",
                              size: AppSizes.size_11,
                              fontFamily: AppFont.medium,
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
