import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/core/features/tracker_mood/model/trackers_mood_response.dart';
import 'package:prayer_app/core/service/api_check.dart';
import 'package:prayer_app/core/service/api_client.dart';
import 'package:prayer_app/core/service/api_url.dart';
import 'package:prayer_app/core/utils/toast.dart';


class MoodTrackerController extends GetxController {

  /// Get All Trackers

  RxList<TrackersMoodResponse> moodTrackersList = <TrackersMoodResponse>[].obs;

  RxBool retriveTrackersMoodLoading = false.obs;

  Future<void> retriveTrackersMood() async{

    retriveTrackersMoodLoading.value = true;

    var response = await ApiClient.getData(ApiUrl.getMoodTracker);

    if (response.statusCode == 201) {

      moodTrackersList.value = List.from(response.body["data"].map((m)=> TrackersMoodResponse.fromJson(m)));

      retriveTrackersMoodLoading.value =false;
      refresh();

    } else {

      retriveTrackersMoodLoading.value =false;
      Toast.errorToast(response.body['message']);

    }
  }



  ///Reactive date string
  var formattedCurrentDate = ''.obs;

  ///Function to get current date in dd-MM-yyyy format
  void getCurrentFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    formattedCurrentDate.value = formatter.format(now);

    debugPrint("formattedDate:${formattedCurrentDate.value}");
  }


  /// ====== Save Mood ==========

  Rx<TextEditingController> descriptionController = TextEditingController().obs;

 // Rx<TrackersMoodResponse> saveTrackersList = TrackersMoodResponse().obs;

  RxBool saveTrackersMoodLoading = false.obs;

  Future<void> saveTrackersMood(String title,) async{

    saveTrackersMoodLoading.value = true;

    var body = {
      "title": title,
      "description": descriptionController.value.text,

    };

    var response = await ApiClient.postData(ApiUrl.saveMoodTracker,jsonEncode(body));

    if (response.statusCode == 201) {

      Toast.successToast(response.body['message']);

      saveTrackersMoodLoading.value =false;
      descriptionController.value.clear();

      retriveTrackersMood();
      refresh();


    } else {


      if (response.statusText == ApiClient.somethingWentWrong) {
        Toast.errorToast(response.body['message']);
        saveTrackersMoodLoading.value =false;
        refresh();
        return;

      } else {

        ApiChecker.checkApi(response);
        saveTrackersMoodLoading.value =false;
        refresh();
        return;
      }
    }
  }


  /// Get All Trackers by search date
  Future<void> getTrackersMoodDate(String date) async{

    retriveTrackersMoodLoading.value = true;

    moodTrackersList.clear();

    var response = await ApiClient.getData(ApiUrl.moodByDateTracker(date:date));

    if (response.statusCode == 201) {

      moodTrackersList.value = List.from(response.body["data"].map((m)=> TrackersMoodResponse.fromJson(m)));

      retriveTrackersMoodLoading.value =false;
      refresh();

    } else {

      retriveTrackersMoodLoading.value =false;

      if (response.statusText == ApiClient.somethingWentWrong) {
        Toast.errorToast(response.body['message']);
        refresh();
        return;
      } else {

        ApiChecker.checkApi(response);

        refresh();
        return;
      }
    }
  }

  /// searchSelectedDate

  RxString searchSelectedDate="".obs;

  void searchSelectDate() async {

    DateTime? pickedDate = await showDatePicker(
      context: Get.context!, initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if(pickedDate != null ){

      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      searchSelectedDate.value = formattedDate;

      getTrackersMoodDate(searchSelectedDate.value);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


    getCurrentFormattedDate();
  }

}