import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/account_list.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/edit_profile.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/faq_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/store_list.dart';

import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/bottom_sheet.dart';
import 'package:mr_bet/widgets/helper_function.dart';

import '../../../home/controller/home_controller.dart';
import '../component/game_mannual.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              TopBar(onTap1: (){},onTap: (){
                Get.back();
              },text: "Profile Setting",
                  image: "assets/icons/share.svg",color: AppColor.whiteColor
              ),
              Container(
                color: AppColor.headColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.028,
                      ),
                      Obx(
                        () {
                          return Row(
                            children: [
                              Get.put(HomeController()).imageLoader.value?
                               Center(
                                  child: SpinKitThreeBounce(
                                      size: 17, color: AppColor.primaryColor))
                                  :
                              GestureDetector(
                                onTap:(){
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (builder) => bottomSheet(onCamera: () {
                                        Navigator.pop(context);
                                        HelperFunctions.pickImage(ImageSource.camera)
                                            .then((value) {
                                          setState(() {
                                            Get.put(HomeController()).updateImageLoader(true);
                                            Get.put(HomeController()).myProfile= value!;
                                            ApiManger().editUserResponse1(context: context);

                                          });
                                        });
                                      }, onGallery: () {
                                        Navigator.pop(context);
                                        HelperFunctions.pickImage(ImageSource.gallery)
                                            .then((value) {
                                          setState(() {
                                            Get.put(HomeController()).updateImageLoader(true);
                                            Get.put(HomeController()).myProfile= value!;
                                            ApiManger().editUserResponse1(context: context);
                                          });
                                        });
                                      }));
                                },
                                child: Container(
                                    height: Get.height * 0.12,
                                    width: Get.height * 0.12,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.primaryColor, width:
                                      Get.put(HomeController()).name.value.isNotEmpty?3:
                                      3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Obx(
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
                                    )),
                              ),
                              SizedBox(
                                width: Get.width * 0.05,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    title: Get.put(HomeController()).name.value,
                                    size: AppSizes.size_17,
                                    fontFamily: AppFont.semi,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.boldBlackColor,
                                  ),
                                  SizedBox(height: Get.height*0.003,),
                                  Image.asset("assets/images/line.png",
                                    width: Get.height*0.25,
                                    height: Get.height*0.008,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.006,
                                  ),

                                  Row(
                                    children: [

                                      AppText(
                                        title: "User ID: 00${Get.put(HomeController()).profileId.value}",
                                        size: AppSizes.size_12,
                                        fontFamily: AppFont.medium,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.boldBlackColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.008,
                                  ),

                                  Row(
                                    children: [
                                     Image.asset("assets/images/smart.png",

                                       height: Get.height * 0.024,
                                     ),
                                      SizedBox(
                                        width: Get.width * 0.017,
                                      ),
                                      AppText(
                                        title: Get.put(HomeController()).phone.value,
                                        size: AppSizes.size_13,
                                        fontFamily: AppFont.medium,
                                        fontWeight: FontWeight.w500,
                                        color:  AppColor.grey3Color,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.008,
                                  ),

                                  Row(
                                    children: [
                                      Image.asset("assets/images/email.png",

                                        height: Get.height * 0.024,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.017,
                                      ),
                                      AppText(
                                        title: Get.put(HomeController()).email.value,
                                        size: AppSizes.size_13,
                                        fontFamily: AppFont.medium,
                                        fontWeight: FontWeight.w500,
                                        color:  AppColor.grey3Color,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          );
                        }
                      ),
                      SizedBox(
                        height: Get.height * 0.017,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Get.height*0.025,),

                        profileWidget(
                            text: "Notification",
                            image: "assets/icons/noti.svg",
                            child: toggleButton(),
                            onTap: () {}),
                        SizedBox(
                          height: Get.height * 0.034,
                        ),
                        profileWidget(
                            text: "FaceId/FingerPrint Lock",
                            image: "assets/icons/face.svg",
                            child: toggleButton1(),
                            onTap: () {}),
                        SizedBox(
                          height: Get.height * 0.034,
                        ),
                        profileWidget(
                            text: "Switch Theme",
                            image: "assets/icons/theme.svg",
                            child: toggleButton2(),
                            onTap: () {}),
                        SizedBox(
                          height: Get.height * 0.034,
                        ),
                        profileWidget(
                            text: "Saved Bank Accounts",
                            image: "assets/icons/card.svg",
                            child: SizedBox.shrink(),
                            onTap: () {
                              Get.to(SaveBanks(),
                                  transition: Transition.rightToLeft);
                            }),
                        SizedBox(
                          height: Get.height * 0.034,
                        ),
                        profileWidget(
                            text: "Partners",
                            image: "assets/icons/banks.svg",
                            child: SizedBox.shrink(),
                            onTap: () {
                              Get.to(StoreList(),
                                  transition: Transition.rightToLeft);
                            }),
                        SizedBox(
                          height: Get.height * 0.034,
                        ),
                        profileWidget(
                            text: "FAQ",
                            image: "assets/icons/security.svg",
                            child: SizedBox.shrink(),
                            onTap: () {
                              Get.to(FaqView(),
                                  transition: Transition.rightToLeft);
                            }),
                        SizedBox(
                          height: Get.height * 0.034,
                        ),
                        profileWidget(
                            text: "Security",
                            image: "assets/icons/security.svg",
                            child: SizedBox.shrink(),
                            onTap: () {
                              Get.to(SaveBanks(),
                                  transition: Transition.rightToLeft);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: GestureDetector(
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
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: Get.width,
                    decoration: BoxDecoration(
                      border:
                      Border.all(color: AppColor.primaryColor, width: 1.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: Get.height * 0.018),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/logOut.svg",
                            color: AppColor.primaryColor,
                          ),
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
              ),
            ],
          ),
          Positioned(
              top: Get.height*0.06,
              right: 20,

              child:      GestureDetector(
            onTap: (){

              Get.to(EditProfile());
            },
            child: Container(
              height: Get.height * 0.042,
              width: Get.height * 0.042,
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(Get.height * 0.1))),
              child: Icon(
                Icons.edit,
                color: AppColor.whiteColor,
                size: AppSizes.size_20,
              ),
            ),
          ))
        ],
      ),
    );
  }
}
