import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/widgets/helper_function.dart';



class VendorController extends GetxController {

  var token = "".obs;
  var email = "".obs;
  var type = "".obs;
  var name = "".obs;

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

    HelperFunctions.getFromPreference("type").then((value) {
      type.value = value;

      update();
    });
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      getStoreData();
      print(token.toString());


      print(token.value.toString());
      update();
    });



    super.onInit();

  }



  var storeLoading = false.obs;

  var storeList = [].obs;
  getStoreData() async {
    try {

      storeLoading(true);
      update();

      var profData = await ApiManger.getStore();
      if (profData != null) {
        storeList.value =
        profData.data as dynamic;

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

