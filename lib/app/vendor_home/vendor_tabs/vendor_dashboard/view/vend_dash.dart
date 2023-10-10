import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/pending_view.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';




class VendorDashboard extends StatelessWidget {
  VendorDashboard({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height*0.055,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title: "Welcome back!",
                        size: AppSizes.size_13,
                        fontFamily: AppFont.medium,
                        color: AppColor.boldBlackColor.withOpacity(0.5),
                      ),
                      Obx(
                        () {
                          return AppText(
                            title: "${Get.put(VendorController()).name.value}!",
                            size:
                            Get.put(VendorController()).name.value.isEmpty?AppSizes.size_16:
                            AppSizes.size_16,
                            fontFamily: AppFont.semi,
                            color: AppColor.boldBlackColor,
                          );
                        }
                      )
                    ],
                  ),
                  Container(
                    height: Get.size.height * 0.07,
                    width: Get.size.height * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        border: Border.all(
                            color: AppColor.whiteColor, width: 1.5)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: CachedNetworkImage(
                          imageUrl: "",
                          fit:


                          BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: SpinKitThreeBounce(
                                size: 18, color: AppColor.primaryColor),
                          ),
                          errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Image.asset(
                              "assets/images/person.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                  ),


                ],
              ),
              SizedBox(height: Get.height*0.008,),


              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: Get.height*0.008,),
                      Image.asset("assets/images/chart.png",

                      ),

                      SizedBox(height: Get.height*0.023,),
                      AppText(
                        title: "Earning Summary",
                        size: AppSizes.size_16,
                        fontFamily: AppFont.semi,
                        fontWeight: FontWeight.w700,
                        color: AppColor.blackColor,
                      ),
                      SizedBox(height: Get.height*0.015,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColor.blueColor,
                                      AppColor.blueColor1,


                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10)

                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.015),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      title: "Total\nEarnings",
                                      size: AppSizes.size_14,
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.whiteColor,
                                    ),
                                    SizedBox(height: Get.height*0.02,),
                                    AppText(
                                      title: "\$0",
                                      size: AppSizes.size_14,
                                      fontFamily: AppFont.semi,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.whiteColor,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width*0.02,),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                Get.to(PendingView());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: new LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        AppColor.yellowColor,
                                        AppColor.yellowColor1,


                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10)

                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.015),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        title: "Pending\nPayments",
                                        size: AppSizes.size_14,
                                        fontFamily: AppFont.medium,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.whiteColor,
                                      ),
                                      SizedBox(height: Get.height*0.02,),
                                      AppText(
                                        title: "\$0",
                                        size: AppSizes.size_14,
                                        fontFamily: AppFont.semi,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.whiteColor,
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width*0.02,),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColor.greenColor,
                                      AppColor.greenColor1,


                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10)

                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.015),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      title: "Available\nBalance",
                                      size: AppSizes.size_14,
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.whiteColor,
                                    ),
                                    SizedBox(height: Get.height*0.02,),
                                    AppText(
                                      title: "\$0",
                                      size: AppSizes.size_14,
                                      fontFamily: AppFont.semi,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.whiteColor,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height*0.023,),
                      AppText(
                        title: "Recent Transaction",
                        size: AppSizes.size_16,
                        fontFamily: AppFont.semi,
                        fontWeight: FontWeight.w700,
                        color: AppColor.blackColor,
                      ),
                      SizedBox(height: Get.height*0.015,),
                      ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:  EdgeInsets.symmetric(vertical: 10),
                              child: GestureDetector(
                                onTap: () {

                                },
                                child: Row(

                                  children: [

                                    Container(
                                      height:Get.height*0.06,
                                      width: Get.height*0.06,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.yellowColor.withOpacity(0.4),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.asset("assets/images/Icon.png")),
                                      ),
                                    ),
                                    SizedBox(width: Get.width*0.01,),

                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.017),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  title:

                                                  "TXN123456",

                                                  fontFamily: AppFont.medium,
                                                  fontWeight: FontWeight.w500,
                                                  size: AppSizes.size_13,
                                                  color: AppColor.blackColor,
                                                ),
                                                SizedBox(height: Get.height*0.001,),
                                                AppText(
                                                  title: "Aug 10, 2023",
                                                  maxLines: 1,
                                                  overFlow: TextOverflow.ellipsis,

                                                  fontFamily: AppFont.regular,
                                                  fontWeight: FontWeight.w500,
                                                  size: AppSizes.size_13,
                                                  color: AppColor.greyColor,
                                                ),



                                              ],
                                            ),
                                            AppText(
                                              title:

                                              "\$0",

                                              fontFamily: AppFont.semi,
                                              fontWeight: FontWeight.w600,
                                              size: AppSizes.size_15,
                                              color: AppColor.yellowColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              )



            ],
          ),
        )
    );
  }
}
