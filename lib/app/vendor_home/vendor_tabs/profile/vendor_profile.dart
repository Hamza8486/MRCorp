import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/helper_function.dart';


class VendorProfile extends StatelessWidget {
  const VendorProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: Get.width*0.03,right: Get.width*0.05),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Center(
                      child: AppText(
                        title: "Profile",
                        color: AppColor.blackColor,
                        size: AppSizes.size_20,
                        fontFamily: AppFont.semi,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.055,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Obx(() {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.132,
                              width: MediaQuery.of(context).size.height * 0.132,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  Get.put(VendorController()).name.value.isNotEmpty?  BorderRadius.circular(100):
                                  BorderRadius.circular(100),
                                  border:
                                  Border.all(color: AppColor.primaryColor, width: 2)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Obx(
                                        () {
                                      return


                                        CachedNetworkImage(
                                          placeholder: (context, url) =>Center(
                                              child: SpinKitThreeBounce(
                                                  size: 16, color: AppColor.blackColor)
                                          ),
                                          imageUrl:"",
                                          fit: Get.put(VendorController()).name.value.isEmpty
                                              ? BoxFit.cover
                                              : BoxFit.cover,
                                          errorWidget: (context, url, error) => ClipRRect(
                                            borderRadius:


                                            BorderRadius.circular(100),
                                            child: Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                    }
                                ),
                              ),
                            );
                          }),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Obx(
                            () {
                          return AppText(
                            title:Get.put(VendorController()).name.value,
                            size: AppSizes.size_17,
                            overFlow: TextOverflow.ellipsis,
                            maxLines: 1,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          );
                        }
                    ),
                    Obx(
                            () {
                          return AppText(
                            title: Get.put(VendorController()).email.value,
                            size: AppSizes.size_14,
                            overFlow: TextOverflow.ellipsis,
                            maxLines: 1,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w500,
                            color: AppColor.grey,
                          );
                        }
                    ),
                    SizedBox(
                      height: Get.height * 0.008,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: AppColor.grey.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.008,
                    ),

                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: ()async{


                await  HelperFunctions().clearPrefs();
                Get.delete<VendorController>();
                Get.put(AuthController()).clear();
                Get.offAll(LoginView());
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(
                      color:
                      AppColor.primaryColor,
                      width: 1.7
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12, vertical: Get.height * 0.016),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/logout.svg"),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      AppText(
                        title: "Log Out",
                        size: AppSizes.size_14,
                        fontFamily: AppFont.bold,
                        color: AppColor.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: Get.height * 0.06,
            ),
          ],
        ),
      ),
    );
  }
}

Widget profileWidget({text, image, Widget? child, onTap, Widget? childs,
  Color?color
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              childs ??
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      child: SvgPicture.asset(
                        image,
                        height: Get.height * 0.032,
                      ),
                    ),
                  ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              AppText(
                title: text,
                fontFamily: AppFont.medium,
                size: AppSizes.size_15,
                fontWeight: FontWeight.w600,
                color:color?? AppColor.boldBlackColor,
              ),
            ],
          ),
          child ??
              SvgPicture.asset(
                "assets/icons/arrow.svg",
                height: Get.height * 0.015,
              ),
        ],
      ),
    ),
  );
}
