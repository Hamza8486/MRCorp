
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/province_model.dart';
import 'package:mr_bet/services/api_manager.dart';

class AuthController extends GetxController {
  File ?file;
  File ?file1;


  var nameProvince = "".obs;
  updateNameProv(val){
    nameProvince.value=val;
    update();
  }
  var isVisible = true.obs;
  var isVisible1 = true.obs;
  var isVisible2 = true.obs;
  var provinceId;
  TextEditingController addressController = TextEditingController();
  var loader = false.obs;
  var lat="".obs;
  var lng="".obs;
  updateLat(val){
    lat.value=val;
    update();

  }
  updateLng(val){
    lng.value=val;
    update();

  }
  var loaderLogin = false.obs;
  var loaderForget = false.obs;
  var loaderResend = false.obs;
  var loaderVerify = false.obs;
  var loaderPassword = false.obs;
  List<String> provinceAllList = [];
  updateForgetLoader(val){
    loaderForget.value = val;
    update();}
  updateResendLoader(val){
    loaderResend.value = val;
    update();}
  updateVerifyLoader(val){
    loaderVerify.value = val;
    update();}
  updatePasswordLoader(val){
    loaderPassword.value = val;
    update();}






  updateLoader(val){
    loader.value = val;
    update();}
  updateLoginLoader(val){
    loaderLogin.value = val;
    update();


  }
  var countryName="".obs;
  updateVisibleStatus() {
    isVisible.toggle();
    update();
  }


  updateCoName(val){
    countryName.value = val;
    update();
  }

  updateVisible1Status() {
    isVisible1.toggle();
    update();
  }
  updateVisible2Status() {
    isVisible2.toggle();
    update();
  }





  TextEditingController emailController = TextEditingController();
  TextEditingController emailForgetController = TextEditingController();
  TextEditingController verifyCodeForgetController = TextEditingController();
  TextEditingController passController = TextEditingController();


  TextEditingController emailRegController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passRegController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();
  TextEditingController occuController = TextEditingController();
  TextEditingController referralController = TextEditingController();


  RxBool isCheck = false.obs;
  updateCheck(val) {
    isCheck.value = val;
    update();
  }

  RxBool isCheck2 = false.obs;
  updateCheck2(val) {
    isCheck2.value = val;
    update();
  }

  RxBool isCheck3 = false.obs;
  updateCheck3(val) {
    isCheck3.value = val;
    update();
  }



  @override
  Future<void> onInit() async {
    super.onInit();
    getProvinceData();
  }

  var provinceList = <Province>[].obs;

  getProvinceData() async {
    try {

      update();

      var profData = await ApiManger.getProvince();
      if (profData != null) {
        provinceList.value = profData.province as dynamic;
        for (int i = 0; i < profData.province!.length; i++) {
          provinceAllList
              .add(profData.province![i].name.toString());
        }
        print(
            "This is province ${profData.province}");
      } else {

        update();
      }
    } catch (e) {

      update();
      debugPrint(e.toString());
    } finally {

      update();
    }
    update();
  }

  clearForget(){
    verifyCodeForgetController.clear();
    emailForgetController.clear();
     isVisible = true.obs;
     isVisible1 = true.obs;
     isVisible2 = true.obs;
     updateVerifyLoader(false);
     updateResendLoader(false);
     updatePasswordLoader(false);
     updateForgetLoader(false);
  }

  clear(){
    fullNameController.clear();
    occuController.clear();
    storeNameController.clear();
    storeAddressController.clear();
    updateCheck(false);
    updateCheck2(false);
    updateLng("");
    updateLat("");
    file=null;
    file1=null;
    isVisible = true.obs;
    isVisible1 = true.obs;
    isVisible2 = true.obs;
    updateLoginLoader(false);
    updateLoader(false);
    emailRegController.clear();
    passRegController.clear();
    mobileController.clear();
    provinceId=null;
  }

}