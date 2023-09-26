import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/auth/address.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/app/vendor_home/vendor_home.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/drop_down.dart';
import 'package:mr_bet/widgets/helper_function.dart';
import 'package:mr_bet/widgets/image_pick.dart';


class BusinessRegister extends StatefulWidget {
  BusinessRegister({Key? key}) : super(key: key);

  @override
  State<BusinessRegister> createState() => _BusinessRegisterState();
}

class _BusinessRegisterState extends State<BusinessRegister> {
  final authController = Get.put(AuthController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: AppPaddings.mainPadding,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.045,
                        ),

                        Center(child: Image.asset("assets/images/logo1.png",height: Get.height*0.1,)),

                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AppText(
                          title: "Sign up",
                          size: AppSizes.size_24,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.boldBlackColor,
                        ),
                        SizedBox(
                          height: Get.height * 0.004,
                        ),
                        AppText(
                          title: "Please enter your data to create business account ",
                          size: AppSizes.size_12,
                          fontFamily: AppFont.regular,
                          color: Colors.black.withOpacity(0.5),
                        ),

                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        textAuth(text: "Full Name"),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return null;
                            }
                            if (!RegExp("[a-zA-Z]").hasMatch(value)) {
                              return null;
                            }
                            return null;
                          },
                          hint: "alexandra daddario",
                          controller: authController.fullNameController,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: "Email"),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField( validator: (value) => EmailValidator.validate(value!)
                            ? null
                            : "Please enter a valid email",
                          hint: "Example@gmail.com",
                          controller: authController.emailRegController,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        textAuth(text: "Store Name"),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return null;
                            }
                            if (!RegExp("[a-zA-Z]").hasMatch(value)) {
                              return null;
                            }
                            return null;
                          },
                          hint: "Enter store name",
                          controller: authController.storeNameController,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: "Store Address"),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(
                            hint: "Enter store address",
                            onTap:(){
                              Get.to(AddAddress());
                            },

                            controller: authController.addressController,
                            textInputType: TextInputType.streetAddress,
                            isRead: true,
                            isCur: false,
                            textInputAction: TextInputAction.next
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: "Phone Number"),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(
                            hint: "Phone Number",
                            controller: authController.mobileController,
                            textInputType: TextInputType.phone,
                            textInputAction: TextInputAction.next
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: "Province"),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Obx(
                                () {
                              return SizedBox(

                                child: dropDownButtons(
                                    color: AppColor.borderColorField,
                                    color1: AppColor.borderColorField,

                                    contentPadding: EdgeInsets.symmetric(vertical: Get.height*0.016),
                                    color2:  AppColor.greyColors,

                                    hinText: "Select Province",
                                    value: authController.provinceId,
                                    onChanged: (value) async {
                                      setState(() {
                                        authController.provinceId=value;
                                      });



                                    },
                                    items: countryDataList(
                                        dataList: authController
                                            .provinceList)),
                              );
                            }
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        SizedBox(
                          height: Get.height * 0.017,
                        ),
                        textAuth(text: "Upload Picture"),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        DottedBorder(
                          strokeCap: StrokeCap.square,
                          color:Colors.grey.withOpacity(0.7),
                          dashPattern: [10, 7],
                          strokeWidth: 1.6,
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
                                        Get.put(AuthController()).file = value!;
                                      });
                                    });
                                  }, onGallery: () {
                                    Navigator.pop(context);
                                    HelperFunctions.pickImage(ImageSource.gallery)
                                        .then((value) {
                                      setState(() {
                                        Get.put(AuthController()).file = value!;
                                      });
                                    });
                                  }));
                            },
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                     vertical: Get.put(AuthController()).file==null?20: 5),
                                child: Column(
                                  children: [
                                    Get.put(AuthController()).file==null?
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.greys,
                                              shape: BoxShape.circle
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset("assets/images/gal.png",
                                              height: Get.height*0.03,
                                            ),
                                          ) ,
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.redLight,
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child:Padding(
                                              padding:  EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                              child:   AppText(
                                                title: "Upload Picture",
                                                size: AppSizes.size_10,
                                                color: AppColor.boldBlackColor,
                                                fontFamily: AppFont.medium,


                                              )
                                          ) ,
                                        ),
                                      ],
                                    ):
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: Get.width,
                                        height: Get.height*0.1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColor.primaryColor,
                                              width: 2),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                  Get.put(AuthController()).file as File
                                              )),
                                        ),
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                Get.put(AuthController()).file=null;
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: Get.height * 0.15,
                                                  left: Get.width * 0.76),
                                              child: const Icon(
                                                Icons.cancel_outlined,
                                                color: Colors.red,
                                              ),
                                            )),
                                      ),
                                    )
                                    ,



                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.017,
                        ),
                        textAuth(text: "Upload license Document"),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        ImagePick(
                          text:"Upload",
                        ),

                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        textAuth(text: "Password"),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        Obx(() {
                          return betField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              // if(value.length<8)
                              // {
                              //   return 'Password must be greater then 8 character';
                              // }
                              return null;
                            },
                            hint: "Password",
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscure: authController.isVisible1.value,
                            controller: authController.passRegController,
                            child:    IconButton(
                                onPressed: () {
                                  authController.updateVisible1Status();
                                },
                                icon: Icon(
                                    authController.isVisible1.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: Get.height * 0.022,
                                    color: AppColor.blackColor)),
                          );
                        }),
                        SizedBox(
                          height: Get.height * 0.012,
                        ),


                      ],
                    ),
                  ),
                ),
                isKeyBoard?SizedBox.shrink():
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(10),
                        buttonName: "Sign up",
                        fontWeight: FontWeight.w500,
                        textSize: AppSizes.size_15,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          if(validateRegister(context)){
                            authController.updateLoader(true);
                            ApiManger().businessRegister(context: context);
                          }

                        }),
                    SizedBox(
                      height: Get.height * 0.012,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.offAll(LoginView());
                          Get.put(AuthController()).clear();

                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account ? ",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w500,
                                fontSize: AppSizes.size_15),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Sign in",
                                  style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppSizes.size_15)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Obx(() {
          return authController.loader.value == false
              ? SizedBox.shrink()
              : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.7),
            child:   Center(
                child: SpinKitThreeBounce(
                    size: 25, color: AppColor.primaryColor)
            ),
          );



        })
      ],
    );
  }

  List<DropdownMenuItem<int>> countryDataList({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: AppText(
            title: dataList[i].name,
            size: AppSizes.size_15,
            color: AppColor.blackColor,
            fontFamily: AppFont.regular,
            fontWeight: FontWeight.w500,
          )));
    }
    return outputList;
  }

  bool validateRegister(BuildContext context) {


    if (Get.put(AuthController()).fullNameController.text.isEmpty) {
      flutterToast(msg: "Please enter name");
      return false;
    }
    if (Get.put(AuthController()).emailRegController.text.isEmpty) {
      flutterToast(msg: "Please enter email");
      return false;
    }
    if (Get.put(AuthController()).storeNameController.text.isEmpty) {
      flutterToast(msg: "Please enter store name");
      return false;
    }
    if (Get.put(AuthController()).addressController.text.isEmpty) {
      flutterToast(msg: "Please enter store address");
      return false;
    }

    if (Get.put(AuthController()).mobileController.text.isEmpty) {
      flutterToast(msg: "Please enter phone number");
      return false;
    }
    if (Get.put(AuthController()).mobileController.text.length<9) {
      flutterToast(msg: "Please enter valid phone number");
      return false;
    }

    if (Get.put(AuthController()).provinceId==null) {
      flutterToast(msg: "Please select province");
      return false;
    }
    if (Get.put(AuthController()).file==null) {

      flutterToast(msg: "Please upload store logo");
      return false;
    }
    if (Get.put(AuthController()).file1==null) {
      flutterToast(msg: "Please upload store license");
      return false;
    }

    if (Get.put(AuthController()).passRegController.text.isEmpty) {
      flutterToast(msg: "Please enter password");
      return false;
    }

    if (Get.put(AuthController()).passRegController.text.length<7) {
      flutterToast(msg: "Password must be greater then 7 digit");
      return false;
    }







    return true;
  }
}
