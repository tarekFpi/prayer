import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/helper/shared_prefe/shared_prefe.dart';
import 'package:prayer_app/core/service/api_check.dart';
import 'package:prayer_app/core/service/api_client.dart';
import 'package:prayer_app/core/service/api_url.dart';
import 'package:prayer_app/core/utils/app_const/app_const.dart';
import 'package:prayer_app/core/utils/app_strings/app_strings.dart';
import 'package:prayer_app/core/utils/toast.dart';


class PrivayController extends GetxController {


  ///======================================>> get privacy-policy api <<================================

  var privacy_policyList="".obs;

  RxBool privacy_policyLoading = false.obs;

  Future<void> showPrivacyPolicyList() async{

    privacy_policyLoading.value=true;

    try{
      var response = await ApiClient.getData(ApiUrl.privacyPolicy);

      if (response.statusCode == 200) {

        privacy_policyList.value = response.body["data"]["content"];

        debugPrint("privacy_policyList:${privacy_policyList.value}");
        privacy_policyLoading.value=false;

      } else {

        privacy_policyLoading.value=false;
        if (response.statusText == ApiClient.somethingWentWrong) {
          final decodedBody = json.decode(response.body);
          Toast.errorToast(decodedBody["error"]);
          refresh();
          return;
        } else {

          ApiChecker.checkApi(response);

          refresh();
          return;
        }
      }
    }catch(e){

      privacy_policyLoading.value=false;
      Toast.errorToast(e.toString());
      debugPrint(e.toString());
    }
  }


  ///Get terms and condition

  var terms_condition="".obs;

  RxBool terms_conditionLoading = false.obs;

  Future<void> showTermsCondition() async{

    terms_conditionLoading.value=true;

    try{
      var response = await ApiClient.getData(ApiUrl.termsCondition);

      if (response.statusCode == 200) {

        terms_condition.value = response.body["data"]["content"];

        debugPrint("privacy_policyList:${terms_condition.value}");
        terms_conditionLoading.value=false;

      } else {

        terms_conditionLoading.value=false;

        if (response.statusText == ApiClient.somethingWentWrong) {

          final decodedBody = json.decode(response.body);
          Toast.errorToast(decodedBody["error"]);
          refresh();
          return;
        } else {

          ApiChecker.checkApi(response);

          refresh();
          return;
        }
      }
    }catch(e){

      terms_conditionLoading.value=false;
      Toast.errorToast(e.toString());
      debugPrint(e.toString());
    }
  }


}