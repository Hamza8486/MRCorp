import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/view/wallet_view.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/component/drawer.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/slot_model.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:scratcher/scratcher.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  double _opacity = 0.0;
  final homeController = Get.put(HomeController());
  //final auth = Get.put(AuthController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current = 0;

  final CarouselController _controller = CarouselController();
  String? _selectedItem;
  var provinceId;
  String? isSelect;
  String? slots;
  int totalSlots = 0;

  List<String> types = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "16",
    "17",
    "18",
    "19",
    "20",
  ];
  bool isScratched = false;
  double opacity = 0.5;
  Timer? _timer;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  //List<String> provinceList = [];
  @override
  void initState() {
    super.initState();
    homeController.getAllTest(id: "");
    startTimer();

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Duration _getTimeUntil12am() {
    final now = DateTime.now();
    final tomorrowMidnight = DateTime(now.year, now.month, now.day + 1, 0, 0, 0);
    return tomorrowMidnight.isBefore(now) ? Duration(seconds: 0) : tomorrowMidnight.difference(now);
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      final remainingDuration = _getTimeUntil12am();
      if (remainingDuration.inSeconds <= 0) {
        timer.cancel();
        setState(() {
          _hours = 0;
          _minutes = 0;
          _seconds = 0;
        });
      } else {
        setState(() {
          _hours = remainingDuration.inHours;
          _minutes = remainingDuration.inMinutes.remainder(60);
          _seconds = remainingDuration.inSeconds.remainder(60);
        });
      }
    });
  }
  double _calculateProgress() {
    final totalTimeInSeconds = 12 * 3600; // 12 hours in seconds
    final remainingTimeInSeconds = _hours * 3600 + _minutes * 60 + _seconds;
    return (totalTimeInSeconds - remainingTimeInSeconds) / totalTimeInSeconds;
  }
  List<String> staticBannerList = [
    'https://www.shutterstock.com/image-photo/live-inplay-betting-app-on-600w-2177823557.jpg',
    'https://www.shutterstock.com/image-photo/live-inplay-betting-app-on-600w-2162707191.jpg',
    'https://www.shutterstock.com/image-photo/live-inplay-betting-app-on-600w-2177823557.jpg',
    // Add more banner URLs as needed
  ];

  String? provinceName;

  @override
  Widget build(BuildContext context) {
    final isTimerComplete = _hours == 0 && _minutes == 0 && _seconds == 0;
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              dashboardTopBar(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                    print("object");
                  },
                  onTap1: () {

                  },
                  text: "0${homeController.profileId.value}"),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.035),
                      child: Stack(
                        children: [
                          CarouselSlider(
                            carouselController: _controller,
                            options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              pageSnapping: false,
                              height: Get.height * 0.18,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              pauseAutoPlayInFiniteScroll: false,
                              reverse: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 2),
                              autoPlayAnimationDuration: const Duration(milliseconds: 400),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                            ),
                            items: staticBannerList
                                .map((item) => GestureDetector(
                              onTap:
                                  (){

                              },
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => const Center(
                                      child: SpinKitThreeBounce(
                                          size: 25,
                                          color: AppColor.primaryColor
                                      ),
                                    ),
                                    imageUrl: item.toString(),

                                    width: Get.width,
                                    fit: BoxFit.cover,

                                    errorWidget: (context, url, error) => ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "https://www.shutterstock.com/image-photo/live-inplay-betting-app-on-600w-2177823557.jpg",
                                        fit: BoxFit.cover,
                                        width: Get.width,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                                .toList(),
                          ),
                          Positioned(
                              right: Get.width*0.37,
                              top:Get.height*0.14,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: staticBannerList.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () => _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: 9.0,
                                      height: 9.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                              ? Colors.white
                                              : AppColor.primaryColor)
                                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                    ),
                                  );
                                }).toList(),
                              ))

                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              return GestureDetector(
                                onTap: () {

                                  homeController.updateSelectOption("3");
                                  homeController.updateSelectName("grocery");
                                  setState(() {
                                    _selectedItem = null;
                                    homeController.slotAddList.clear();
                                  });
                                  homeController.getSlotData();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          homeController.selectOption.value ==
                                                  "3"
                                              ? AppColor.primaryColor
                                              : Colors.transparent,
                                      border: Border.all(color: AppColor.primaryColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 9),
                                    child: Center(
                                      child: AppText(
                                        title: "Grocery",
                                        size: AppSizes.size_14,
                                        fontFamily: AppFont.medium,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            homeController.selectOption.value ==
                                                    "3"
                                                ? AppColor.whiteColor
                                                : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          // SizedBox(width: Get.width*0.03,),
                          // Expanded(
                          //   child: Obx(() {
                          //     return GestureDetector(
                          //       onTap: () {
                          //         homeController.updateSelectOption("1");
                          //         homeController.updateSelectName("car");
                          //
                          //         setState(() {
                          //           _selectedItem = null;
                          //           homeController.slotAddList.clear();
                          //         });
                          //         homeController.getSlotData();
                          //       },
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //             color:
                          //                 homeController.selectOption.value ==
                          //                         "1"
                          //                     ? AppColor.primaryColor
                          //                     : Colors.transparent,
                          //             border: Border.all(color: AppColor.primaryColor),
                          //             borderRadius: BorderRadius.circular(10)),
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 5, vertical: 9),
                          //           child: Center(
                          //             child: AppText(
                          //               title: "Get a Car",
                          //               size: AppSizes.size_14,
                          //               fontFamily: AppFont.medium,
                          //               fontWeight: FontWeight.w600,
                          //               color:
                          //                   homeController.selectOption.value ==
                          //                           "1"
                          //                       ? AppColor.whiteColor
                          //                       : Colors.black,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   }),
                          // ),
                          // SizedBox(width: Get.width*0.03,),
                          // Expanded(
                          //   child: Obx(() {
                          //     return GestureDetector(
                          //       onTap: () {
                          //         homeController.updateSelectOption("2");
                          //         homeController.updateSelectName("house");
                          //         homeController.getSlotData();
                          //         setState(() {
                          //           _selectedItem = null;
                          //           homeController.slotAddList.clear();
                          //         });
                          //       },
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //             color:
                          //                 homeController.selectOption.value ==
                          //                         "2"
                          //                     ? AppColor.primaryColor
                          //                     : Colors.transparent,
                          //             border: Border.all(color: AppColor.primaryColor),
                          //             borderRadius: BorderRadius.circular(10)),
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 5, vertical: 9),
                          //           child: Center(
                          //             child: AppText(
                          //               title: "Get a House",
                          //               size: AppSizes.size_14,
                          //               fontFamily: AppFont.medium,
                          //               fontWeight: FontWeight.w600,
                          //               color:
                          //                   homeController.selectOption.value ==
                          //                           "2"
                          //                       ? AppColor.whiteColor
                          //                       : Colors.black,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   }),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.13,
                        right: Get.width * 0.1,
                      ),
                      child: Row(
                        children: [
                          // Expanded(
                          //     child: SizedBox(
                          //   height: Get.height * 0.055,
                          //   child: Obx(() {
                          //     return dropDownButtons(
                          //         color: AppColor.primaryColor,
                          //         color1: auth.provinceList.isEmpty
                          //             ? AppColor.borderColorField
                          //             : AppColor.borderColorField,
                          //         height: Get.height * 0.4,
                          //         contentPadding:
                          //             const EdgeInsets.only(right: 6),
                          //         color2: AppColor.greyColors,
                          //         hinText: "Select Province",
                          //         value: homeController.provinceId,
                          //         onChanged: (value) async {
                          //           setState(() {
                          //             homeController.updateSlotName("");
                          //             homeController.updateIsSelectProvince(
                          //                 value.toString());
                          //             homeController.provinceId = value;
                          //
                          //             for (int i = 0;
                          //                 i < auth.provinceList.length;
                          //                 i++) {
                          //               setState(() {
                          //                 if (auth.provinceList[i].id ==
                          //                     value) {
                          //                   homeController.updateProvincesName(
                          //                       auth.provinceList[i].name);
                          //                 }
                          //               });
                          //             }
                          //           });
                          //         },
                          //         items: countryDataList(
                          //             dataList: auth.provinceList));
                          //   }),
                          // )),
                          Expanded(
                            child: SizedBox(
                                width: Get.width,
                                child: Obx(() {
                                  return dropDownAppAddAll(
                                    hint: "Select Province",
                                    child1:  SvgPicture.asset("assets/icons/layer.svg",height: Get.height*0.018,
                                      color: AppColor.boldBlackColor,

                                    ),
                                    width:  Get.put(AuthController())
                                        .provinceList.isEmpty?Get.width * 0.36:Get.width * 0.36,
                                    height: Get.height * 0.3,
                                    items:Get.put(AuthController()).provinceAllList,
                                    color: AppColor.primaryColor,
                                    value: provinceName,
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
                                            homeController.provinceId =
                                                Get.put(AuthController())
                                                    .provinceList[i].id;
                                            homeController.updateProvincesName(
                                                Get.put(AuthController()).provinceList[i].name);
                                            homeController.updateSlotName("");
                                                       homeController.updateIsSelectProvince(
                                                          value.toString());

                                          }
                                        }
                                      });
                                    },
                                  );
                                })),
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Expanded(
                            child: SizedBox(
                                width: Get.width,
                                child: Obx(() {
                                  return dropDownAppAddAll(
                                    hint: "Select Slot",
                                    child1:  SvgPicture.asset("assets/images/slot.svg",height: Get.height*0.018,
                                      color: AppColor.boldBlackColor,

                                    ),
                                    width: Get.width * 0.36,
                                    height: Get.height * 0.3,
                                    items:types,
                                    color: AppColor.primaryColor,
                                    value: homeController.slot.value.isEmpty
                                        ? null
                                        : homeController.slot.value,
                                    onChange: (value) {
                                      setState(() {

                                        if (homeController
                                                .isSelectProvince.value !=
                                            "") {
                                          homeController
                                              .updateSlotName(value.toString());
                                          homeController.slotAddList.add(
                                            AddSlotModel(
                                                name: homeController
                                                    .selectProvince.value
                                                    .toString(),
                                                id: homeController.provinceId
                                                    .toString(),
                                                slot: value.toString(),
                                                betId: homeController
                                                    .groceryId.value
                                                    .toString(),
                                                total: ""),
                                          );
                                          homeController.updateSlotName("");
                                          totalSlots = 0;

                                          for (var slots
                                              in homeController.slotAddList) {
                                            totalSlots +=
                                                int.parse(slots.slot ?? "");
                                          }
                                          homeController.provinceId = null;
                                          provinceName=null;
                                          homeController.updateSlotName("");
                                          homeController.updateIsSelectProvince("");
                                          homeController
                                              .updateProvincesName("");
                                        } else {
                                          homeController.provinceId = null;
                                          homeController
                                              .updateIsSelectProvince("");
                                          homeController.updateSlotName("");
                                          homeController
                                              .updateProvincesName("");
                                          flutterToast(
                                              msg: "Please select Province");
                                        }
                                      });
                                    },
                                  );
                                })),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColor.primaryColor1,
                            AppColor.primaryColor,


                          ],
                        ),),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  title: "Coupon Details:",
                                  size: AppSizes.size_12,
                                  fontFamily: AppFont.medium,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                AppText(
                                  title: "Price per Slot = \$10",
                                  size: AppSizes.size_12,
                                  fontFamily: AppFont.medium,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.013,
                            ),
                            Obx(() {
                              return homeController.slotAddList.isNotEmpty
                                  ? SizedBox(
                                      height: Get.height * 0.1,
                                      child: ListView.builder(
                                          itemCount:
                                              homeController.slotAddList.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                homeController.slotAddList
                                                    .removeAt(index);
                                                totalSlots = 0;

                                                for (var slots in homeController
                                                    .slotAddList) {
                                                  totalSlots += int.parse(
                                                      slots.slot ?? "");
                                                }
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: index == 0 ? 0 : 7,
                                                    right: homeController
                                                            .slotAddList.isEmpty
                                                        ? 7
                                                        : 7),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        AppColor.whiteColor),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20,
                                                          top: 3,
                                                          right: 3),
                                                      child: Icon(
                                                        Icons.cancel_outlined,
                                                        color:
                                                            AppColor.blackColor,
                                                        size: Get.height * 0.02,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  Get.width *
                                                                      0.025),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.008,
                                                          ),
                                                          AppText(
                                                            title: homeController
                                                                .slotAddList[
                                                                    index]
                                                                .name
                                                                .toString(),
                                                            size: AppSizes
                                                                .size_11,
                                                            fontFamily:
                                                                AppFont.medium,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(
                                                            height: 7,
                                                          ),
                                                          AppText(
                                                            title: homeController
                                                                .slotAddList[
                                                                    index]
                                                                .slot
                                                                .toString(),
                                                            size: AppSizes
                                                                .size_11,
                                                            fontFamily:
                                                                AppFont.medium,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  : AppText(
                                      title: "Add Province & Slot",
                                      size: AppSizes.size_17,
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.whiteColor,
                                    );
                            }),
                            SizedBox(
                              height: Get.height * 0.013,
                            ),
                            Divider(
                              color: AppColor.primaryColor.withOpacity(0.5),
                              thickness: 2,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      title: "Balance: ",
                                      size: AppSizes.size_12,
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.009,
                                    ),
                                    Obx(
                                      () {
                                        return
                                          homeController.walletLoadingValue.value?
                                           Center(
                                              child: SpinKitThreeBounce(
                                                  size: 13, color: AppColor.primaryColor)):
                                        homeController.totalAmountWallet.value=="0"?

                                          AppText(
                                          title: "\$0",
                                          size: AppSizes.size_16,
                                          fontFamily: AppFont.semi,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ):AppText(
                                          title: "\$${homeController.totalAmountWallet.value.toString()}",
                                          size: AppSizes.size_16,
                                          fontFamily: AppFont.semi,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        );
                                      }
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _hours == 0 && _minutes == 0 && _seconds == 0?

                                    Center(
                                      child: AppText(
                                        title: "Time Close",
                                        size: AppSizes.size_12,
                                        fontFamily: AppFont.semi,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ):
                                    Center(
                                      child: AppText(
                                        title: "Remaining Time",
                                        size: AppSizes.size_12,
                                        fontFamily: AppFont.medium,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.009,
                                    ),
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child
                                              : CircularPercentIndicator(
                                            radius: Get.height * 0.025,
                                            lineWidth: 2,
                                            percent: (_hours / 24).clamp(0.0, 1.0), // Assuming 12 hours in total
                                            center: Center(
                                              child: AppText(
                                                title: _hours.toString().padLeft(2, '0'),
                                                size: AppSizes.size_12,
                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            backgroundColor: AppColor.primaryColor.withOpacity(0.4),
                                            progressColor: AppColor.primaryColor,
                                            fillColor: Colors.white,

                                          ),
                                        ),

                                        SizedBox(width: 5),

                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child
                                              : CircularPercentIndicator(
                                            radius: Get.height * 0.025,
                                            lineWidth: 2,
                                            percent: (_minutes / 60).clamp(0.0, 1.0), // Assuming 12 hours in total
                                            center: Center(
                                              child: AppText(
                                                title:_minutes.toString().padLeft(2, '0'),
                                                size: AppSizes.size_12,
                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            backgroundColor: AppColor.primaryColor.withOpacity(0.4),
                                            progressColor: AppColor.primaryColor,
                                            fillColor: Colors.white,

                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child
                                              : CircularPercentIndicator(
                                            radius: Get.height * 0.025,
                                            lineWidth: 2,
                                            percent: (_seconds / 60).clamp(0.0, 1.0),// Assuming 12 hours in total
                                            center: Center(
                                              child: AppText(
                                                title: _seconds.toString().padLeft(2, '0'),
                                                size: AppSizes.size_12,
                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            backgroundColor: AppColor.primaryColor.withOpacity(0.4),
                                            progressColor: AppColor.primaryColor,
                                            fillColor: Colors.white,

                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    AppText(
                      title: "Total Price",
                      size: AppSizes.size_13,
                      fontFamily: AppFont.medium,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Obx(() {
                      return AppText(
                        title: homeController.slotAddList.isEmpty
                            ? "\$0"
                            : "${totalSlots.toString()}*10 = \$${totalSlots * 10}",
                        size: AppSizes.size_15,
                        fontFamily: AppFont.medium,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      );
                    }),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.2),
                      child: Obx(() {
                        return homeController.slotAdd.value
                            ?  Center(
                                child: SpinKitThreeBounce(
                                    size: 25, color: AppColor.primaryColor))
                            : AppButton(
                                buttonWidth: Get.width,
                                buttonHeight: Get.height * 0.051,
                                buttonRadius: BorderRadius.circular(30),
                                buttonName: "Confirm Slots",
                                fontWeight: FontWeight.w500,
                                textSize: AppSizes.size_15,
                                buttonColor: homeController
                                        .slotAddList.isNotEmpty
                                    ? AppColor.primaryColor
                                    : AppColor.primaryColor,
                                textColor: AppColor.whiteColor,
                                onTap:
                                homeController.totalAmountWallet.value=="0"?(){
                                  flutterToast(msg: "Please add amount");
                                }:

                                homeController.slotAddList.isEmpty
                                    ? () {
                                        flutterToast(
                                            msg:
                                                "Please select province and slot");

                                      }
                                    : () {
                                        homeController.updateAddSlot(true);
                                        ApiManger().AddSLots(
                                          prodQuantity: List<dynamic>.from(
                                              homeController.slotAddList),
                                          context: context,
                                        );
                                      });
                      }),
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/layer.svg",
                                height: Get.height * 0.028,
                                color: AppColor.grey3Color,
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              AppText(
                                title: _selectedItem == null
                                    ? "Province"
                                    : _selectedItem.toString(),
                                size: AppSizes.size_15,
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: Get.width * 0.02),
                            child: SizedBox(
                              height: Get.height * 0.045,
                              width: Get.height * 0.07,
                              child: ButtonTheme(
                                  alignedDropdown: true,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Obx(() {
                                    return DropdownButton(
                                      value: provinceId,
                                      menuMaxHeight: Get.height * 0.3,
                                      isExpanded: true,
                                      isDense: true,
                                      icon: SvgPicture.asset(
                                        "assets/icons/fil.svg",
                                        height: Get.height * 0.023,
                                        color: AppColor.grey3Color,
                                      ), // Specify the icon here
                                      iconSize: Get.height * 0.05,
                                      elevation:
                                      Get.put(AuthController()).provinceList.isEmpty ? 16 : 16,
                                      underline: Container(),
                                      style: TextStyle(color: Colors.black),
                                      onChanged: (value) async {
                                        setState(() {
                                          homeController.getSlotData(
                                            id: value.toString(),
                                          );

                                          for (int i = 0;
                                              i < Get.put(AuthController()).provinceList.length;
                                              i++) {
                                            setState(() {
                                              if (Get.put(AuthController()).provinceList[i].id ==
                                                  value) {
                                                _selectedItem =
                                                    Get.put(AuthController()).provinceList[i].name;
                                              }
                                            });
                                          }
                                        });
                                      },

                                      items: countryDataList1(
                                          dataList: Get.put(AuthController()).provinceList),
                                    );
                                  })),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                      child: Obx(() {
                        return (homeController.isLoading.value
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.05,
                                  ),
                                  Center(
                                      child: SpinKitThreeBounce(
                                          size: 25,
                                          color: AppColor.primaryColor)),
                                ],
                              )
                            : homeController.getSlot.isNotEmpty
                                ? GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    primary: false,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                homeController.getSlot.isEmpty
                                                    ? 5
                                                    : 5,
                                            childAspectRatio:
                                                Get.width / Get.width * 1.2,
                                            crossAxisSpacing: 6,
                                            mainAxisSpacing: 16),
                                    itemCount: homeController.getSlot.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          print(homeController.getSlot[index].id
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
                                                                  if (value >= 1.0 && !isScratched) {
                                                                    setState(() {
                                                                      isScratched = true; // Scratch threshold reached
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
                                                                          title:homeController.getSlot[index].coupon.toString(),
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
                                                    .getSlot[index].type ==
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
                                                          .getSlot[index].isScratch=="true"?
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
                                                  .getSlot[index]
                                                  .type ==
                                                  "house"
                                                  ? SvgPicture.asset(
                                                "assets/icons/home.svg",
                                                color:
                                                homeController
                                                    .getSlot[index].isScratch=="true"?
                                                    AppColor.primaryColor:
                                                AppColor.grey3Color,
                                              )
                                                  : SvgPicture.asset(
                                                "assets/icons/car.svg",
                                                color:
                                                homeController
                                                    .getSlot[index].isScratch=="true"?
                                                AppColor.primaryColor:

                                                AppColor.grey3Color,
                                              );
                                            }),
                                          ),
                                        ),
                                      );
                                    })
                                : noData(height: Get.height * 0));
                      }),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                  ],
                ),
              ))
            ],
          ),
          // Positioned(child: child)
          Positioned(
              top: Get.height * 0.037,
              right: 4,
              child: GestureDetector(
                onTap: (){
                  Get.to(WalletView(),
                      transition: Transition.rightToLeft
                  );
                },
                child: Image.asset(
                  "assets/images/add1.png",
                  
                  height: Get.height * 0.088,

                ),
              ))
        ],
      ),
    );
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
                    height: Get.height * 0.3,
                    child: Center(
                      child: Scratcher(
                        brushSize: 50, // Adjust the brush size as needed
                        threshold: 40, // Adjust the threshold as needed
                        color: isScratched ? Colors.transparent : Colors.grey, // Initial scratch card color
                        image: Image.asset('assets/images/scratch.png',
                        height: Get.height*0.06,
                        ), // Custom brush image
                        onChange: (value) {
                          if (value >= 1.0 && !isScratched) {
                            setState(() {
                              isScratched = true; // Scratch threshold reached
                            });
                          }
                          print("Scratch progress: ${value * 100}%");
                        },
                        child: Container(
                          width: 300,
                          height: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isScratched ? Colors.blue : Colors.transparent, // Content revealed
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: isScratched
                                ? [] // No shadow when content is revealed
                                : [BoxShadow(blurRadius: 10, color: Colors.grey)], // Add a blurred effect
                          ),
                          child: isScratched
                              ? Text(
                            'Value: Your Value Here', // Display your value
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                              : Text(
                            'Scratch Me!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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


  // Future<void> scratchDialog({required BuildContext context, text, id,String?value}) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape: CircleBorder(),
  //           title: SizedBox.shrink(),
  //           content: Container(
  //             height: Get.height * 0.83,
  //             child: Column(
  //               children: [
  //                 SizedBox(
  //                   height: Get.height * 0.28,
  //                 ),
  //                 SizedBox(
  //                   height: Get.height * 0.01,
  //                 ),
  //                 StatefulBuilder(builder: (context, StateSetter setState) {
  //                   return Padding(
  //                     padding:
  //                     EdgeInsets.symmetric(horizontal: Get.width * 0.04),
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(50),
  //                       child:
  //                       value==null?
  //
  //                       Scratcher(
  //                         accuracy: ScratchAccuracy.low,
  //                         color: Colors.blueGrey,
  //                         onChange: (value) {
  //                           setState(() {
  //                             if (value == 60.0) {
  //                               ApiManger().claimScratch(
  //                                   context: context, id: id.toString());
  //                             } else {
  //                               print(value.toString());
  //                             }
  //                           });
  //                         },
  //                         onScratchStart: () {
  //                           print("Scratching has started");
  //                         },
  //                         onScratchUpdate: () {
  //                           print("Scratching in progress");
  //                         },
  //                         onScratchEnd: () {
  //                           print("Scratching has finished");
  //                         },
  //                         image: Image.asset(
  //                           'assets/images/scan1.png',
  //                         ),
  //                         brushSize: 15,
  //                         threshold: 60,
  //                         onThreshold: () {
  //                           setState(() {
  //                             _opacity = 1;
  //                           });
  //                         },
  //                         child: AnimatedOpacity(
  //                           duration: Duration(microseconds: 100),
  //                           opacity: _opacity,
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(10)),
  //                             height: MediaQuery.of(context).size.height * 0.22,
  //                             width: MediaQuery.of(context).size.width * 0.5,
  //                             child: Column(
  //                               children: [
  //                                 SizedBox(
  //                                   height: Get.height * 0.02,
  //                                 ),
  //                                 AppText(
  //                                   title: "Congratulations!",
  //                                   size: AppSizes.size_16,
  //                                   fontFamily: AppFont.semi,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: AppColor.primaryColor,
  //                                 ),
  //                                 SizedBox(
  //                                   height: Get.height * 0.01,
  //                                 ),
  //                                 AppText(
  //                                   title: text.toString(),
  //                                   size: AppSizes.size_19,
  //                                   fontFamily: AppFont.semi,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: AppColor.blackColor,
  //                                 ),
  //                                 SizedBox(
  //                                   height: Get.height * 0.01,
  //                                 ),
  //                                 Image.asset(
  //                                   "assets/images/sca.png",
  //                                   height: Get.height * 0.09,
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ):Container(
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10)),
  //                         height: MediaQuery.of(context).size.height * 0.22,
  //                         width: MediaQuery.of(context).size.width * 0.5,
  //                         child: Column(
  //                           children: [
  //                             SizedBox(
  //                               height: Get.height * 0.03,
  //                             ),
  //                             AppText(
  //                               title: "Congratulations!",
  //                               size: AppSizes.size_16,
  //                               fontFamily: AppFont.semi,
  //                               fontWeight: FontWeight.w600,
  //                               color: AppColor.primaryColor,
  //                             ),
  //                             SizedBox(
  //                               height: Get.height * 0.015,
  //                             ),
  //                             AppText(
  //                               title: text.toString(),
  //                               size: AppSizes.size_17,
  //                               fontFamily: AppFont.semi,
  //                               fontWeight: FontWeight.w600,
  //                               color: AppColor.blackColor,
  //                             ),
  //                             SizedBox(
  //                               height: Get.height * 0.005,
  //                             ),
  //                             Image.asset(
  //                               "assets/images/sca.png",
  //                               height: Get.height * 0.1,
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 }),
  //                 SizedBox(
  //                   height: Get.height * 0.13,
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
  //                   child: AppButton(
  //                     buttonName: "Cancel",
  //                     buttonColor: AppColor.primaryColor,
  //                     textColor: AppColor.whiteColor,
  //                     onTap: () {
  //                       Get.back();
  //                     },
  //                     buttonHeight: Get.height * 0.055,
  //                     buttonWidth: Get.width,
  //                     fontFamily: AppFont.medium,
  //                     textSize: AppSizes.size_16,
  //                     buttonRadius: BorderRadius.circular(30),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  List<DropdownMenuItem<int>> countryDataList({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/layer.svg",
                height: Get.height * 0.026,
                color: AppColor.boldBlackColor,
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
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

  List<DropdownMenuItem<int>> countryDataList1({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: AppText(
            title: dataList[i].name,
            size: AppSizes.size_15,
            color: AppColor.blackColor,
            fontFamily: AppFont.medium,
            fontWeight: FontWeight.w500,
          )));
    }
    return outputList;
  }
}
