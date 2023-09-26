  import 'package:flutter/material.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';

Widget textProfile(text){
  return  AppText(
    title: text,
    size: AppSizes.size_14,
    fontFamily: AppFont.medium,
    fontWeight: FontWeight.w500,
    color: AppColor.blackColor,
  );
  }