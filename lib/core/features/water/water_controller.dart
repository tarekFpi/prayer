
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/features/water/model/WaterCaloriesResponse.dart';
import 'package:prayer_app/core/service/api_check.dart';
import 'package:prayer_app/core/service/api_client.dart';
import 'package:prayer_app/core/service/api_url.dart';
import 'package:prayer_app/core/utils/toast.dart';


class WaterController extends GetxController {

  // Reactive date string
  var formattedDate = ''.obs;

  /// water screen horizontal
  var selectedDate = DateTime.now().obs;
  var daysInMonth = <DateTime>[].obs;


  var currentDate = ''.obs;

  void loadCurrentMonthDates() {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final totalDays = DateTime(now.year, now.month + 1, 0).day;

    daysInMonth.value = List.generate(
      totalDays,
          (i) => firstDay.add(Duration(days: i)),
    );

    final formatter = DateFormat('yyyy-MM-dd');
    currentDate.value = formatter.format(now);

  }

  void selectDate(DateTime date) {
    selectedDate.value = date;

    final formatter = DateFormat('yyyy-MM-dd');
    formattedDate.value = formatter.format(selectedDate.value);

    ///retrive water date  for today
      retriveWaterCalories(formattedDate.value);
  }


  ///===================== Get Activity History  for today =====================

  RxList<WaterCaloriesResponse> retriveWaterCaloriesList = <WaterCaloriesResponse>[].obs;
  RxBool retriveWaterCaloriesLoading = false.obs;

  RxDouble  water=0.0.obs;
  RxDouble  calories=0.0.obs;

  Future<void> retriveWaterCalories(String date) async{

    retriveWaterCaloriesLoading.value = true;

    var response = await ApiClient.getData(ApiUrl.activitiesWaterCalories(date: date));

    if (response.statusCode == 200) {

      if(response.body["data"]!=null){

        // retriveWaterCaloriesList.value = WaterCaloriesResponse.fromJson(response.body["data"]);

        retriveWaterCaloriesList.value = List.from(response.body["data"].map((m)=> WaterCaloriesResponse.fromJson(m)));
      }

      retriveWaterCaloriesLoading.value =false;
      refresh();

    } else {

      retriveWaterCaloriesLoading.value =false;

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




  RxString selectedStartDate="".obs;

  void selectHistoryDate() async {

    DateTime? pickedDate = await showDatePicker(
      context: Get.context!, initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if(pickedDate != null ){

      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      selectedStartDate.value = formattedDate;

        retriveWaterCalories(selectedStartDate.value);
    }
  }

  /// ========= Update Activity =============

  Rx<TextEditingController> waterInputController = TextEditingController().obs;

  RxBool waterLoddingLoading = false.obs;

  Future<void> addWaterActivity() async {

    waterLoddingLoading.value = true;

    var body = {
      "water": waterInputController.value.text
    };

    var response = await ApiClient.patchData(ApiUrl.addWater, jsonEncode(body));

    if (response.statusCode == 200) {

      waterLoddingLoading.value = false;

      Toast.successToast(response.body['message']!);

      waterInputController.value.clear();
      Get.offNamed(AppRoutes.homeScreen);

    } else {

      waterLoddingLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        final decodedBody = json.decode(response.body);
        Toast.errorToast(decodedBody["error"]);
        return;

      } else {

        ApiChecker.checkApi(response);
        return;
      }
    }
  }



  @override
  void onInit() {
    super.onInit();

    loadCurrentMonthDates();




  }


}