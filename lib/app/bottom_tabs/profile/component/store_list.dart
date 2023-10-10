import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/user_store.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';

import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';


class StoreList extends StatelessWidget {
  const StoreList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Column(
            children: [
              TopBar(onTap1: (){},onTap: (){
                Get.back();
              },text: "Partners",
                  image: "assets/icons/share.svg",color: AppColor.whiteColor
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        AppColor.primaryColor.withOpacity(0.3),
                        AppColor.primaryColor1.withOpacity(0.1),



                      ],
                    ),
                  ),
                  width: Get.width,
                  height: Get.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(
                          () {
                            return
                              Get.put(HomeController()).storeLoading.value?Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: Get.height * 0.35),
                                  Center(
                                      child: SpinKitThreeBounce(
                                          size: 20, color: AppColor.primaryColor)),
                                ],
                              ):



                              Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  primary: false,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: Get.width / Get.height * 1.45,
                                      crossAxisSpacing: 13,
                                      mainAxisSpacing: 10),
                                  itemCount: Get.put(HomeController()).storeList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return storeDataComponents(
                                        imageTap:(){},
                                        editTap: (){},
                                        image: Get.put(HomeController()).storeList[index].storePicture.toString(),
                                        title:Get.put(HomeController()).storeList[index].storeName,
                                        toogleText: "Active",
                                        address: Get.put(HomeController()).storeList[index].storeAddress,
                                      distance: index==0?"5KM":index==0?"10KM":"20KM",
                                        color:AppColor.greenColor,
                                        textColor:AppColor.greenColor,
                                        backColor:AppColor.greenColor.withOpacity(0.4),
                                    );
                                  }),
                            );
                          }
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
              top: Get.height * 0.065,
              right: 20,
              child:  GestureDetector(
                onTap: (){
                  Get.to(UserStore());
                },
                child: Image.asset("assets/images/plus.png",
                  height: Get.height*0.033,
                ),
              )),
        ],
      ),
    );
  }


}

Widget storeDataComponents({color,backColor,title,address,toogleText,textColor,image,
  editTap,

  imageTap,
  distance


}){
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColor.whiteColor,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: backColor,
                      border: Border.all(
                          color: color,
                          width: 1.1)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    child: Center(
                      child: AppText(
                        title: toogleText,
                        color:textColor,
                        fontFamily: AppFont.medium,
                        size: AppSizes.size_10,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Get.width*0.03,),
                Container()
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(70),
                //       border: Border.all(
                //           color: AppColor.primaryColor,
                //
                //           width: 1),
                //   color: AppColor.primaryColor
                //   ),
                //   child: Padding(
                //       padding: EdgeInsets.symmetric(
                //           horizontal: 5, vertical: 5),
                //       child:   Icon(Icons.delete,size: Get.height*0.017,
                //         color: AppColor.whiteColor,
                //       )
                //   ),
                // ),
              ],
            ),
            SizedBox(height: Get.height*0.017,),
            GestureDetector(
              onTap: imageTap,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColor.blackColor,width: 2)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child:
                    CachedNetworkImage(
                      placeholder: (context, url) =>  Center(
                        child: SpinKitThreeBounce(
                            size: 15,
                            color: AppColor.primaryColor
                        ),
                      ),
                      imageUrl:image??"",
                      height: Get.height * 0.08,
                      width: Get.height*0.08,
                      fit: BoxFit.cover,

                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/t.jpeg',
                        height: Get.height * 0.078,
                        width: Get.height*0.078,
                        fit: BoxFit.cover,
                      ),
                    ),




                  ),
                ),
              ),
            ),

            SizedBox(height: Get.height*0.009,),
            SizedBox(
              width:Get.width*0.34,
              child: Center(
                child: AppText(
                  title: title,
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  fontFamily:AppFont.medium,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.start,
                  size: AppSizes.size_13,
                  color: AppColor.blackColor,
                ),
              ),
            ),
            SizedBox(height: Get.height*0.01,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color: AppColor.primaryColor,
                  size: AppSizes.size_13,
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                SizedBox(
                  width: Get.width*0.3,
                  child: AppText(
                    title: address,
                    overFlow: TextOverflow.ellipsis,
                    maxLines: 1,
                    size: Get.height * 0.012,
                    textAlign: TextAlign.start,
                    color: AppColor.blackColor,
                    fontFamily: AppFont.medium,
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height*0.01,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(
                  title: "Distance: ",
                  overFlow: TextOverflow.ellipsis,
                  maxLines: 1,
                  size: Get.height * 0.012,
                  textAlign: TextAlign.start,
                  color: AppColor.blackColor,
                  fontFamily: AppFont.semi,
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                AppText(
                  title: distance.toString(),
                  overFlow: TextOverflow.ellipsis,
                  maxLines: 1,
                  size: Get.height * 0.014,
                  textAlign: TextAlign.start,
                  color: AppColor.blackColor,
                  fontFamily: AppFont.medium,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}