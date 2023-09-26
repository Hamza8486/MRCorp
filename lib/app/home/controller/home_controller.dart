import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/my_slots.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/slot_model.dart';
import 'package:mr_bet/app/bottom_tabs/profile/model/profile_model.dart';
import 'package:mr_bet/app/bottom_tabs/profile/model/user_store.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/widgets/helper_function.dart';



class HomeController extends GetxController {
  var isValue = true.obs;
  RxBool expand = false.obs;
  var isLoading = false.obs;
  var isValue1 = true.obs;
  var checkLoader=false.obs;
  updateCheckLoader(val){
    checkLoader.value=val;
    update();
  }
  File?file;
  File?file1;

  var priceController = TextEditingController();
  var isValue2 = true.obs;
  var loader = false.obs;
  updateFirstName(val) {
    name.value = val;
    update();
  }

  updatePhone(val) {
    phone.value = val;
    update();
  }
  updateLoader(val){
    loader.value=val;
    update();
  }
  var profileId="".obs;
  updateProfileId(val){
    profileId.value=val;
    update();
  }
  var imageLoader = false.obs;
  var totalEarning="".obs;
  updateToatlEaening(val){
    totalEarning.value=val;
    update();
  }
  updateImageLoader(val){
    imageLoader.value=val;
    update();
  }
  var totalPrice="".obs;
  var image="".obs;
  updateProfileImage(val){
    image.value=val;
    update();

  }
  var referCode="".obs;
  updateReferCode(val){
    referCode.value=val;
    update();
  }


  var isClaim = false.obs;
  updateIsClaim(val){
    isClaim.value=val;
    update();
  }

  XFile?videoFile;
  File ?  myProfile;
  File ?  claimProfile;
  updateTotalPrice(val){
    totalPrice.value=val;
    update();

  }

  var slotProfileId="".obs;
  updateProfileSlot(val){
    slotProfileId.value=val;
    update();
  }

  var selectProvince="".obs;
  var isSelectProvince="".obs;
  updateProvincesName(val){
    selectProvince.value=val;
    update();
  }

  updateIsSelectProvince(val){
    isSelectProvince.value=val;
    update();
  }

  updateValue1(val) {
    isValue1.value = val;

    update();
  }
  updateValue2(val) {
    isValue2.value = val;

    update();
  }
  updateValue(val) {
    isValue.value = val;

    update();
  }
  var provinceId;
  var phone = "".obs;
  var token = "".obs;
  var email = "".obs;
  var type = "".obs;
  var name = "".obs;
  var selectOption = "3".obs;
  var selectOptionName = "grocery".obs;
  var provinceName="".obs;
  var province1Name="".obs;
  var slot="".obs;
  var typeSelect="".obs;
  updateProvinceName(val){
    provinceName.value=val;
    update();

  }
  updateProvince1Name(val){
    province1Name.value=val;
    update();

  }
  updateTypeSelect(val){
    typeSelect.value=val;
    update();

  }
  updateSlotName(val){
    slot.value=val;
    update();

  }

  var updateSelectValue=false.obs;
  updateSelect(val){
    updateSelectValue.value=val;

  }
  updateSelectName(val){
    selectOptionName.value=val;

  }



  updateSelectOption(val){
    selectOption.value=val;
    update();

  }
  TextEditingController nameController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  Future<void> onInit() async {



    HelperFunctions.getFromPreference("name").then((value) {
      name.value = value;
      print(name.value.toString());

      update();
    });

    HelperFunctions.getFromPreference("email").then((value) {
      email.value = value;

      update();
    });
    HelperFunctions.getFromPreference("phone").then((value) {
      phone.value = value;

      update();
    });
    HelperFunctions.getFromPreference("type").then((value) {
      type.value = value;

      update();
    });
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      print(token.toString());
      getProfileData();
      getTransData();
      getWalletData();
      getAccountData();
      getSlotData(id: "",filter: "");
      getSlotData1(id: "",filter: "",type: "");


      print(token.value.toString());
      update();
    });



    super.onInit();
    getAllTest(id: "");
    getWinnerData();
    getFaqData();
    getStoreData();
    //getHistoryData(id: "30746b29-8044-4c6b-aef8-f5cfdb584200");
  }

  var slotAddList=<AddSlotModel>[].obs;


  var getSlot = <SlotDataNew>[].obs;
  var getSlot1 = <SlotDataNew>[].obs;

  var isLoading1 = false.obs;
  var slotAdd = false.obs;
  updateAddSlot(val){
    slotAdd.value=val;
    update();
  }

  ProfileDataModel? profileAllData;
  getProfileData() async {
    try {


      update();

      var profData = await ApiManger.getProfileModel();
      if (profData != null) {
        profileAllData = profData.data as dynamic;
        updateProfileSlot(profData.data?.slotId==null?"":profData.data?.slotId.toString());
        updateProfileImage(profData.data?.image==null?"":profData.data?.image.toString());
        updateReferCode(profData.data?.referCode.toString()==null?"":profData.data?.referCode.toString());
        updateToatlEaening(profData.data?.earning==0?"0":profData.data?.earning.toString());
        updateProfileId(profData.data?.id==0?"0":profData.data?.id.toString());
        print(
            "This is my profile ${profData.data}");
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





  getSlotData({id="",filter=""}) async {
    try {

      isLoading(true);
      update();

      var profData = await ApiManger.getMySlotsAll(id: id,type: selectOptionName.value.toString(),filter: filter);
      if (profData != null) {
        getSlot.value = profData.data as dynamic;
        print(
            "This is my Slots ${profData.data}");
      } else {
        isLoading(false);
        update();
      }
    } catch (e) {

      isLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isLoading(false);
      update();
    }
    update();
  }


  getSlotData1({id="",filter="",type=""}) async {
    try {

      isLoading1(true);
      update();

      var profData = await ApiManger.getMySlotsAll(id: id,type: type,filter: filter);
      if (profData != null) {
        getSlot1.value = profData.data as dynamic;
        updateTotalPrice(
            profData.price==0||profData.price==null?"":
            profData.price.toString());
        print(
            "This is my Slots ${profData.data}");
      } else {
        isLoading1(false);
        update();
      }
    } catch (e) {

      isLoading1(false);
      update();
      debugPrint(e.toString());
    } finally {
      isLoading1(false);
      update();
    }
    update();
  }

  var testLoading = false.obs;
  var testList = [].obs;

  getAllTest({id=""}) async {
    try {

      testLoading(true);
      update();

      var profData = await ApiManger.getTest(id: id.toString());
      if (profData != null) {
        testList.value = profData.data as dynamic;

        print(
            "This is my Slots ${profData.data}");
      } else {
        testLoading(false);
        update();
      }
    } catch (e) {

      testLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      testLoading(false);
      update();
    }
    update();
  }





  var winnerValue = false.obs;
  var winnerList = [].obs;

  getWinnerData() async {
    try {

      winnerValue(true);
      update();

      var profData = await ApiManger.getWinners();
      if (profData != null) {
        winnerList.value = profData.data as dynamic;

        print(
            "This is my Slots ${profData.data}");
      } else {
        winnerValue(false);
        update();
      }
    } catch (e) {

      winnerValue(false);
      update();
      debugPrint(e.toString());
    } finally {
      winnerValue(false);
      update();
    }
    update();
  }





  var walletLoadingValue = false.obs;
  var transactionLoadingValue = false.obs;
  var walletList = [].obs;
  var transList = [].obs;
  var totalAmountWallet="".obs;
  updateTotalAmount(val){
    totalAmountWallet.value=val;
    update();

  }

  getWalletData() async {
    try {

      walletLoadingValue(true);
      update();

      var profData = await ApiManger.getWalletModel();
      if (profData != null) {
        walletList.value =

        profData.data?.transaction as dynamic;

        updateTotalAmount(
            profData==null?"0":
            profData.data?.balance==null?"0":
            profData.data?.balance==0?"0": profData.data?.balance.toString());
        print(
            "This is my balance ${ profData.data?.balance.toString()}");
      } else {
        walletLoadingValue(false);
        update();
      }
    } catch (e) {

      walletLoadingValue(false);
      update();
      debugPrint(e.toString());
    } finally {
      walletLoadingValue(false);
      update();
    }
    update();
  }
  getTransData() async {
    try {

      transactionLoadingValue(true);
      update();

      var profData = await ApiManger.getTrans();
      if (profData != null) {
        transList.value =
        profData.data?.myTransaction as dynamic;

      } else {
        transactionLoadingValue(false);
        update();
      }
    } catch (e) {

      transactionLoadingValue(false);
      update();
      debugPrint(e.toString());
    } finally {
      transactionLoadingValue(false);
      update();
    }
    update();
  }



  var accountLoading = false.obs;

  var accountList = [].obs;
  getAccountData() async {
    try {

      accountLoading(true);
      update();

      var profData = await ApiManger.getAccount();
      if (profData != null) {
        accountList.value =
        profData.amount as dynamic;

      } else {
        accountLoading(false);
        update();
      }
    } catch (e) {

      accountLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      accountLoading(false);
      update();
    }
    update();
  }




  var faqLoading = false.obs;

  var faqList = [].obs;
  getFaqData() async {
    try {

      faqLoading(true);
      update();

      var profData = await ApiManger.getFaq();
      if (profData != null) {
        faqList.value =
        profData.faq as dynamic;

      } else {
        faqLoading(false);
        update();
      }
    } catch (e) {

      faqLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      faqLoading(false);
      update();
    }
    update();
  }




  var storeLoading = false.obs;

  var storeList = <Stores>[].obs;
  getStoreData() async {
    try {

      storeLoading(true);
      update();

      var profData = await ApiManger.getUserStore();
      if (profData != null) {
        storeList.value =
        profData.stores as dynamic;


      } else {
        storeLoading(false);
        update();
      }
    } catch (e) {

      storeLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      storeLoading(false);
      update();
    }
    update();
  }
}

