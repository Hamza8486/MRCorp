import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';

class Winners extends StatefulWidget {
  const Winners({Key? key}) : super(key: key);

  @override
  State<Winners> createState() => _WinnersState();
}

class _WinnersState extends State<Winners> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(HomeController()).getWinnerData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(
              onTap1: () {},
              onTap: () {},
              text: "Winner",
              isValue: false,
              Child: Container(height: Get.height*0.05,),
              image: "assets/icons/share.svg",
              color: AppColor.whiteColor),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [




                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(
                       () {
                        return
                          Get.put(HomeController()).winnerValue.value? Column(
                            children: [
                              SizedBox(height: Get.height*0.35,),
                               Center(
                                  child: SpinKitThreeBounce(
                                      size: 25, color: AppColor.primaryColor)
                              ),
                            ],
                          ):
                          Get.put(HomeController()).winnerList.isNotEmpty?

                          ListView.builder(
                            itemCount: Get.put(HomeController()).winnerList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) {
                              // Increment the index by 1 to get the actual index number
                              int indexNumber = index + 1;

                              // Convert the index number to a string with leading zeros when less than 10
                              String indexString = indexNumber.toString().padLeft(2, '0');
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          titlePadding: EdgeInsets.zero,
                                          contentPadding: EdgeInsets.only(
                                            left: Get.width * 0.05,
                                            right: Get.width * 0.05,
                                            top: Get.height * 0.01,
                                            bottom: Get.height * 0.01,
                                          ),
                                          content: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  10), color: AppColor.whiteColor,),

                                            height: Get.height * 0.33,
                                            width: Get.width * 0.5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.015,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                        height: Get.height * 0.08,
                                                        width: Get.height * 0.08,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColor
                                                                  .primaryColor,
                                                              width: 1.9),
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius
                                                              .circular(100),
                                                          child: Image.network(
                                                              Get.put(HomeController()).winnerList[index].user.image==null?"": Get.put(HomeController()).winnerList[index].user.image



                                                              , fit: BoxFit.cover,
                                                              errorBuilder: (
                                                                  context,
                                                                  exception,
                                                                  stackTrace) {
                                                                return ClipRRect(
                                                                  borderRadius: BorderRadius
                                                                      .circular(
                                                                      100),
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/images/persons.jpg",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                );
                                                              }),
                                                        )),
                                                    SizedBox(
                                                      width: Get.width * 0.03,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        AppText(
                                                          title:  Get.put(HomeController()).winnerList[index].user.fullName,
                                                          size: AppSizes.size_15,
                                                          fontFamily: AppFont
                                                              .medium,
                                                          fontWeight: FontWeight
                                                              .w600,
                                                          color: AppColor
                                                              .boldBlackColor,
                                                        ),
                                                        SizedBox(
                                                          height: Get.height *
                                                              0.005,
                                                        ),
                                                        AppText(
                                                          title: "00${indexString.toString()}",
                                                          size: AppSizes.size_12,
                                                          fontFamily: AppFont
                                                              .medium,
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          color: AppColor
                                                              .boldBlackColor,
                                                        ),

                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.025,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(40),
                                                    border: Border.all(
                                                        color: AppColor
                                                            .primaryColor),

                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(horizontal: 30),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .center,
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            AppText(
                                                              title: "Province",
                                                              size: AppSizes
                                                                  .size_11,
                                                              fontFamily: AppFont
                                                                  .medium,
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              color: Colors.black,
                                                            ),
                                                            SizedBox(height: 3,),
                                                            AppText(
                                                              title: Get.put(HomeController()).winnerList[index].province.name.toString(),
                                                              size: AppSizes
                                                                  .size_11,
                                                              fontFamily: AppFont
                                                                  .medium,
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              color: Colors.grey,
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: Get.height * 0.06,
                                                          width: Get.width * 0.003,
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .primaryColor,
                                                              borderRadius: BorderRadius
                                                                  .circular(20)
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .center,
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            AppText(
                                                              title: "Purchase Slots",
                                                              size: AppSizes
                                                                  .size_11,
                                                              fontFamily: AppFont
                                                                  .medium,
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              color: Colors.black,
                                                            ),
                                                            SizedBox(height: 3,),
                                                            AppText(
                                                              title: Get.put(HomeController()).winnerList[index].provinceSlotCount.toString(),
                                                              size: AppSizes
                                                                  .size_11,
                                                              fontFamily: AppFont
                                                                  .medium,
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              color: Colors.grey,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.015,
                                                ),
                                                AppText(
                                                  title: "Prize:",
                                                  size: AppSizes.size_13,
                                                  fontFamily: AppFont.semi,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.primaryColor,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.005,
                                                ),
                                                AppText(
                                                  title:Get.put(HomeController()).winnerList[index].luckyType.toString(),
                                                  size: AppSizes.size_11,
                                                  fontFamily: AppFont.medium,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.grey2Color,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.025,
                                                ),
                                                AppButton(
                                                  buttonColor: AppColor.grey2Color
                                                      .withOpacity(0.6),
                                                  textColor: AppColor.whiteColor,
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  buttonName: "Cancel",
                                                  buttonHeight: Get.height * 0.04,
                                                  buttonWidth: Get.width,
                                                  buttonRadius: BorderRadius
                                                      .circular(20),
                                                )
                                              ],
                                            ),
                                          )
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  AppText(
                                                    title: indexString.toString(),
                                                    size: AppSizes.size_16,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(width: Get.width * 0.02,),
                                                  Container(
                                                      height: Get.height * 0.053,
                                                      width: Get.height * 0.053,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColor.primaryColor
                                                                .withOpacity(0.6),
                                                            width: 1.9),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius
                                                            .circular(100),
                                                        child: Image.network(
                                                            Get.put(HomeController()).winnerList[index].user.image==null?"":              Get.put(HomeController()).winnerList[index].user.image,
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (context,
                                                                exception, stackTrace) {
                                                              return ClipRRect(
                                                                borderRadius: BorderRadius
                                                                    .circular(100),
                                                                child: Image.asset(
                                                                  "assets/images/persons.jpg",
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              );
                                                            }),
                                                      )),
                                                  SizedBox(width: Get.width * 0.02,),
                                                  AppText(
                                                    title: Get.put(HomeController()).winnerList[index].user.fullName.toString(),
                                                    size: AppSizes.size_15,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.primaryColor,
                                                    borderRadius: BorderRadius.circular(
                                                        20)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 17, vertical: 6),
                                                  child: AppText(
                                                    title: "See",
                                                    size: AppSizes.size_12,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 7,),
                                          Divider(color: Colors.grey.withOpacity(0.7),),
                                          SizedBox(height: 7,),


                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }):noData(height: Get.height*0.35);
                      }
                    ),


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