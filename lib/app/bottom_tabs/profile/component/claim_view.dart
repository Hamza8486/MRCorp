import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/verification.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/bottom_sheet.dart';
import 'package:mr_bet/widgets/helper_function.dart';
import 'package:video_player/video_player.dart';


class ClaimView extends StatefulWidget {
  const ClaimView({Key? key}) : super(key: key);

  @override
  State<ClaimView> createState() => _ClaimViewState();
}

class _ClaimViewState extends State<ClaimView> {
  String ? valueDrop;




  VideoPlayerController? _videoController;
  String? selectedVideoPath;

  var nameController = TextEditingController();
  var phoneCon = TextEditingController();
  var address = TextEditingController();
  var emailCon = TextEditingController();
  var idController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoController = VideoPlayerController.asset(""); //
    nameController.text= Get.put(HomeController()).name.value.toString();
    phoneCon.text= Get.put(HomeController()).phone.value.toString();
    emailCon.text= Get.put(HomeController()).email.value.toString();
    setState(() {

    });

  }


  bool isCompressing = false;

  Future<void> pickVideo() async {
    XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    double videoDuration = await getVideoDuration(video.path);

    if (videoDuration > 15) {
      flutterToast(msg: "Please select a video that is 15 seconds or less");

    } else {
      setState(() {
        selectedVideoPath = video.path;
        Get.put(HomeController()).videoFile=video;
        flutterToast(msg: "Video Selected");

      });
    }
  }

  Future<double> getVideoDuration(String videoPath) async {
    VideoPlayerController videoController = VideoPlayerController.file(File(videoPath));
    await videoController.initialize();
    double duration = videoController.value.duration.inSeconds.toDouble();
    await videoController.dispose();
    return duration;
  }


  @override
  void dispose() {
    _videoController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(onTap1: (){},onTap: (){
            Get.back();
          },text: "Claim",
          image: "assets/icons/share.svg",color: AppColor.whiteColor
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height*0.025,),
                    AppText(
                      title: "Fill details to get reward:",
                      size: AppSizes.size_14,
                      fontFamily: AppFont.medium,
                      fontWeight: FontWeight.w500,
                      color: AppColor.boldBlackColor.withOpacity(0.8),
                    ),
                    SizedBox(height: Get.height*0.025,),
                    Row(
                      children: [
                        Expanded(
                          child: betField(
                              isSuffix: false,
                            hint: "Full Name",
                            controller: nameController


                          ),
                        ),
                        SizedBox(width: Get.width*0.04,),
                        Expanded(
                          child: betField(
                            controller: phoneCon,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            isSuffix: false,
                            hint: "Phone No.",

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height*0.025,),
                    Row(
                      children: [
                        Expanded(
                          child: betField(

                            isSuffix: false,
                            controller: idController,
                            hint: "BC ID",
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next

                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: Get.height*0.025,),
                    betField(
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      isSuffix: false,
                      hint: "Address",
                      controller: address

                    ),
                    SizedBox(height: Get.height*0.03,),
                    betField(
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      isRead: true,
                      isCur: false,

                      controller: emailCon,

                      isSuffix: false,
                      hint: "E-mail Address",

                    ),
                    SizedBox(height: Get.height*0.025,),
                    AppText(
                      title: "Upload your picture and reaction video:",
                      size: AppSizes.size_14,
                      fontFamily: AppFont.medium,
                      fontWeight: FontWeight.w400,
                      color: AppColor.boldBlackColor.withOpacity(0.8),
                    ),
                    SizedBox(height: Get.height*0.025,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: DottedBorder(
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
                                            Get.put(HomeController()).claimProfile = value!;
                                          });
                                        });
                                      }, onGallery: () {
                                        Navigator.pop(context);
                                        HelperFunctions.pickImage(ImageSource.gallery)
                                            .then((value) {
                                          setState(() {
                                            Get.put(HomeController()).claimProfile = value!;
                                          });
                                        });
                                      }));
                                },
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.01, vertical: 20),
                                    child: Column(
                                      children: [
                                        Get.put(HomeController()).claimProfile==null?
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.greys,
                                            shape: BoxShape.circle
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: SvgPicture.asset("assets/icons/pic.svg"),
                                          ) ,
                                        ):
                                        Container(
                                          height: Get.height*0.07,

                                          decoration: BoxDecoration(

                                              shape: BoxShape.circle
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: Image.file(Get.put(HomeController()).claimProfile as File,
                                              fit: BoxFit.cover,
                                              ),
                                            ),
                                          ) ,
                                        )
                                        ,
                                         SizedBox(
                                          height: 10,
                                        ),
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
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width*0.06,),
                          Expanded(
                            child: DottedBorder(
                              strokeCap: StrokeCap.square,
                              color:Colors.grey.withOpacity(0.7),
                              dashPattern: [10, 7],
                              strokeWidth: 1.6,
                              child: MaterialButton(
                                minWidth: Get.width,
                                onPressed: ()=>pickVideo(),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.007, vertical: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.greys,
                                              shape: BoxShape.circle
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: SvgPicture.asset("assets/icons/video.svg"),
                                          ) ,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.redLight,
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child:Padding(
                                              padding:  EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                              child:   AppText(
                                                title: "Upload Video 15 sec",
                                                size: Get.height*0.01,
                                                color: AppColor.boldBlackColor,
                                                fontFamily: AppFont.semi,


                                              )
                                          ) ,
                                        ),

                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height*0.035,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.17),
                      child: Obx(
                        () {
                          return
                            Get.put(HomeController()).isClaim.value?
                             Center(
                                child: SpinKitThreeBounce(
                                    size: 20, color: AppColor.primaryColor)
                            ):

                            AppButton(buttonName: "Submit", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor, onTap: (){
                            if(validateClaim(context)){
                              Get.put(HomeController()).updateIsClaim(true);
                              ApiManger().claimReward(
                                name: nameController.text,
                                phone: phoneCon.text,
                                email: emailCon.text,
                                addrss: address.text,
                                file: Get.put(HomeController()).videoFile,
                                id: idController.text

                              );
                            }

                          },
                          buttonRadius: BorderRadius.circular(30),
                            buttonWidth: Get.width,
                            buttonHeight: Get.height*0.055,
                          );
                        }
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  bool validateClaim(BuildContext context) {


    if (nameController.text.isEmpty) {
      flutterToast(msg: "Please enter full name");
      return false;
    }
    if (phoneCon.text.isEmpty) {
      flutterToast(msg: "Please enter valid phone number");
      return false;
    }
    if (idController.text.isEmpty) {
      flutterToast(msg: "Please enter identity id");
      return false;
    }

    if (address.text.isEmpty) {
      flutterToast(msg: "Please enter valid address");
      return false;
    }
    if (emailCon.text.isEmpty) {
      flutterToast(msg: "Please enter email address");
      return false;
    }
    if (Get.put(HomeController()).claimProfile==null) {
      flutterToast(msg: "Please upload your picture");
      return false;
    }
    if (Get.put(HomeController()).videoFile==null) {
      flutterToast(msg: "Please make 15 seconds video");
      return false;
    }






    return true;
  }
}
