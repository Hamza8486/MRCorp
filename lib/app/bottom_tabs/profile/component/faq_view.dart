import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';

import 'package:mr_bet/util/theme.dart';

class FaqView extends StatelessWidget {
  const FaqView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: Column(children: [
          TopBar(
              onTap1: () {},
              onTap: () {
                Get.back();
              },
              text: "FAQs   ",
              image: "assets/icons/share.svg",
              color: AppColor.whiteColor),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () {
                    return
                      Get.put(HomeController()).faqLoading.value?Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: Get.height * 0.35),
                          Center(
                              child: SpinKitThreeBounce(
                                  size: 20, color: AppColor.primaryColor)),
                        ],
                      ):


                      ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: Get.put(HomeController()).faqList.length,
                      itemBuilder: (context, index) {
                        return ExpandBox(
                          text:
                          Get.put(HomeController()).faqList[index].question,
                          text1: Get.put(HomeController()).faqList[index].answer,
                        );
                      },
                    );
                  }
                )
              ],
            ),
          ))
        ])),
      ],
    );
  }
}


// ignore_for_file: prefer_const_constructors



class ExpandBox extends StatelessWidget {
  ExpandBox({Key? key,this.text,this.text1}) : super(key: key);


  var text;
  var text1;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Obx(
          () => Container(
        width: width,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: Get.height*0.01,horizontal: Get.width*0.02),
            child: ExpansionTile(
              title:  Text(
                text,
                style: TextStyle(
                  fontSize: AppSizes.size_15,
                  fontFamily: AppFont.medium,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primaryColor,
                ),
              ),
              trailing: Get.put(HomeController()).expand.value == true
                  ? const Icon(Icons.arrow_drop_up, color: AppColor.primaryColor)
                  : const Icon(Icons.arrow_drop_down, color: AppColor.primaryColor),
              onExpansionChanged: (bool val) {
                Get.put(HomeController()).expand.value = val;
              },

              children:  [
                ListTile(
                  title: Text(
                    text1,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: AppSizes.size_13,
                      color: AppColor.blackColor,
                      fontFamily: AppFont.regular,

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
