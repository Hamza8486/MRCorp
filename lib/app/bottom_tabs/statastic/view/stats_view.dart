import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';

import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/drop_down.dart';
import 'package:mr_bet/widgets/helper_function.dart';
import 'package:scratcher/scratcher.dart';

class StatsView extends StatefulWidget {
  StatsView({Key? key}) : super(key: key);

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  final homeController = Get.put(HomeController());
  final auth = Get.put(AuthController());

  String Slots="";  String? provinceName;
  double _opacity = 0.0;
  final List <String>_names=["day",
  "week",
    "month"
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _selectedItem;
  String?filter;
  var provinceId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provinceId=null;
    filter=null;
    _selectedItem=null;
    homeController.updateTypeSelect("");
    homeController.getSlotData1(id: "",filter: "",type: "");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          TopBar(
              onTap1: () {},


              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              text: "Statistics",
              isValue: false,
              Child: Container(height: Get.height*0.05,),
              image: "assets/icons/share.svg",
              color: AppColor.whiteColor),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Padding(

            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                // border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.03, right: Get.width * 0.03),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                              width: Get.width,
                              child: Obx(() {
                                return dropDownAppAddAll(
                                  hint: "Province",
                                  child1:  SvgPicture.asset("assets/icons/layer.svg",height: Get.height*0.018,
                                    color: AppColor.boldBlackColor,

                                  ),
                                  width:  Get.put(AuthController())
                                      .provinceList.isEmpty?Get.width * 0.3:Get.width * 0.3,
                                  height: Get.height * 0.3,
                                  items:Get.put(AuthController()).provinceAllList,
                                  color: AppColor.primaryColor,
                                  value: provinceId,
                                  onChange: (value) {
                                    setState(() {

                                      provinceName = value;

                                      for (int i = 0;
                                      i <
                                          Get.put(AuthController())
                                              .provinceList.length;
                                      i++) {
                                        if (value == Get.put(AuthController())
                                            .provinceList[i].name){
                                          homeController.getSlotData1(id:  Get.put(AuthController())
                                              .provinceList[i].id,
                                              type: homeController.typeSelect.value.toString(),
                                              filter:filter==null?"": filter.toString()
                                          );
                                          homeController.updateProvincesName(
                                              Get.put(AuthController()).provinceList[i].name);

                                        }
                                      }
                                    });
                                  },
                                );
                              })),
                        ),

                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        Expanded(
                          child: SizedBox(
                              width: Get.width,
                              child: Obx(() {
                                return dropDownAppAdd(
                                  hint: "Select type",
                                  width: Get.width * 0.3,
                                  height: Get.height * 0.3,
                                  items: [
                                    // "Car",
                                    // "House",
                                    "Grocery",
                                  ],
                                  color: AppColor.primaryColor,
                                  value: homeController
                                      .typeSelect.value.isEmpty
                                      ? null
                                      : homeController.typeSelect.value,
                                  onChange: (value) {
                                    homeController.updateTypeSelect(
                                        value.toString());
                                    homeController.getSlotData1(id: provinceId.toString(),
                                        type:
                                        homeController.typeSelect.value=="Grocery"?"grocery":
                                        homeController.typeSelect.value=="House"?"house":"car",

                                        filter:filter==null?"": filter.toString()
                                    );
                                  },
                                );
                              })),
                        ),
                        Center(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            materialTapTargetSize:
                            MaterialTapTargetSize.padded,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: DropdownButton<String>(
                              value: filter,
                              icon: SvgPicture.asset(
                                "assets/icons/fil.svg",
                                height: Get.height * 0.023,
                                color: AppColor.primaryColor,
                              ), // Specify the icon here
                              iconSize: Get.height * 0.05,
                              elevation: 16,
                              style: TextStyle(fontFamily: AppFont.regular,
                                  fontWeight: FontWeight.w500, fontSize:  AppSizes.size_14,
                                  color: Colors.black
                              ),
                              underline: Container(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  homeController.getSlotData1(id: provinceId.toString(),
                                      type: homeController.typeSelect.value.toString(),
                                      filter:newValue.toString()
                                  );

                                });
                              },
                              items: _names
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                          value), // Display the name as the child of each item
                                    );
                                  }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                    provinceId==null?SizedBox.shrink():
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.greyColor.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 0.01),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                            child: Row(
                              children: [
                                AppText(
                                  title: _selectedItem==null?"":_selectedItem.toString(),
                                  size: AppSizes.size_16,
                                  fontFamily: AppFont.semi,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                SizedBox(width: Get.width*0.023,),
                                Image.asset(
                                  "assets/icons/line.png",
                                  height: Get.height * 0.03,
                                ),
                                SizedBox(width: Get.width*0.023,),
                                Container(
                                  height: Get.height*0.02,
                                  width: Get.width*0.55,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColor.greys,),
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: LinearProgressIndicator(

                                      value: homeController.getSlot1.length/100, // The value should be between 0.0 and 1.0
                                      backgroundColor: AppColor.greys,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColor.primaryColor),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 13,),
                                Column(
                                  children: [
                                    AppText(
                                      title: "Slots",
                                      size: AppSizes.size_15,
                                      fontFamily: AppFont.regular,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    SizedBox(height: 7,),
                                    Obx(
                                            () {
                                          return AppText(
                                            title: homeController.getSlot1.length.toString(),
                                            size: AppSizes.size_15,
                                            fontFamily: AppFont.regular,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          );
                                        }
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          title: "Total Price: ",
                          size: AppSizes.size_14,
                          fontFamily: AppFont.regular,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        SizedBox(width: 7,),
                        Obx(
                                () {
                              return AppText(
                                title:
                                homeController.totalPrice.value.isEmpty?"0":
                                "\$${homeController.totalPrice.value}",
                                size:
                                homeController.totalPrice.value.isNotEmpty? AppSizes.size_17:
                                AppSizes.size_17,
                                fontFamily: AppFont.semi,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              );
                            }
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.012,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.012,
                    ),
                    Obx(
                      () {
                        return
                          homeController.isLoading1.value?
                          Column(
                            children: [
                              SizedBox(height: Get.height*0.28,),
                              Center(
                                  child: SpinKitThreeBounce(
                                      size: 25, color: AppColor.primaryColor)
                              ),
                            ],
                          ):
                          homeController.getSlot1.isNotEmpty?
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                childAspectRatio: Get.width / Get.width * 1.2,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 16),
                            itemCount: homeController.getSlot1.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  print(homeController.getSlot1[index].id
                                      .toString());
                                  Get.generalDialog(
                                      pageBuilder: (context, __, ___) =>
                                          AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(40), // Customize the border radius
                                            ),


                                            content: SizedBox(
                                              height: Get.height*0.35,
                                              width: Get.width*0.55,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Center(
                                                    child: AppText(
                                                      title:"Scratch Coupon!",
                                                      size: AppSizes
                                                          .size_15,
                                                      fontFamily:
                                                      AppFont.semi,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(height: Get.height*0.03,),
                                                  SizedBox(
                                                    height: Get.height * 0.2,
                                                    child: Center(
                                                      child: Scratcher(
                                                        brushSize: 50, // Adjust the brush size as needed
                                                        threshold: 40, // Adjust the threshold as needed
                                                        color: AppColor.primaryColor, // Initial scratch card color
                                                        image: Image.asset('assets/images/scratch.png'), // Custom brush image
                                                        onChange: (value) {
                                                          if (value >= 1.0) {
                                                            setState(() {

                                                            });
                                                          }
                                                          print("Scratch progress: ${value * 100}%");
                                                        },
                                                        child: Container(
                                                            width: 300,
                                                            height: 200,
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                              color: AppColor.primaryColor, // Content revealed
                                                              borderRadius: BorderRadius.circular(10),
                                                              // boxShadow: isScratched
                                                              //     ? [] // No shadow when content is revealed
                                                              //     : [BoxShadow(blurRadius: 10, color: Colors.grey)], // Add a blurred effect
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [

                                                                AppText(
                                                                  title:homeController.getSlot1[index].coupon.toString(),
                                                                  size: AppSizes
                                                                      .size_16,
                                                                  fontFamily:
                                                                  AppFont.bold,
                                                                  fontWeight:
                                                                  FontWeight.w800,
                                                                  color: Colors.white,
                                                                ),
                                                                SizedBox(height: Get.height*0.015,),
                                                                Image.asset("assets/images/sca.png",
                                                                  height: Get.height*0.1,
                                                                )
                                                              ],
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: Get.height*0.03,),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                                                    child: AppButton(
                                                      buttonName: "Cancel",
                                                      buttonColor: AppColor.primaryColor,
                                                      textColor: AppColor.whiteColor,
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      buttonHeight: Get.height * 0.055,
                                                      buttonWidth: Get.width,
                                                      fontFamily: AppFont.medium,
                                                      textSize: AppSizes.size_16,
                                                      buttonRadius: BorderRadius.circular(30),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ));
                                },
                                child:




                                homeController
                                    .getSlot1[index].type ==
                                    "grocery"
                                    ? Container(
                                  decoration:  BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primaryColor.withOpacity(0.25),),
                                  child: Padding(
                                      padding:
                                      const EdgeInsets.all(
                                          18.0),
                                      child: Icon(
                                        Icons.shopping_cart,
                                        color:
                                        homeController
                                            .getSlot1[index].isScratch=="true"?
                                        AppColor.primaryColor:
                                        AppColor.grey3Color,
                                        size: AppSizes.size_25,
                                      )),
                                )
                                    : Container(
                                  decoration:  BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.primaryColor.withOpacity(0.25)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        18.0),
                                    child: Obx(() {
                                      return homeController
                                          .getSlot1[index]
                                          .type ==
                                          "house"
                                          ? SvgPicture.asset(
                                        "assets/icons/home.svg",
                                        color:  homeController
                                            .getSlot1[index].isScratch=="true"?
                                        AppColor.primaryColor:
                                        AppColor.grey3Color,
                                      )
                                          : SvgPicture.asset(
                                        "assets/icons/car.svg",
                                        color: homeController
                                            .getSlot1[index].isScratch=="true"?
                                        AppColor.primaryColor:
                                        AppColor.grey3Color,
                                      );
                                    }),
                                  ),
                                ),
                              );
                            }):
                        noData()
                        ;
                      }
                    ),
                    SizedBox(
                      height: Get.height * 0.065,
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
  List<DropdownMenuItem<int>> countryDataList({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: Row(
            children: [
              SvgPicture.asset("assets/icons/layer.svg",height: Get.height*0.026,
                color: AppColor.boldBlackColor,

              ),
              SizedBox(width: Get.width*0.04,),
              AppText(
                title: dataList[i].name,
                size: AppSizes.size_15,
                color: AppColor.blackColor,
                fontFamily: AppFont.medium,
                fontWeight: FontWeight.w500,
              ),
            ],
          )));
    }
    return outputList;
  }
  Future<void> scratchDialog({required BuildContext context, text, id,String?value}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: CircleBorder(),
            title: SizedBox.shrink(),
            content: Container(
              height: Get.height * 0.83,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.28,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  StatefulBuilder(builder: (context, StateSetter setState) {
                    return Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child:
                        value==null?

                        Scratcher(
                          accuracy: ScratchAccuracy.low,
                          color: Colors.blueGrey,
                          onChange: (value) {
                            setState(() {
                              if (value == 60.0) {
                                ApiManger().claimScratch(
                                    context: context, id: id.toString());
                              } else {
                                print(value.toString());
                              }
                            });
                          },
                          onScratchStart: () {
                            print("Scratching has started");
                          },
                          onScratchUpdate: () {
                            print("Scratching in progress");
                          },
                          onScratchEnd: () {
                            print("Scratching has finished");
                          },
                          image: Image.asset(
                            'assets/images/scan1.png',
                          ),
                          brushSize: 15,
                          threshold: 60,
                          onThreshold: () {
                            setState(() {
                              _opacity = 1;
                            });
                          },
                          child: AnimatedOpacity(
                            duration: Duration(microseconds: 100),
                            opacity: _opacity,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              height: MediaQuery.of(context).size.height * 0.22,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  AppText(
                                    title: "Congratulations!",
                                    size: AppSizes.size_16,
                                    fontFamily: AppFont.semi,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primaryColor,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  AppText(
                                    title: text.toString(),
                                    size: AppSizes.size_19,
                                    fontFamily: AppFont.semi,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.blackColor,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  Image.asset(
                                    "assets/images/sca.png",
                                    height: Get.height * 0.16,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ):Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                              AppText(
                                title: "Congratulations!",
                                size: AppSizes.size_16,
                                fontFamily: AppFont.semi,
                                fontWeight: FontWeight.w600,
                                color: AppColor.primaryColor,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              AppText(
                                title: text.toString(),
                                size: AppSizes.size_19,
                                fontFamily: AppFont.semi,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Image.asset(
                                "assets/images/sca.png",
                                height: Get.height * 0.09,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.13,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                    child: AppButton(
                      buttonName: "Cancel",
                      buttonColor: AppColor.primaryColor,
                      textColor: AppColor.whiteColor,
                      onTap: () {
                        Get.back();
                      },
                      buttonHeight: Get.height * 0.055,
                      buttonWidth: Get.width,
                      fontFamily: AppFont.medium,
                      textSize: AppSizes.size_16,
                      buttonRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
