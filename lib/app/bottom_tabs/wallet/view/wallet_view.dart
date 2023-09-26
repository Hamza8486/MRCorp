import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/controller/wallet_controller.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/app_textfield.dart';
import 'package:mr_bet/widgets/bottom_sheet.dart';
import 'package:mr_bet/widgets/helper_function.dart';

class WalletView extends StatefulWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          TopBar(onTap1: (){},onTap: (){
            Get.back();
          },text: "My Wallet",
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
                      height: Get.height * 0.02,
                    ),
                    AppText(
                      title: "Your Total Balance:",
                      size: AppSizes.size_15,
                      fontFamily: AppFont.medium,
                      fontWeight: FontWeight.w600,
                      color: AppColor.greyColors,
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Obx(
                            () {
                          return
                            Get.put(HomeController()).walletLoadingValue.value?
                             Center(
                                child: SpinKitThreeBounce(
                                    size: 13, color: AppColor.primaryColor)):
                            Get.put(HomeController()).totalAmountWallet.value=="0"?

                            Center(
                              child: AppText(
                                title: "\$0",
                                size: AppSizes.size_16,
                                fontFamily: AppFont.semi,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ):Center(
                              child: AppText(
                                title: "\$${Get.put(HomeController()).totalAmountWallet.value.toString()}",
                                size: AppSizes.size_17,
                                fontFamily: AppFont.semi,
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            );
                        }
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                                  () {
                                return
                                  Get.put(PaymentController()).checkLoader.value?
                                  Center(
                                      child: SpinKitThreeBounce(
                                          size: 25, color: AppColor.primaryColor))

                                      :

                                  AppButton(
                                      buttonWidth: Get.width,
                                      buttonRadius: BorderRadius.circular(10),
                                      buttonName: "Add Money",
                                      fontWeight: FontWeight.w500,
                                      buttonHeight: Get.height*0.054,
                                      textSize: AppSizes.size_15,
                                      buttonColor: AppColor.primaryColor,
                                      textColor: AppColor.whiteColor,
                                      onTap: () {
                                        Get.generalDialog(
                                            pageBuilder: (context, __, ___) => AlertDialog(

                                              content: SizedBox(
                                                height: Get.height*0.18,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    textAuth(text: "Enter Amount"),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    betField(
                                                      hint: "Enter amount",
                                                      onChange: (val){
                                                        setState(() {
                                                          if(val!.isEmpty||val=="0"){
                                                            Get.put(PaymentController()).updateCheckPayment("");
                                                            Get.put(PaymentController()).priceController.clear();
                                                          }
                                                          else{
                                                            Get.put(PaymentController()).updateCheckPayment(val.toString());
                                                          }


                                                        });
                                                      },


                                                      controller: Get.put(PaymentController()).priceController,


                                                    ),
                                                    SizedBox(height: Get.height*0.025,),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: AppButton(
                                                              buttonWidth: Get.width,
                                                              buttonHeight: Get.height*0.055,

                                                              buttonRadius: BorderRadius.circular(10),
                                                              borderColor: AppColor.primaryColor,
                                                              borderWidth: 1.5,
                                                              buttonName: "Cancel", buttonColor: AppColor.transParent, textColor: AppColor.whiteColor, onTap: (){
                                                            Get.back();

                                                          }),
                                                        ),
                                                        SizedBox(width: Get.width*0.03,),
                                                        Expanded(
                                                          child: Obx(
                                                                  () {
                                                                return AppButton(
                                                                    buttonWidth: Get.width,
                                                                    buttonHeight:
                                                                    Get.put(PaymentController()).checkPayment.value.isEmpty?Get.height*0.055:
                                                                    Get.height*0.055,

                                                                    buttonRadius: BorderRadius.circular(10),
                                                                    buttonName: "Add", buttonColor:

                                                                Get.put(PaymentController()).checkPayment.value.isEmpty?AppColor.primaryColor.withOpacity(0.6):
                                                                AppColor.primaryColor, textColor: AppColor.whiteColor,

                                                                    onTap:
                                                                    Get.put(PaymentController()).checkPayment.value.isEmpty
                                                                        ? () {
                                                                      flutterToast(msg: "Please enter amount");
                                                                    }
                                                                        :
                                                                        (){
                                                                      Get.put(PaymentController()).updateCheckLoader(true);
                                                                      // Get.put(PaymentController()).priceController.clear();


                                                                      Get.back();
                                                                      setState(() {
                                                                        Get.put(PaymentController()).makePayment(amount: Get.put(PaymentController()).checkPayment.value, currency: 'cad');

                                                                      });
                                                                    });
                                                              }
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),

                                            ));

                                      });
                              }
                          ),
                        ),
                        SizedBox(width: Get.width*0.04,),
                        Expanded(
                            child: Obx(
                               () {
                                return
                                  Get.put(HomeController()).checkLoader.value?
                                  Center(
                                      child: SpinKitThreeBounce(
                                          size: 25, color: AppColor.primaryColor))

                                      :

                                  AppButton(
                                    buttonWidth: Get.width,
                                    buttonRadius: BorderRadius.circular(10),
                                    buttonName: "Upload Receipt",
                                    fontWeight: FontWeight.w500,
                                    buttonHeight: Get.height*0.054,
                                    textSize: AppSizes.size_15,
                                    buttonColor: AppColor.primaryColor,
                                    textColor: AppColor.whiteColor,
                                    onTap: () {
                                      setState(() {
                                        Get.put(HomeController()).file1=null;
                                        Get.put(HomeController()).priceController.clear();
                                      });
                                      Get.generalDialog(
                                          pageBuilder: (context, __, ___) => AlertDialog(

                                            content: SizedBox(
                                              height: Get.height*0.48,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: AppText(
                                                      title: "Upload Recipe",
                                                      size: AppSizes.size_16,
                                                      fontFamily: AppFont.medium,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColor.boldBlackColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.03,
                                                  ),
                                                  textAuth(text: "Upload Recipe"),
                                                  SizedBox(
                                                    height: Get.height * 0.02,
                                                  ),
                                                  SizedBox(
                                                    width: Get.width,
                                                    height: Get.height*0.12,
                                                    child: DottedBorder(
                                                      color: Colors.grey,
                                                      dashPattern: const [8, 4],
                                                      strokeWidth: 1.8,
                                                      child: MaterialButton(
                                                        minWidth: Get.width,
                                                        onPressed: () {
                                                          showModalBottomSheet(
                                                              backgroundColor: Colors.transparent,
                                                              context: context,
                                                              builder: (builder) => bottomSheet(onCamera: () {
                                                                Navigator.pop(context);
                                                                HelperFunctions.pickImage(ImageSource.camera)
                                                                    .then((value) {
                                                                  setState(() {
                                                                    Get.find<HomeController>().file1 = value!;
                                                                  });
                                                                });
                                                              }, onGallery: () {
                                                                Navigator.pop(context);
                                                                HelperFunctions.pickImage(ImageSource.gallery)
                                                                    .then((value) {
                                                                  setState(() {
                                                                    Get.find<HomeController>().file1 = value!;
                                                                  });
                                                                });
                                                              }));

                                                        },
                                                        child: Padding(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: Get.width * 0.02, vertical: 15),
                                                            child:

                                                            Get.find<HomeController>().file1==null?
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                SvgPicture.asset(
                                                                  "assets/images/photo.svg",
                                                                  height: Get.height * 0.03,
                                                                  color: AppColor.primaryColor,
                                                                ),

                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                AppText(
                                                                  title: "Upload receipt",
                                                                  fontFamily: AppFont.medium,
                                                                  size: Get.height * 0.013,
                                                                  color: AppColor.blackColor,
                                                                ),

                                                              ],
                                                            ):
                                                            Image.file(Get.find<HomeController>().file1 as File)

                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.025,
                                                  ),
                                                  textAuth(text: "Enter Amount"),
                                                  SizedBox(
                                                    height: Get.height * 0.015,
                                                  ),
                                                  betField(
                                                    hint: "Enter amount",

                                                    controller: Get.put(HomeController()).priceController,


                                                  ),
                                                  SizedBox(height: Get.height*0.06,),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: AppButton(
                                                            buttonWidth: Get.width,
                                                            buttonHeight: Get.height*0.055,

                                                            buttonRadius: BorderRadius.circular(10),
                                                            borderColor: AppColor.primaryColor,
                                                            borderWidth: 1.5,
                                                            buttonName: "Cancel", buttonColor: AppColor.transParent, textColor: AppColor.whiteColor, onTap: (){
                                                          Get.back();

                                                        }),
                                                      ),
                                                      SizedBox(width: Get.width*0.03,),
                                                      Expanded(
                                                        child: Obx(
                                                                () {
                                                              return AppButton(
                                                                  buttonWidth: Get.width,
                                                                  buttonHeight:
                                                                  Get.put(PaymentController()).checkPayment.value.isEmpty?Get.height*0.055:
                                                                  Get.height*0.055,

                                                                  buttonRadius: BorderRadius.circular(10),
                                                                  buttonName: "Upload", buttonColor:

                                                              Get.put(PaymentController()).checkPayment.value.isEmpty?AppColor.primaryColor:
                                                              AppColor.primaryColor, textColor: AppColor.whiteColor,

                                                                  onTap:(){
                                                                    if(validateReceipt(context)){
                                                                      Get.put(HomeController()).updateCheckLoader(true);
                                                                    }
                                                                  });
                                                            }
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),

                                          ));

                                    });
                              }
                            )
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(
                      () {
                        return
                          Get.put(HomeController()).walletLoadingValue.value?Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: Get.height * 0.25),
                               Center(
                                  child: SpinKitThreeBounce(
                                      size: 20, color: AppColor.primaryColor)),
                            ],
                          ):
                        Get.put(HomeController()).walletList.isNotEmpty?

                          ListView.builder(
                            itemCount: Get.put(HomeController()).walletList.length,
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
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
                                            decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
                                                borderRadius: BorderRadius.circular(
                                                    10)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: AppText(
                                                title: Get.put(HomeController()).walletList[index].province.name,
                                                size: AppSizes.size_14,
                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.whiteColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              AppText(
                                                title: Get.put(HomeController()).walletList[index].province.name,
                                                size: AppSizes.size_15,
                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.blackColor,
                                              ),
                                              AppText(
                                                title: "Coupon = ${Get.put(HomeController()).walletList[index].slot.toString()}",
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
                                        title: "\$${Get.put(HomeController()).walletList[index].amount.toString()}.00",
                                        size: AppSizes.size_14,
                                        fontFamily: AppFont.medium,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.blackColor,
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            }):SizedBox.shrink();
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

  bool validateReceipt(BuildContext context) {

    if (Get.put(HomeController()).file1==null) {
      flutterToast(msg: "Please upload receipt");
      return false;
    }
    if (Get.put(HomeController()).priceController.text.isEmpty) {
      flutterToast(msg: "Please enter price");
      return false;
    }






    return true;
  }
}