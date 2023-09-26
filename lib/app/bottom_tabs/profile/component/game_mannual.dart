import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/component.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';


class GameManual extends StatelessWidget {
  const GameManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          TopBar(
              onTap1: () {},


              onTap: () {

              },
              text: "Game Manual",
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
                    SizedBox(height: Get.height*0.015,),
                    AppText(
                      title: "Game Manuel to buy a Car Slot:",
                      size: AppSizes.size_16,
                      fontFamily: AppFont.semi,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primaryColor,
                    ),
                    SizedBox(height: Get.height*0.015,),
                    textProfile("1. Price for each car slot is \$5"),
                    SizedBox(height: Get.height*0.015,),
                    textProfile("2. There are total 13 Province."),
                    SizedBox(height: Get.height*0.015,),
                    textProfile("3. You can purchase 20 slots in each Province."),
                    SizedBox(height: Get.height*0.015,),
                    textProfile("4. Time for slot is start with week in morning at 9am."),
                    SizedBox(height: Get.height*0.015,),
                    textProfile("5. Time for slot is ends on same day next week at 5pm."),
                    SizedBox(height: Get.height*0.015,),
                    textProfile("6. Results will shown after 1 hour of closing time."),
                    SizedBox(height: Get.height*0.02,),
                    Image.asset("assets/images/table.png"),


                    SizedBox(height: Get.height*0.02,),
                    AppText(
                      title: "Game Manuel to buy a House Slot:",
                      size: AppSizes.size_16,
                      fontFamily: AppFont.semi,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primaryColor,
                    ),
                    SizedBox(height: Get.height*0.015,),
                    textProfile("1. Price for each car slot is \$20"),
                    SizedBox(height: Get.height*0.015,),
                    textProfile("2. There are total 13 Province."),
                    SizedBox(height: Get.height*0.015,),
                    textProfile("3. You can purchase 20 slots in each Province."),
                    SizedBox(height: Get.height*0.015,),
                    textProfile("4. Time for slot is start with week in morning at 9am."),
                    SizedBox(height: Get.height*0.015,),
                    textProfile("5. Time for slot is ends on same day next week at 5pm."),
                    SizedBox(height: Get.height*0.015,),
                    textProfile("6. Results will shown after 1 hour of closing time."),
                    SizedBox(height: Get.height*0.02,),
                    Image.asset("assets/images/table.png"),
                    SizedBox(height: Get.height*0.05,),
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
