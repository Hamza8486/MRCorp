import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/auth/forget/model/resend_model.dart';
import 'package:mr_bet/app/auth/forget/view/new_password.dart';
import 'package:mr_bet/app/auth/forget/view/otp.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/app/auth/province_model.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/account.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/bet_model.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/my_slots.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/testmonials.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/transaction_model.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/winners_model.dart';
import 'package:mr_bet/app/bottom_tabs/profile/model/profile_model.dart';
import 'package:mr_bet/app/bottom_tabs/profile/model/support_model.dart';
import 'package:mr_bet/app/bottom_tabs/profile/model/user_store.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/controller/wallet_controller.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/model/wallet_model.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/app/home/home_view.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/app/vendor_home/vendor_home.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/stores/model/store_model.dart';
import 'package:mr_bet/util/constant.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/helper_function.dart';


class ApiManger extends GetConnect {






  static Future<GetProvinceModel?> getProvince() async {
    var response = await http.get(
        Uri.parse(AppConstants.baseURL+AppConstants.getProvince),

      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer 30|CVtaCSWkeggK4K7qy2ipOtullnSsxL15N5V17ehw"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetProvinceModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<GetBusinessStore?> getStore() async {
    var response = await http.get(
      Uri.parse(AppConstants.baseURL+AppConstants.getStore),

      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${Get.put(VendorController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetBusinessStore.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<GetBetModel?> getBetApi() async {
    var response = await http.get(
      Uri.parse(AppConstants.baseURL+AppConstants.getBet),

      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetBetModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<UserStoreModel?> getUserStore() async {
    var response = await http.get(
      Uri.parse(AppConstants.baseURL+AppConstants.userStore),

      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',

      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return UserStoreModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }




  static Future<GetSupportModel?> getFaq() async {
    var response = await http.get(
      Uri.parse(AppConstants.baseURL+AppConstants.faq),

      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetSupportModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  registerResponse({required BuildContext context}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'full_name': Get.put(AuthController()).fullNameController.text,
        'email': Get.put(AuthController()).emailRegController.text,
        'password': Get.put(AuthController()).passRegController.text,
        'has_car': Get.put(AuthController()).isCheck.value==false?"no":"yes",
        'has_house': Get.put(AuthController()).isCheck2.value==false?"no":"yes",
        'living_status': Get.put(AuthController()).occuController.text,
        'dob': "1999-05-03",
        'refer_code': Get.put(AuthController()).referralController.text,
        'mobile': Get.put(AuthController()).mobileController.text,
        'province': Get.put(AuthController()).provinceId.toString(),
        'device_token': "device12345",
      });
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.register,
        data: data,
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",


          })
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
       //refferalResponse(context: context,token: )
         Get.put(AuthController()).updateLoader(false);
        Get.put(AuthController()).clear();
        flutterToastSuccess(msg: "Account Register Successfully");
        Get.offAll(LoginView());
        print(response.data);

      }
      else if(response.statusCode==202){
        Get.put(AuthController()).updateLoader(false);
        flutterToast(msg: response.data["error"].toString());
      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoader(false);
      print(e.response?.data.toString());
      flutterToast(msg: e.response?.data["error"].toString());
    }
  }



  sendMessage({required BuildContext context,text,text1}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'title':text1.toString(),
        'message':text.toString(),
        'email':Get.put(HomeController()).email.value,
        'phone':Get.put(HomeController()).phone.value,

      });
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.contac,
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"


          })
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        //refferalResponse(context: context,token: )
        Get.put(HomeController()).updateAddSlot(false);
        Get.put(AuthController()).clear();
        flutterToastSuccess(msg: "Request Submitted Successfully");
        print(response.data);

      }
      else if(response.statusCode==202){
        Get.put(HomeController()).updateAddSlot(false);
        flutterToast(msg: response.data["error"].toString());
      }
    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateAddSlot(false);
      print(e.response?.data.toString());
      flutterToast(msg: e.response?.data["error"].toString());
    }
  }


  businessRegister({context}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'full_name': Get.put(AuthController()).fullNameController.text,
          'email': Get.put(AuthController()).emailRegController.text,
          'store_name': Get.put(AuthController()).storeNameController.text,
          'store_address': Get.put(AuthController()).addressController.text,
          'mobile': Get.put(AuthController()).mobileController.text,
          'lat': Get.put(AuthController()).lat.value,
          'lng': Get.put(AuthController()).lng.value,
          'store_license_id': "11222333",
          'store_city': Get.put(AuthController()).provinceId.toString(),
          'password': Get.put(AuthController()).passRegController.text,
          Get.put(AuthController()).file==null?"":
          'store_pic':
          Get.put(AuthController()).file == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(AuthController()).file!.path),
          Get.put(AuthController()).file1==null?"":
          'store_license_picture':
          Get.put(AuthController()).file1 == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(AuthController()).file1!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.storeRegister,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",


            })
        );
        print(AppConstants.baseURL + AppConstants.storeRegister);
        if (response.statusCode == 200) {


          Get.put(AuthController()).updateLoader(false);
          Get.put(AuthController()).clear();
          flutterToastSuccess1(msg: "Account Register Successfully");
         Get.offAll(LoginView());
          print(response.data);

        }
        else if(response.statusCode==202){
          Get.put(AuthController()).updateLoader(false);
          flutterToast(msg: response.data["error"].toString());

        }
      } on dio.DioError catch (e) {
        Get.put(AuthController()).updateLoader(false);
        flutterToast(msg: e.response?.data["error"].toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoader(false);
      flutterToast(msg: e.response?.data["error"].toString());
    }
  }



  addStore({context}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'full_name': Get.put(VendorController()).name.value,
          'store_name': Get.put(AuthController()).storeNameController.text,
          'store_address': Get.put(AuthController()).addressController.text,
          'mobile': Get.put(AuthController()).mobileController.text,
          'lat': Get.put(AuthController()).lat.value,
          'lng': Get.put(AuthController()).lng.value,
          'store_license_id': "11222333",
          'store_city': Get.put(AuthController()).provinceId.toString(),
          Get.put(AuthController()).file==null?"":
          'store_pic':
          Get.put(AuthController()).file == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(AuthController()).file!.path),
          Get.put(AuthController()).file1==null?"":
          'store_license_picture':
          Get.put(AuthController()).file1 == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(AuthController()).file1!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.addStore,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",

              HttpHeaders.authorizationHeader: "Bearer ${Get.put(VendorController()).token.value}"


            })
        );
        if (response.statusCode == 200) {

          Get.put(VendorController()).getStoreData();
          Get.put(AuthController()).updateLoader(false);
          Get.put(AuthController()).clear();
          flutterToastSuccess1(msg: "Store Created Successfully");
          Get.back();
          print(response.data);

        }
        else if(response.statusCode==202){
          Get.put(AuthController()).updateLoader(false);
          flutterToast(msg: response.data["error"].toString());

        }
      } on dio.DioError catch (e) {
        Get.put(AuthController()).updateLoader(false);
        flutterToast(msg: e.response?.data["error"].toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoader(false);
      flutterToast(msg: e.response?.data["error"].toString());
    }
  }


  userStore({context}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'full_name': Get.put(HomeController()).name.value,
          'store_name': Get.put(AuthController()).storeNameController.text,
          'store_address': Get.put(AuthController()).addressController.text,
          'mobile': Get.put(AuthController()).mobileController.text,
          'lat': Get.put(AuthController()).lat.value,
          'lng': Get.put(AuthController()).lng.value,
          'store_license_id': "11222333",
          'store_city': Get.put(AuthController()).provinceId.toString(),
          Get.put(AuthController()).file==null?"":
          'store_pic':
          Get.put(AuthController()).file == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(AuthController()).file!.path),
          Get.put(AuthController()).file1==null?"":
          'store_license_picture':
          Get.put(AuthController()).file1 == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(AuthController()).file1!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.add_User_Store,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",

              HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"


            })
        );
        if (response.statusCode == 200) {

          Get.put(HomeController()).getStoreData();
          Get.put(AuthController()).updateLoader(false);
          Get.put(AuthController()).clear();
          flutterToastSuccess1(msg: "Store Created Successfully");
          Get.back();
          print(response.data);

        }
        else if(response.statusCode==202){
          Get.put(AuthController()).updateLoader(false);
          flutterToast(msg: response.data["error"].toString());

        }
      } on dio.DioError catch (e) {
        Get.put(AuthController()).updateLoader(false);
        flutterToast(msg: e.response?.data["error"].toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoader(false);
      flutterToast(msg: e.response?.data["error"].toString());
    }
  }







  loginResponse({required BuildContext context,email,password,token}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': email.toString(),
        'password':password.toString(),

        'device_token': token.toString(),
      });
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.login,
          data: data,
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",


          })
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {



        if(response.data['data']['type']=="user"){
          HelperFunctions.saveInPreference(
              "token", response.data['token'].toString());

          HelperFunctions.saveInPreference(
              "name", response.data['data']['full_name'].toString());

          HelperFunctions.saveInPreference(
              "email", response.data['data']['email'].toString());


          HelperFunctions.saveInPreference(
              "phone", response.data['data']['mobile'].toString());
          HelperFunctions.saveInPreference(
              "living", response.data['data']['living_status'].toString());
          HelperFunctions.saveInPreference(
              "type", response.data['data']['type'].toString());
          HelperFunctions.saveInPreference(
              "image",
              response.data['data']["image"]==null?""
                  :            response.data['data']["image"].toString());
          Get.offAll(Home());
        }
        else{
          HelperFunctions.saveInPreference(
              "token", response.data['token'].toString());

          HelperFunctions.saveInPreference(
              "name", response.data['data']['full_name'].toString());

          HelperFunctions.saveInPreference(
              "email", response.data['data']['email'].toString());

          HelperFunctions.saveInPreference(
              "type", response.data['data']['type'].toString());
          Get.offAll(VendorHome());

        }



        Get.put(AuthController()).updateLoginLoader(false);
      }
      else if(response.statusCode==202){
        Get.put(AuthController()).updateLoginLoader(false);
        flutterToast(msg: response.data.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoginLoader(false);
      print(e.response?.data.toString());
      flutterToast(msg: e.response?.data["error"].toString());
    }
  }



  AddSLots(
      {
        required List prodQuantity,
        required BuildContext context}) async {

      try {
        /*Map data*/ dio.FormData data = dio.FormData.fromMap({
          'object': jsonEncode(prodQuantity),


        });
        print(jsonEncode(prodQuantity));
        print("Data::::: ${data.fields}");




        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.addSLOT,
            data: data,

            options: dio.Options(

                headers: {
                  HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"

                }));
        print(response.toString());
        if (response.statusCode == 200 || response.statusCode == 201) {

          Get.put(HomeController()).getAllBetData();
          Get.put(HomeController()).getSlotData1(id: "",filter: "",type: "");
          Get.put(HomeController()).getSlotData(id: "",filter: "");
          Get.put(HomeController()).getWalletData();
          flutterToast(msg: "Slots Add Successfully");
          Get.put(HomeController()).updateAddSlot(false);
          Get.put(HomeController()).slotAddList.clear();
          print(response.data.toString());

        }
        else if(response.statusCode==202){
          flutterToast(msg: response.data["message"].toString());
          Get.put(HomeController()).updateAddSlot(false);
        }
      } on dio.DioError catch (e) {
        print(e.response?.data.toString());
        Get.put(HomeController()).updateAddSlot(false);
      }
    }
  static Future<getMySlots?> getMySlotsAll({id="",type="",filter=""}) async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.getSlot}?type=${type.toString()}&province_id=${id.toString()}&filter=${filter.toString()}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return getMySlots.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  forgetResponse({context, email}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': email,
      });
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.forget,
        data: data,
      );
      if (response.statusCode == 200) {
        Get.to(OtpScreen());
        Get.put(AuthController()).updateForgetLoader(false);


        flutterToast(msg: "Successfully Code Sent");
      }
      else if(response.statusCode==202){
        flutterToast(msg: response.data["error"].toString());
        Get.put(AuthController()).updateForgetLoader(false);
      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateForgetLoader(false);
      flutterToast(msg: e.response?.data["error"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }

  //...........Resend Code.........................

  static Future<ResendModel?> resendResponse(
      {var email, required BuildContext context}) async {
    Map<String, dynamic> body = <String, dynamic>{};
    body['email'] = email;

    var response = await http
        .post(Uri.parse(AppConstants.baseURL+AppConstants.resend),


        body: body);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      Get.put(AuthController()).updateResendLoader(false);
      flutterToast(msg: "Code resent successfully");

      return ResendModel.fromJson(jsonString);
    } else if (response.statusCode == 202) {

      var jsonString = jsonDecode(response.body);
      flutterToast(msg: jsonString["error"].toString());
      Get.put(AuthController()).updateResendLoader(false);
      return ResendModel.fromJson(jsonString);
    }
    Get.put(AuthController()).updateResendLoader(false);
    return null;
  }

  //...........Verify Code.........................

  verifyResponse({ context, email, code}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': email,
        'forgot_password_code': code,
      });
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.verify,
        data: data,
      );
      if (response.statusCode == 200) {
        Get.put(AuthController()).updateVerifyLoader(false);
        Get.to(NewPassword());


        flutterToast(msg: "Please set your password");
      }
      else if(response.statusCode==202){
        flutterToast(msg: "Invalid Code");

        Get.put(AuthController()).updateVerifyLoader(false);
      }
    } on dio.DioError catch (e) {


      Get.put(AuthController()).updateVerifyLoader(false);
      flutterToast(msg: "Invalid Code");
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }


  //...........Change Password.........................

  changePassResponse({ context, email, password}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': email,
        'password': password,
      });
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.resetPass,
        data: data,
      );
      if (response.statusCode == 200) {

        Get.put(AuthController()).updatePasswordLoader(false);
        Get.offAll(LoginView());
        Get.put(AuthController()).clearForget();

        flutterToast(msg: "Password reset successfully");
      }
      else if (response.statusCode == 202) {



        Get.put(AuthController()).updatePasswordLoader(false);
        flutterToast(msg: response.data["error"].toString());
      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updatePasswordLoader(false);
      flutterToast(msg: e.response?.data["error"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());

    }
  }





  static Future<GetProfileModel?> getProfileModel() async {
    var response = await http.get(
      Uri.parse(AppConstants.baseURL+AppConstants.getProfile),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetProfileModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }
  claimReward({name,phone,email,id,addrss,XFile?file}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'first_name': name.toString(),
          'last_name': ".",
          'phone_number': phone.toString(),
          'address': addrss.toString(),
          'email': email,
          'slot_id': Get.put(HomeController()).slotProfileId.value.toString(),
           'video':
          file == null
              ? ""
              : await dio.MultipartFile.fromFile(
              file.path),
          'image':
          Get.put(HomeController()).claimProfile == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(HomeController()).claimProfile!.path),

        });

        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.claimReward,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"


            })

        );
        if (response.statusCode == 200) {

          Get.put(HomeController()).updateIsClaim(false);
          Get.put(HomeController()).getAllTest(id: "");
          Get.put(HomeController()).getProfileData();


          Get.put(HomeController()).videoFile=null;
          Get.put(HomeController()).claimProfile=null;
          Get.offAll(Home());

          flutterToastSuccess(msg: "Claim request submitted! Please wait admin approval");

        }
        else if(response.statusCode==202){
          Get.put(HomeController()).updateIsClaim(false);
          flutterToast(msg: response.data["error"].toString());
        }
      } on dio.DioError catch (e) {
        Get.put(HomeController()).updateIsClaim(false);
        flutterToast(msg: e.response?.data["error"].toString());
      }
    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateIsClaim(false);
      flutterToast(msg: e.response?.data["error"].toString());
    }
  }


  claimScratch({ context, id}) async {
    try {
      var response = await dio.Dio().get(
        "${AppConstants.baseURL}${AppConstants.scratch}?slot_id=${id.toString()}",
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"


          })

      );
      print(response.toString());
      if (response.statusCode == 200) {
        Get.put(HomeController()).getSlotData1(id: "",filter: "",type: "");
        Get.put(HomeController()).getSlotData(id: "",filter: "");
        print(response.data.toString());

      }
      else if(response.statusCode==202){
        print(response.data.toString());

        Get.put(AuthController()).updateVerifyLoader(false);
      }
    } on dio.DioError catch (e) {

      print(e.response?.data.toString());
    }
  }
  static Future<TestMonialsModel?> getTest({id=""}) async {
    var response = await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.testmonials}?pro_id=${id.toString()}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        // HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return TestMonialsModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }




  static Future<winnersModel?> getWinners() async {
    var response = await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.getWinners}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        // HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return winnersModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }
editUserResponse1({context,name,phone,province,}) async {
  try {
    late dio.MultipartFile x, lisenceFile;

    try {
      dio.FormData data = dio.FormData.fromMap({
        'full_name': name.toString(),
        'mobile': phone.toString(),
        'province': province.toString(),
        'user_name':Get.put(HomeController()).name.value,
        'email': Get.put(HomeController()).email.value,
        Get.put(HomeController()).file==null?"":
        'image':
        Get.put(HomeController()).file == null
            ? "":
        await dio.MultipartFile.fromFile(

            Get.put(HomeController()).file!.path),
      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.updateProfile,
        data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"


          })
      );
      if (response.statusCode == 200) {


        flutterToastSuccess(msg: "Profile Update Successfully");
        HelperFunctions.saveInPreference("name",
            response.data["data"]['full_name'].toString());
        Get.put(HomeController()).updateFirstName(
            response.data["data"]['full_name'].toString());


        HelperFunctions.saveInPreference("phone",
            response.data["data"]['mobile'].toString());
        Get.put(HomeController()).updatePhone(
            response.data["data"]['mobile'].toString());
        Get.put(HomeController()).getProfileData();
        Get.put(HomeController()).updateLoader(false);
        Get.back();
        Get.put(HomeController()).file=null;

      }
      else if(response.statusCode==202){
        flutterToast(msg: response.data.toString());
        Get.put(HomeController()).updateLoader(false);

      }
    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateLoader(false);

      flutterToast(msg: e.response?.data.toString());
      // log("e.response");


    }
  } on dio.DioError catch (e) {
    Get.put(HomeController()).updateLoader(false);
    flutterToast(msg: e.response?.data.toString());
    log(e.toString());
  }
}





  addBankAccountResp({context,name,iban,title,}) async {

      try {
        dio.FormData data = dio.FormData.fromMap({
          'name': name.toString(),
          'iban': iban.toString(),
          'account_number': title.toString(),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.addAccount,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"


            })
        );
        if (response.statusCode == 200) {


          flutterToastSuccess(msg: "Add Successfully");
          Get.put(HomeController()).getAccountData();
          Get.back();

        }
        else if(response.statusCode==202){
          flutterToast(msg: response.data.toString());
          Get.put(HomeController()).updateLoader(false);

        }

    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateLoader(false);
      flutterToast(msg: e.response?.data.toString());
      log(e.toString());
    }
  }



  refferalResponse({ context,token}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'refer_code': Get.put(AuthController()).referralController.text,
      });
      var response = await dio.Dio().post(
          "${AppConstants.baseURL}${AppConstants.referrlCode}",
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${token.toString()}"


          })

      );
      print(response.toString());
      if (response.statusCode == 200) {
        Get.put(AuthController()).referralController.clear();

      }
      else if(response.statusCode==202){

      }
    } on dio.DioError catch (e) {

      print(e.response?.data.toString());
    }
  }


  addPaymentWalet({ amount,id}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'transaction_id':id.toString(),
        'amount':amount.toString(),
      });
      print(data.fields);
      print(data.fields);
      var response = await dio.Dio().post(
          "${AppConstants.baseURL}${AppConstants.addPayment}",
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value.toString()}"


          })

      );
      print(data.fields);
      print(data.fields);
      print(response.toString());
      if (response.statusCode == 200) {
        Get.put(PaymentController()).updateCheckLoader(false);
        Get.put(PaymentController()).priceController.clear();
        Get.put(PaymentController()).updateCheckPayment("");
        Get.put(PaymentController()).updatePaymentId("");
        print(response.data.toString());
        flutterToastSuccess(msg: "Payment Added Successfully");
        Get.put(HomeController()).getWalletData();

      }
      else if(response.statusCode==202){
        print(response.data.toString());
        Get.put(PaymentController()).updateCheckLoader(false);
      }
    } on dio.DioError catch (e) {
      Get.put(PaymentController()).updateCheckLoader(false);
      print(e.response?.data.toString());
    }
  }



  static Future<GetWalletModel?> getWalletModel() async {
    var response = await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.getPayment}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetWalletModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<MyTransactionModel?> getTrans() async {
    var response = await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.myTrans}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return MyTransactionModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<AccountListModel?> getAccount() async {
    var response = await http.get(
      Uri.parse("https://mr-corp.ca/api/${AppConstants.getAccount}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return AccountListModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  deleteCal({id}) async {
    try {
      var response = await dio.Dio().get(
          "https://mr-corp.ca/api/${AppConstants.delAccount}?account_id=${id.toString()}",
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"

          })
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        flutterToast(msg: "Deleted");
        Get.back();
        Get.put(HomeController()).getAccountData();
        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
    } on dio.DioError catch (e) {
      Get.back();

      flutterToast(msg: e.response?.data["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }
}