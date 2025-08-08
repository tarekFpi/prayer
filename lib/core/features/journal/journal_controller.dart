
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/core/utils/toast.dart';
import 'package:get/get.dart';
import 'package:prayer_app/core/service/api_client.dart';
import 'package:prayer_app/core/service/api_url.dart';

import 'model/journals_all_response.dart';


class JournalController extends GetxController {


  Rx<TextEditingController> reflectionController = TextEditingController().obs;
  Rx<TextEditingController> goalsController = TextEditingController().obs;
  Rx<TextEditingController> challengesController = TextEditingController().obs;


  RxBool journalCreateLoading = false.obs;

  Future<void> journalCreate() async{

    journalCreateLoading.value = true;

    var body = {
      "reflection": reflectionController.value.text,
      "goals": goalsController.value.text,
      "challenges": challengesController.value.text
    };

    var response = await ApiClient.postData(ApiUrl.journalCreate,jsonEncode(body));

    if (response.statusCode == 201) {

      Toast.successToast(response.body['message']!);

      journalCreateLoading.value =false;
      refresh();

      reflectionController.value.clear();
      goalsController.value.clear();
      challengesController.value.clear();

      searchJournalDateList(formattedCurrentDate.value);


    } else {

      refresh();
      journalCreateLoading.value =false;

      Toast.errorToast(response.body['message']!);
    }
  }

  ///========== journals update ========

  RxBool journalUpdateLoading = false.obs;

  Future<void> journalUpdate(String updateId) async{

    journalUpdateLoading.value = true;

    var body = {
      "reflection": reflectionController.value.text,
      "goals": goalsController.value.text,
      "challenges": challengesController.value.text
    };

    var response = await ApiClient.patchData(ApiUrl.updateJournals(updateId: updateId),jsonEncode(body));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']!);

      journalUpdateLoading.value =false;
      refresh();

      reflectionController.value.clear();
      goalsController.value.clear();

      searchJournalDateList(formattedCurrentDate.value);

    } else {

      refresh();
      journalUpdateLoading.value =false;

      Toast.errorToast(response.body['message']!);
    }
  }



  ///===================== Get All Journals by date =====================

  RxList<JournalsAllResponse> retriveAJournalLList = <JournalsAllResponse>[].obs;
  RxBool retriveJournalsLoading = false.obs;

 /* Future<void> retriveAllJournals() async{

    retriveJournalsLoading.value = true;

    var response = await ApiClient.getData(ApiUrl.getJournals);

    if (response.statusCode == 200) {

      if(response.body["data"]!=null){

        retriveAJournalLList.value = List.from(response.body["data"].map((m)=> JournalsAllResponse.fromJson(m)));

      }

      retriveJournalsLoading.value =false;
      refresh();

    } else {

      retriveJournalsLoading.value =false;
     // Toast.errorToast(response.body['message']);

      final decodedBody = json.decode(response.body);
      Toast.errorToast(decodedBody["message"]);
    }
  }*/

  ///===================== Get All Journals by date =====================

  Future<void> searchJournalDateList(String date) async{

    retriveJournalsLoading.value = true;

    retriveAJournalLList.clear();
    var response = await ApiClient.getData(ApiUrl.getDateByJournals(date: date));

    if (response.statusCode == 200) {

      if(response.body["data"]!=null){

        retriveAJournalLList.value = List.from(response.body["data"].map((m)=> JournalsAllResponse.fromJson(m)));

      }

      retriveJournalsLoading.value =false;
      refresh();

    } else {

      retriveJournalsLoading.value =false;
      Toast.errorToast(response.body['message']);

    }
  }

  /// select date
  RxString formattedStartDate="select date".obs;

  void selectJournalDate() async {

    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      formattedStartDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
      searchJournalDateList(formattedStartDate.value.toString());

    } else {
      formattedStartDate.value = "Date not selected";
    }
  }

  ///============ Delete Tracker ==========

  RxBool journalDeleteLoading = false.obs;

  Future<void> journalDelete(String deleteId) async{

    journalDeleteLoading.value = true;

    var response = await ApiClient.deleteData(ApiUrl.deleteJournals(deleteId: deleteId));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']!);

      journalDeleteLoading.value =false;
      refresh();
      searchJournalDateList(formattedCurrentDate.value);

    } else {

      refresh();
      journalDeleteLoading.value =false;

      Toast.errorToast(response.body['message']!);
    }
  }

  // Reactive date string
  var formattedCurrentDate = ''.obs;
  // Function to get current date in dd-MM-yyyy format
  void getCurrentFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    formattedCurrentDate.value = formatter.format(now);

    debugPrint("formattedDate:${formattedCurrentDate.value}");
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getCurrentFormattedDate();

    if(formattedCurrentDate.value.isNotEmpty){

      searchJournalDateList(formattedCurrentDate.value);
    }

  }
}