import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/drop_down.dart';


class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                          title: "Please enter your data to create account ",
                          size: AppSizes.size_13,
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
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textAuth(text: "Occupation"),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  betField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter occupation';
                                      }
                                      if (!RegExp("[a-zA-Z]").hasMatch(value)) {
                                        return 'Please enter occupation';
                                      }
                                      return null;
                                    },
                                    hint: "Bets Skills",
                                    controller: authController.occuController,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: Get.width*0.03,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textAuth(text: "Province"),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Obx(
                                          () {
                                        return SizedBox(
                                          height: Get.height*0.055,
                                          child: dropDownButtons(
                                            color: AppColor.borderColorField,
                                              color1: AppColor.borderColorField,

                                              contentPadding: EdgeInsets.zero,
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

                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: "Choose Options"),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          children: [
                            Expanded(child: Obx(
                              () {
                                return chooseOptionsAll(color:

                                authController.isCheck.value==false?Colors.transparent:
                                AppColor.primaryColor,color1: authController.isCheck.value==false?Colors.black:
                                AppColor.primaryColor,

                                    color2:
                                    authController.isCheck.value==false?

                                    Colors.transparent:AppColor.whiteColor,onTap: (){
                                  if (authController.isCheck.value == false) {
                                    authController.updateCheck(true);
                                  } else {
                                    authController.updateCheck(false);
                                  }
                                },
                                text: "Have own car"
                                );
                              }
                            ),
                            ),
                            Expanded(child:
                            Obx(
                                    () {
                                  return chooseOptionsAll(color:

                                  authController.isCheck2.value==false?Colors.transparent:
                                  AppColor.primaryColor,color1: authController.isCheck2.value==false?Colors.black:
                                  AppColor.primaryColor,

                                      color2:
                                      authController.isCheck2.value==false?

                                      Colors.transparent:AppColor.whiteColor,onTap: (){
                                        if (authController.isCheck2.value == false) {
                                          authController.updateCheck2(true);
                                        } else {
                                          authController.updateCheck2(false);
                                        }
                                      },
                                      text: "Have own house"
                                  );
                                }
                            ))
                          ],
                        ),


                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        textAuth(text: "Referral Code (optional)"),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        betField(
                          hint: "Enter referral code",

                          controller: authController.referralController,


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
                          ApiManger().registerResponse(context: context);

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
    if (Get.put(AuthController()).mobileController.text.isEmpty) {
      flutterToast(msg: "Please enter phone number");
      return false;
    }
    if (Get.put(AuthController()).mobileController.text.length<9) {
      flutterToast(msg: "Please enter valid phone number");
      return false;
    }
    if (Get.put(AuthController()).occuController.text.isEmpty) {
      flutterToast(msg: "Please enter your occupation");
      return false;
    }
    if (Get.put(AuthController()).provinceId==null) {
      flutterToast(msg: "Please select province");
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
