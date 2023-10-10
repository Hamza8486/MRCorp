import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/app_textfield.dart';
import 'package:mr_bet/widgets/drop_down.dart';

Widget textAuth({text,Color?color}){
  return Row(
    children: [
      AppText(
        title: "$text",
        size: AppSizes.size_14,
        fontWeight: FontWeight.w400,
        fontFamily: AppFont.regular,
        color: AppColor.boldBlackColor.withOpacity(0.8),
      ),
      AppText(
        title: " *",
        size: AppSizes.size_14,
        fontWeight: FontWeight.w400,
        fontFamily: AppFont.regular,
        color: color??
        AppColor.boldBlackColor.withOpacity(0.8),
      ),
    ],
  );
}

Widget betField({String? Function(String?)? validator,TextEditingController?controller,
  String?hint="", TextInputType?textInputType,TextInputAction?textInputAction,
  bool obscure = false,
  bool isSuffix= true,
  bool isRead=false,
  bool isCur=true,
  int?max,
  Widget?child,
final VoidCallback? onTap,
  Function(String?)? onChange


}){
  return AppTextFied(
    isborderline: true,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    isborderline2: true,
    validator: validator,
    obsecure: obscure,
    onTap: onTap,
    onChange: onChange,
    isReadOnly: isRead,
    isShowCursor: isCur,
    suffixIcon: child??SizedBox.shrink(),
    padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.03,
        vertical: Get.height * 0.016),
    borderRadius: BorderRadius.circular(10),
    borderRadius2: BorderRadius.circular(10),
    borderColor: AppColor.borderColorField,
    hint: hint??"",
    hintColor: AppColor.greyColors,

    textInputType:
    textInputType??
    TextInputType.emailAddress,
    textInputAction:
    textInputAction??
    TextInputAction.next,
    hintSize: AppSizes.size_13,
    isSuffix: isSuffix,
    controller: controller,
    fontFamily: AppFont.regular,
    borderColor2: AppColor.primaryColor,
    maxLines: max??1,
  );
}
Widget dropDownAppAdd({hint,onChange,items,value,width,Color?color,double ? height}){
  return SortedByDropDown(
      hint: hint,
      icon: SvgPicture.asset("assets/icons/downs.svg",height: Get.height*0.03,),
      buttonDecoration: BoxDecoration(
        color: AppColor.transParent,
        border: Border.all(
            color:
            color??
            AppColor.borderColorField, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      fontSize: AppSizes.size_14,
      fontFamily: AppFont.regular,
      hintColor:AppColor.greyColors,
      fontFamily1: AppFont.regular,
      fontSize1: AppSizes.size_13,
      dropdownItems: items,
      value: value,
      buttonHeight: Get.height * 0.054,
      dropdownHeight:height?? Get.height,
      dropdownWidth: width,
      buttonElevation: 0,
      onChanged: onChange
  );
}





Widget dropDownAppAddAll({hint,onChange,items,value,width,Color?color,double ? height, Widget?child1}){
  return SortedByDropDown(
      hint: hint,
      icon: SvgPicture.asset("assets/icons/downs.svg",height: Get.height*0.03,),
      child1: child1,
      buttonDecoration: BoxDecoration(
        color: AppColor.transParent,

        border: Border.all(
            color:
            color??
                AppColor.borderColorField, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      fontSize: AppSizes.size_14,
      fontFamily: AppFont.regular,
      hintColor:AppColor.greyColors,
      fontFamily1: AppFont.regular,
      fontSize1: AppSizes.size_13,
      dropdownItems: items,
      value: value,
      buttonHeight: Get.height * 0.054,
      dropdownHeight:height?? Get.height,
      dropdownWidth: width,
      buttonElevation: 0,
      onChanged: onChange
  );
}





Widget chooseOptionsAll({onTap,color,color1,color2,String?text}){
  return  GestureDetector(
    onTap: onTap,
    child: Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            height: Get.height*0.021,
            width: Get.height*0.021,
            decoration: BoxDecoration(
                color: color,
                border: Border.all(color: color1),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Center(child: Icon(Icons.check,color: color2,
              size: Get.height*0.018,
            )),
          ),
          SizedBox(width: Get.width*0.02,),
          AppText(
              title:text?? "",
              color: AppColor.blackColor,
              fontFamily: AppFont.regular,
              size: AppSizes.size_14)
        ],
      ),
    ),
  );
}