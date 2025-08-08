

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prayer_app/core/features/fitness/model/fitness_response.dart';
import 'package:prayer_app/core/features/journal/model/journals_all_response.dart';
import 'package:prayer_app/core/service/api_client.dart';
import 'package:prayer_app/core/service/api_url.dart';
import 'package:prayer_app/core/utils/toast.dart';
import 'package:pedometer/pedometer.dart';

class FitnessController extends GetxController   {

  /// chart mx value
  RxDouble maxValue=0.0.obs;

  RxDouble minValue=0.0.obs;

  RxBool chartValueStatus=false.obs;

  RxInt currentIndex = 0.obs;

  RxList<String> nameList = [
    "Daily",
    "Week",
    "Month",
  ].obs;

  // Reactive date string
  var formattedCurrentDate = ''.obs;

  // Function to get current date in dd-MM-yyyy format
  void getCurrentFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    formattedCurrentDate.value = formatter.format(now);

    debugPrint("formattedDate:${formattedCurrentDate.value}");
  }


  ///===================== Get All Journals by date =====================

  RxList<JournalsAllResponse> retriveAJournalLList = <JournalsAllResponse>[].obs;
  RxBool retriveJournalsLoading = false.obs;

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
      Toast.errorToast(response.body['message']??"An error occurred. Please try again.");

    }
  }

  ///===== step count =======
  var steps = 0.obs;
  var pedestrianStatus = 'Unknown'.obs;

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;


  Future<void> initPlatformState() async {
    bool granted = await _checkActivityRecognitionPermission();

    if (!granted) {
      Get.snackbar('Permission Denied',
          'Step tracking will not work without activity recognition permission.');
      return;
    }

    _startListening(); // Only called if permission granted
  }

  Future<bool> _checkActivityRecognitionPermission() async {
    var status = await Permission.activityRecognition.status;

    if (!status.isGranted) {
      status = await Permission.activityRecognition.request();
    }

    return status.isGranted;
  }

  void _startListening() {
    print("✅ Starting step & status listeners...");

    _stepCountStream = Pedometer.stepCountStream;
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;

    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
    _pedestrianStatusStream.listen(_onPedestrianStatusChanged).onError(_onPedestrianStatusError);
  }

  void _onStepCount(StepCount event) {
    steps.value = event.steps;
  }

  void _onStepCountError(error) {
    print("Step Count Error: $error");
    steps.value = 0;
  }

  void _onPedestrianStatusChanged(PedestrianStatus event) {
    pedestrianStatus.value = event.status;
  }

  void _onPedestrianStatusError(error) {
    print("Pedestrian Status Error: $error");
    pedestrianStatus.value = "Unknown";
  }



  ///=========== Daily /Week/ month Fitness step ===========

  Rx<FitnessResponse> retriveDailyMonthList = FitnessResponse().obs;

  RxBool retriveDailyMonthLoading = false.obs;

  RxDouble  water=0.0.obs;
  RxDouble  calories=0.0.obs;

  /// month count value

  RxDouble stepTotalStep = 0.0.obs;

  Future<void> retriveDailyMonth(String fromDate,String endDate) async{

    retriveDailyMonthLoading.value = true;


    var response = await ApiClient.getData(ApiUrl.fitnessDailyWeekMonth(fromDate: fromDate,endDate: endDate));

    if (response.statusCode == 200) {

      if(response.body["data"]!=null){

        retriveDailyMonthList.value = FitnessResponse.fromJson(response.body["data"]);


        if(retriveDailyMonthList.value.calculation!=null){

          water.value = retriveDailyMonthList.value.calculation?.totalWater?.toDouble()??0.0*100/2500;
          calories.value=  retriveDailyMonthList.value.calculation?.totalCalories?.toDouble()??0.0*100/2600;

          stepTotalStep.value = retriveDailyMonthList.value.calculation?.totalStep?.toDouble()??0.0;

        }else{

          stepTotalStep.value=0.0;
        }
      }

      retriveDailyMonthLoading.value =false;
      refresh();

    } else {

      retriveDailyMonthLoading.value =false;
      Toast.errorToast(response.body['message']??"An error occurred. Please try again.");

    }
  }


  String getPrevious7Days() {
    // Get today's date
    DateTime currentDate = DateTime.now();

    // Calculate the previous 7 days
    DateTime previous7Days = currentDate.subtract(Duration(days: 7));

    // Return the previous date as a string in the format yyyy-MM-dd20

    return "${previous7Days.year.toString().padLeft(4, '0')}-${(previous7Days.month).toString().padLeft(2, '0')}-${(previous7Days.day).toString().padLeft(2, '0')}";
  }

  /// week steps

  RxBool retriveDailyWeekLoading = false.obs;
  Future<void> retriveWeek() async{

    retriveDailyWeekLoading.value = true;


    var response = await ApiClient.getData(ApiUrl.fitnessWeek(status: true));

    if (response.statusCode == 200) {

      if(response.body["data"]!=null){

        retriveDailyMonthList.value = FitnessResponse.fromJson(response.body["data"]);


        if(retriveDailyMonthList.value.calculation!=null){

          water.value = retriveDailyMonthList.value.calculation?.totalWater?.toDouble()??0.0*100/2500;
          calories.value=  retriveDailyMonthList.value.calculation?.totalCalories?.toDouble()??0.0*100/2600;

          stepTotalStep.value = retriveDailyMonthList.value.calculation?.totalStep?.toDouble()??0.0;

        }else{

          stepTotalStep.value=0.0;
        }
      }

      retriveDailyWeekLoading.value =false;
      refresh();

    } else {

      retriveDailyWeekLoading.value =false;
      Toast.errorToast(response.body['message']??"An error occurred. Please try again.");

    }
  }



///fitness screen month custom calendar

  Rx<DateTime?> _selectedStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> _selectedEndDate = Rx<DateTime?>(null);

  DateTime? get selectedStartDate => _selectedStartDate.value;
  DateTime? get selectedEndDate => _selectedEndDate.value;

  void selectDate(DateTime date) {
    if (_selectedStartDate.value == null) {
      _selectedStartDate.value = date;
      _selectedEndDate.value = null; // Clear end date if start is changed
    } else if (_selectedEndDate.value == null && date.isAfter(_selectedStartDate.value!)) {
      _selectedEndDate.value = date;
    } else {
      // If both start and end are selected, reset the start date
      _selectedStartDate.value = date;
      _selectedEndDate.value = null;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    initPlatformState();

    getCurrentFormattedDate();

    if(formattedCurrentDate.value.isNotEmpty){

     searchJournalDateList(formattedCurrentDate.value);
    }

    stepCounterUser();
  }


  void stepCounterUser() {

    Timer.periodic(Duration(minutes: 5), (time) {

      stepCounter();

    });
  }


  ///===================== stepCounter value to api =====================
  Future<void> stepCounter() async {

    var body = {

      "step": steps.value
    };

    var response = await ApiClient.patchData(ApiUrl.stepUpdate, jsonEncode(body));
    if (response.statusCode == 200) {

      refresh();
      //Toast.successToast(response.body['message']);

      debugPrint("stepsValue:${response.body["data"]}");

    } else {

      refresh();
      Toast.errorToast(response.body['message']);

    }
  }
}