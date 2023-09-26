import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:qr_flutter/qr_flutter.dart';



class QRCodeGenerator extends StatefulWidget {
  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  String inputData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Get.height*0.06,),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Card(  // Wrap QrImage in a Card widget
                child: QrImageView(
                  data: inputData,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: Get.height * 0.02,
            ),
            textAuth(text: "Amount"),
            SizedBox(
              height: Get.height * 0.01,
            ),
            betField(
                hint: "Enter Amount",
                onChange: (text) {
                  setState(() {
                    inputData = text!;
                  });
                },

                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.next
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: Get.width*0.17),
              child: AppButton(
                  buttonWidth: Get.width,
                  buttonRadius: BorderRadius.circular(10),
                  buttonName: "Active QR Code",
                  fontWeight: FontWeight.w500,
                  textSize: AppSizes.size_15,
                  buttonColor: AppColor.primaryColor,
                  textColor: AppColor.whiteColor,
                  onTap: () {


                  }),
            )


          ],
        ),
      ),
    );
  }
}
