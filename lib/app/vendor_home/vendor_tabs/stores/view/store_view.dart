import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/stores/component/add_store.dart';

import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';


class StoreView extends StatelessWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.04),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.055,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                AppText(
                  title: "Store Lists",
                  color: AppColor.blackColor,
                  size: AppSizes.size_18,
                  fontFamily: AppFont.semi,
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(AddStore());
                  },
                  child: Image.asset("assets/images/plus.png",
                  height: Get.height*0.033,
                  ),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.005,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () {
                        return
                          Get.put(VendorController()).storeLoading.value?Column(
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
                            primary: false,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: Get.put(VendorController()).storeList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10),
                                child: GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                      color: AppColor.whiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.15),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 2), // changes position of shadow
                                        ),
                                      ],


                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(

                                        children: [

                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(1000),
                                            child: CachedNetworkImage(
                                                placeholder: (context, url) =>  Center(
                                                  child: SpinKitThreeBounce(
                                                      size: 20,
                                                      color: AppColor.primaryColor
                                                  ),
                                                ),
                                                imageUrl:
                                                Get.put(VendorController()).storeList[index].storePicture,
                                                height: Get.height * 0.07,
                                                width: Get.height * 0.07,
                                                fit: BoxFit.cover,

                                                errorWidget: (context, url, error) => ClipRRect(
                                                  borderRadius: BorderRadius.circular(10000),
                                                  child: Image.asset(
                                                    "assets/images/t.jpeg",
                                                    height: Get.height * 0.09,
                                                    width: Get.height * 0.09,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                            ),











                                          ),
                                          SizedBox(width: Get.width*0.01,),

                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.017),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    title:
                                                    Get.put(VendorController()).storeList[index].storeName,

                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w500,
                                                    size: AppSizes.size_13,
                                                    color: AppColor.blackColor,
                                                  ),
                                                  SizedBox(height: Get.height*0.001,),
                                                  AppText(
                                                    title: Get.put(VendorController()).storeList[index].storeAddress,
                                                    maxLines: 1,
                                                    overFlow: TextOverflow.ellipsis,

                                                    fontFamily: AppFont.regular,
                                                    fontWeight: FontWeight.w500,
                                                    size: AppSizes.size_13,
                                                    color: AppColor.greyColor,
                                                  ),



                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
