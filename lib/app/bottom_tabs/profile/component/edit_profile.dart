
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/drop_down.dart';
import 'package:mr_bet/widgets/helper_function.dart';
import 'package:mr_bet/widgets/image_pick.dart';





class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  var nameController = TextEditingController();
  var phone = TextEditingController();
  var provinceId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text=Get.put(HomeController()).name.value;
    phone.text=Get.put(HomeController()).phone.value;
   provinceId=Get.put(HomeController()).profileAllData?.province;
  }

  @override
  Widget build(BuildContext context) {
    print(Get.put(HomeController()).profileAllData?.province.toString());
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              TopBar(onTap1: (){},onTap: (){
                Get.back();
              },text: "Edit Profile",
                  image: "assets/icons/share.svg",color: AppColor.whiteColor
              ),

              SizedBox(
                height: Get.height * 0.015,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (builder) => bottomSheet(onCamera: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.camera)
                                      .then((value) {
                                    setState(() {
                                      Get.find<HomeController>().file = value!;
                                    });
                                  });
                                }, onGallery: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.gallery)
                                      .then((value) {
                                    setState(() {
                                      Get.find<HomeController>().file = value!;
                                    });
                                  });
                                }));
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                width: Get.width,
                                height: Get.height * 0.15,
                                child: Center(
                                  child: Material(
                                    elevation: 1,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                    ),
                                    color: AppColor.primaryColor,
                                    child: Container(
                                      height: Get.height * 0.139,
                                      width: Get.height * 0.139,
                                      decoration: const BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(100))),
                                      child: Get.find<HomeController>().file == null
                                          ? Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(100),
                                          child: Obx(
                                                  () {
                                                return Image.network(
                                                  Get.find<HomeController>().image.value ,
                                                  fit: Get.find<HomeController>().image.value.isEmpty?BoxFit.cover: BoxFit.cover,
                                                  errorBuilder: (context, exception,
                                                      stackTrace) {
                                                    return ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      child: Image.asset(
                                                        "assets/images/persons.jpg",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                          ),
                                        ),
                                      )
                                          : Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(100),
                                          child: Image.file(
                                            Get.find<HomeController>().file as File,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: Get.width * 0.53,
                                  top: Get.height * 0.10,
                                  child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppColor.primaryColor,
                                      child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Icon(Icons.camera_alt_sharp,
                                            color: Colors.white,
                                            size: Get.height*0.023,
                                          )
                                      )))
                            ],
                          ),
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
                          controller: nameController,
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
                            controller: phone,
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
                                height: Get.height*0.055,
                                child: dropDownButtons(
                                    color: AppColor.borderColorField,
                                    color1: AppColor.borderColorField,

                                    contentPadding: EdgeInsets.zero,
                                    color2:  AppColor.greyColors,

                                    hinText: "Select Province",
                                    value: provinceId,
                                    onChanged: (value) async {
                                      setState(() {
                                        provinceId=value;
                                      });



                                    },
                                    items: countryDataList(
                                        dataList: Get.put(AuthController())
                                            .provinceList)),
                              );
                            }
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
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
                        buttonName: "Update Profile",


                        fontWeight: FontWeight.w500,
                        textSize: AppSizes.size_14,
                        fontFamily: AppFont.medium,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          if(validateProfile(context)){
                            Get.put(HomeController()).updateLoader(true);
                            ApiManger().editUserResponse1(name: nameController.text,
                            phone: phone.text,
                              province: provinceId.toString()
                            );
                          }
                        }),
                  ),

                  SizedBox(
                    height: Get.height * 0.012,
                  ),

                ],
              )
            ],
          ),
        ),
        Obx(() {
          return Get.put(HomeController()).loader.value == false
              ? SizedBox.shrink()
              : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black26,
            child:  Center(
                child: SpinKitThreeBounce(
                    size: 25, color: AppColor.blackColor)
            ),
          );



        })
      ],
    );
  }



  bool validateProfile(BuildContext context) {

    if (nameController.text.isEmpty) {
      flutterToast(msg: "Please enter name");
      return false;
    }
    if (phone.text.isEmpty) {
      flutterToast(msg: "Please enter phone number");
      return false;
    }






    return true;
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
}
