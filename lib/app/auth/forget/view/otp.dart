import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/home/home_view.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key})
      : super(key: key);


  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {


  final formKey = GlobalKey<FormState>();
  String code = "";
  String currentText = "";
  final authController = Get.put(AuthController());

  var emailController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    startTimer();
  }

  bool isEnabled = false;

  Timer? _timer;
  int _start = 120;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            debugPrint(_start.toString());
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
            if (_start == 0) {
              debugPrint(_start.toString());
              timer.cancel();
              isEnabled = true;
            }
          });
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: AppPaddings.mainHomePadding,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .03,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back,color: Colors.black,size: Get.height*0.035,))
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                AppText(
                  title: 'Verify your\nEmail Address ?',
                  size: AppSizes.size_22,
                  fontWeight: FontWeight.w700,
                  color: AppColor.boldBlackColor,
                  fontFamily: AppFont.semi,
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title: "Check your SMS messages. we've sent you",
                        size: AppSizes.size_14,
                        color: AppColor.boldBlackColor,
                        fontFamily: AppFont.medium,
                      ),
                      Row(
                        children: [
                          AppText(
                            title: "the Pin at ",
                            size: AppSizes.size_14,
                            color: AppColor.boldBlackColor,
                            fontFamily: AppFont.medium,
                          ),
                          AppText(
                            title: "${authController.emailForgetController.text} ",
                            size: AppSizes.size_14,
                            color: Colors.grey,
                            fontFamily: AppFont.medium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .05,
                ),


                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    autoDisposeControllers: false,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 4) {
                        return "Please enter valid Otp";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      fieldHeight: Get.height * 0.06,
                      fieldWidth: Get.height * 0.06,
                      shape: PinCodeFieldShape.box,
                      borderWidth: 1,
                      activeColor: AppColor.blackColor,
                      inactiveColor: AppColor.greyColor,
                      inactiveFillColor: AppColor.whiteColor,
                      activeFillColor: AppColor.whiteColor,
                      selectedFillColor: AppColor.whiteColor,
                      selectedColor: AppColor.blackColor,
                      disabledColor: AppColor.blackColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    cursorColor: AppColor.primaryColor,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: authController.verifyCodeForgetController,

                    errorAnimationController: errorController,

                    keyboardType: TextInputType.number,

                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                        if (value.length == 6) {
                          setState(() {
                            code = value;
                          });
                        }
                      });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      return true;
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),


                Obx(
                  () {
                    return

                      authController.loaderVerify.value?
                       Center(
                          child: SpinKitThreeBounce(
                              size: 25, color: AppColor.primaryColor)
                      )

                          :
                      AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(10),
                        buttonName: "Verify Otp",

                        fontWeight: FontWeight.w500,
                        textSize: AppSizes.size_15,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            authController.updateVerifyLoader(true);

                            ApiManger().verifyResponse(
                                context: context,
                                code: authController.verifyCodeForgetController.text,
                                email: authController.emailForgetController.text);
                          }
                        });
                  }
                ),



                SizedBox(height: Get.height*0.032,),



                isEnabled
                    ? Obx(
                      () {
                        return
                          authController.loaderResend.value?
                           Center(
                              child: SpinKitThreeBounce(
                                  size: 25, color: AppColor.primaryColor)
                          ):

                          InkWell(
                        onTap: () {
                          authController.updateResendLoader(true);
                          ApiManger.resendResponse(
                            context: context,
                            email: authController.emailForgetController.text,
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                _start = 120;
                                startTimer();
                                isEnabled = false;
                              });
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              title: "Didn’t receive code?  ",
                              size: AppSizes.size_13,
                              fontFamily: AppFont.regular,
                              textAlign: TextAlign.justify,
                              color: AppColor.boldBlackColor,
                            ),
                            AppText(
                              title: "Resend OTP",
                              size: AppSizes.size_13,
                              fontFamily: AppFont.semi,
                              textAlign: TextAlign.justify,
                              color: AppColor.primaryColor,
                            ),
                          ],
                        ));
                      }
                    )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      title: "Resend Code in ",
                      size: AppSizes.size_13,
                      fontFamily: AppFont.medium,
                      textAlign: TextAlign.justify,
                      color: AppColor.boldBlackColor,
                    ),
                    AppText(
                      title: "${_start}s",
                      size: AppSizes.size_13,
                      fontFamily: AppFont.semi,
                      textAlign: TextAlign.justify,
                      color: AppColor.primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
