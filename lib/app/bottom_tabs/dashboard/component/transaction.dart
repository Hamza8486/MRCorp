import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_text.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({Key? key}) : super(key: key);

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          TopBar(onTap1: (){},onTap: (){
            Get.back();
          },text: "My Transaction",
              image: "assets/icons/share.svg",color: AppColor.whiteColor
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Obx(
                            () {
                          return
                            Get.put(HomeController()).transactionLoadingValue.value?Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: Get.height * 0.35),
                                Center(
                                    child: SpinKitThreeBounce(
                                        size: 20, color: AppColor.primaryColor)),
                              ],
                            ):
                            Get.put(HomeController()).transList.isNotEmpty?

                            ListView.builder(
                                itemCount: Get.put(HomeController()).transList.length,
                                shrinkWrap: true,
                                primary: false,
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  DateTime time = DateTime.parse(
                                    Get.put(HomeController()).transList[index].createdAt,
                                  );
                                  DateTime dateTime = DateTime.parse(Get.put(HomeController()).transList[index].createdAt.toString());
                                  String formattedTime = DateFormat('hh:mm a').format(dateTime);
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 9),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height:Get.height*0.05,
                                                width:Get.height*0.05 ,
                                                decoration: BoxDecoration(
                                                    color: AppColor.primaryColor,
                                                    borderRadius: BorderRadius.circular(
                                                        10)
                                                ),
                                                child: Center(
                                                  child: AppText(
                                                    title: Get.put(HomeController()).transList[index].id.toString(),
                                                    size: AppSizes.size_14,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.whiteColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: Get.width * 0.04,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  AppText(
                                                    title: "\$${Get.put(HomeController()).transList[index].amount.toString()}",
                                                    size: AppSizes.size_15,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.blackColor,
                                                  ),
                                                  SizedBox(height: 3,),
                                                  AppText(
                                                    title: "Deposit ${formattedTime.toString()}",
                                                    size: AppSizes.size_13,
                                                    fontFamily: AppFont.regular,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor.blackColor,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          AppText(
                                            title:  "${DateFormat('dd/MM/yyyy').format(
                                                time
                                            )} ",
                                            size: AppSizes.size_13,
                                            fontFamily: AppFont.regular,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.blackColor,
                                          ),

                                        ],
                                      ),
                                    ),
                                  );
                                }):noData(height: Get.height*0.35);
                        }
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
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