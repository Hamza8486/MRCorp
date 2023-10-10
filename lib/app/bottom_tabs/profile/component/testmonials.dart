import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/video_view.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/helper_function.dart';

class Testimonials extends StatefulWidget {
  const Testimonials({Key? key}) : super(key: key);

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  String? _selectedItem;
  var provinceId;
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(onTap1: (){},onTap: (){
            Get.back();
          },text: "Testmonials",
              image: "assets/icons/share.svg",color: AppColor.whiteColor
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          title: "Our User’s Reviews",
                          size: AppSizes.size_16,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(right: Get.width*0.02),
                          child: SizedBox(
                            height: Get.height*0.045,
                            width: Get.height*0.07,
                            child: ButtonTheme(
                                alignedDropdown: true,
                                materialTapTargetSize: MaterialTapTargetSize.padded,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child:Obx(
                                        () {
                                      return DropdownButton(
                                        value: provinceId,
                                        menuMaxHeight: Get.height * 0.3,
                                        isExpanded: true,
                                        isDense: true,
                                        icon: SvgPicture.asset("assets/icons/fil.svg",height: Get.height*0.023,
                                          color: AppColor.primaryColor,
                                        ), // Specify the icon here
                                        iconSize: Get.height*0.05,
                                        elevation:
                                        Get.put(AuthController()).provinceList.isEmpty?16:
                                        16,
                                        underline: Container(),
                                        style: TextStyle(color: Colors.black),
                                        onChanged: (value) async {
                                          setState(() {

                                            homeController.getAllTest(id: value.toString(),

                                            );


                                            for (int i = 0;
                                            i <
                                                Get.put(AuthController())
                                                    .provinceList.length;
                                            i++) {
                                              setState(() {
                                                if (  Get.put(AuthController())
                                                    .provinceList[i].id == value) {
                                                  _selectedItem= Get.put(AuthController())
                                                      .provinceList[i].name;



                                                }
                                              });

                                            }

                                          });



                                        },

                                        items: countryDataList1(dataList:  Get.put(AuthController()).provinceList),
                                      );
                                    }
                                )
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Obx(
                      () {
                        return
                         homeController.testLoading.value?loader():
                         homeController.testList.isNotEmpty?
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: Get.width / Get.height * 1.6,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 16),
                            itemCount: homeController.testList.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: (){
                                  Get.to(VideoViewDetail(data:homeController.testList[index].videos.video,));
                                },
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
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                        child:CachedNetworkImage(
                                          placeholder: (context, url) =>  Center(
                                            child: SpinKitThreeBounce(
                                                size: 16,
                                                color: AppColor.primaryColor
                                            ),
                                          ),
                                          imageUrl: homeController.testList[index].images.image??"",
                                          height: Get.height * 0.11,
                                          width: Get.width,
                                          fit: BoxFit.cover,

                                          errorWidget: (context, url, error) => Image.asset(
                                            "assets/images/persons.jpg",
                                            fit: BoxFit.cover,
                                            height: Get.height * 0.11,
                                            width: Get.width,
                                          ),
                                        ),




                                      ),
                                      SizedBox(height: Get.height*0.01,),
                                      Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.01),
                                        child: SizedBox(
                                          width:Get.width*0.24,
                                          child: Center(
                                            child: AppText(
                                              title: homeController.testList[index].name,
                                              size: AppSizes.size_15,
                                              maxLines: 1,
                                              fontFamily: AppFont.medium,
                                              overFlow: TextOverflow.ellipsis,

                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: Get.height*0.01,),
                                    ],
                                  ),
                                ),
                              );
                            }):noData(height: Get.height * 0.35);
                      }
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
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
  List<DropdownMenuItem<int>> countryDataList1({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child:  AppText(
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
