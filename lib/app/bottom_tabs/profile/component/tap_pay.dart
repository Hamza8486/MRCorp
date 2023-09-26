import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mr_bet/app/auth/component.dart';

import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class TapPay extends StatefulWidget {
  const TapPay({Key? key}) : super(key: key);

  @override
  State<TapPay> createState() => _TapPayState();
}

class _TapPayState extends State<TapPay> {

  var amount= TextEditingController();
  var barCode= TextEditingController();

  Barcode? result;
  QRViewController? controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
    });
  }
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void readQr() async {
    if (result != null) {
      controller!.pauseCamera();
      setState(() {

      });
      print(result!.code);
      controller!.dispose();
    }
  }
  @override
  void initState() {

    setState(() {
      controller?.resumeCamera();
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Column(

        children: [
          TopBar(onTap1: (){},onTap: (){
            Get.back();
          },text: "Tap to Pay",
              image: "assets/icons/share.svg",color: AppColor.whiteColor
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height*0.015,),


                    SizedBox(
                      width: Get.width,
                      height: Get.height*0.45,
                      child: GestureDetector(
                        onTap: (){
                          controller?.resumeCamera();
                          setState(() {

                          });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                            overlay: QrScannerOverlayShape(
                              borderColor: Colors.orange,
                              borderRadius: 10,
                              borderLength: 30,
                              borderWidth: 10,
                              cutOutSize: 250,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.03,),
                    Center(
                      child: AppText(
                        title: "Or",
                        size: AppSizes.size_16,
                        fontFamily: AppFont.medium,
                        fontWeight: FontWeight.w600,
                        color: AppColor.boldBlackColor.withOpacity(0.6),
                      ),
                    ),

                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    textAuth(text: "Bar Code"),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    betField(

                      hint: "Bar Code",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                      controller: barCode,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    textAuth(text: "Amount"),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    betField(

                      hint: "Enter Amount",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.phone,
                      controller: amount,
                    ),
                    SizedBox(height: Get.height*0.015,),

                  ],
                ),
              ),
            ),
          ),
          isKeyBoard?SizedBox.shrink():
          Column(
            children: [
              SizedBox(
                height: Get.height * 0.005,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                child: AppButton(
                    buttonWidth: Get.width,
                    buttonRadius: BorderRadius.circular(10),
                    buttonName: "Pay Now",


                    fontWeight: FontWeight.w500,
                    textSize: AppSizes.size_14,
                    fontFamily: AppFont.medium,
                    buttonColor: AppColor.primaryColor,
                    textColor: AppColor.whiteColor,
                    onTap: () {

                    }),
              ),

              SizedBox(
                height: Get.height * 0.012,
              ),

            ],
          )
        ],
      ),
    );
  }
}
