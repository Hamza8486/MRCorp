import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/account_type.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/auth/forget/view/forget_password.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/helper_function.dart';


class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final authController = Get.put(AuthController());

  var emailController = TextEditingController();

  var pass = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? token;
  void getToken() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    HelperFunctions.saveInPreference("token", token!);
    log("token");
    log(token.toString());
  }

  @override
  void initState() {

    super.initState();
    getToken();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: AppPaddings.mainPadding,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.06,
                    ),

                    Center(child: Image.asset("assets/images/logo1.png",height: Get.height*0.1,)),

                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    AppText(
                      title: "Sign in",
                      size: AppSizes.size_24,
                      fontFamily: AppFont.medium,
                      fontWeight: FontWeight.w500,
                      color: AppColor.boldBlackColor,
                    ),
                    SizedBox(
                      height: Get.height * 0.002,
                    ),
                    AppText(
                      title: "Enter your registered email address to log in. ",
                      size: AppSizes.size_13,
                      fontFamily: AppFont.regular,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    textAuth(text: "Email",color: Colors.transparent),
                    SizedBox(
                      height: Get.height * 0.013,
                    ),
                    betField( validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Please enter a valid email",
                      hint: "Example@gmail.com",
                      controller: emailController,
                    ),

                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    textAuth(text: "Password",color: Colors.transparent),
                    SizedBox(
                      height: Get.height * 0.013,
                    ),

                    Obx(() {
                      return betField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }

                          return null;
                        },
                        hint: "Password",
                        textInputType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscure: authController.isVisible.value,
                        controller: pass,
                        child:    IconButton(
                          onPressed: () {
                        authController.updateVisibleStatus();
                      },
                      icon: Icon(
                      authController.isVisible.value
                      ? Icons.visibility_off
                          : Icons.visibility,
                      size: Get.height * 0.022,
                      color: AppColor.blackColor)),
                      );
                    }),


                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          authController.clear();
                          authController.clearForget();
                          Get.to(ResetView());
                        },
                        child: AppText(
                          title: "Forget Password ?",
                          size: AppSizes.size_13,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.032,
                    ),
                    AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(10),
                        buttonName: "Sign in",

                        fontWeight: FontWeight.w500,
                        textSize: AppSizes.size_15,
                        fontFamily: AppFont.semi,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            authController.updateLoginLoader(true);
                            ApiManger().loginResponse(context: context,
                            email: emailController.text,
                              password: pass.text,
                              token: token.toString()
                            );
                          }
                        //  Get.to(Home());
                        }),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(AccountType());
                          authController.clear();
                          authController.clearForget();
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don’t have an account ?  ",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w500,
                                fontSize: AppSizes.size_15),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Sign up",
                                  style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontFamily: AppFont.semi,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppSizes.size_15)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          return authController.loaderLogin.value == false
              ? SizedBox.shrink()
              : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.7),
            child:    Center(
                child: SpinKitThreeBounce(
                    size: 25, color: AppColor.primaryColor)
            ),
          );



        })
      ],
    );
  }
}
