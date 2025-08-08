import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/core/features/home/model/today_hadiths_response.dart';
import 'package:prayer_app/core/features/prayers/model/prayer_time_response.dart';
import 'package:prayer_app/core/features/water/model/WaterCaloriesResponse.dart';
import 'package:prayer_app/core/helper/time_converter/time_converter.dart';
import 'package:prayer_app/core/service/api_check.dart';
import 'package:prayer_app/core/service/api_client.dart';
import 'package:prayer_app/core/service/api_url.dart';
import 'package:prayer_app/core/utils/toast.dart';


class HomeController extends GetxController {

  ///Reactive date string
  var formattedCurrentDate = ''.obs;

  ///===================== retrive Get Hadith for Today =====================

   Rx<TodayHadithsResponse> retriveTodayHadithList = TodayHadithsResponse().obs;

  RxBool retriveTodayHadithLoading = false.obs;

  Future<void> retriveTodayHadith() async{

    retriveTodayHadithLoading.value = true;

    var response = await ApiClient.getData(ApiUrl.todayHadith);

    if (response.statusCode == 200) {

      if(response.body["data"]!=null){

        retriveTodayHadithList.value = TodayHadithsResponse.fromJson(response.body["data"]);

        debugPrint("retriveTodayHadith:${retriveTodayHadithList.value}");
      }

      retriveTodayHadithLoading.value =false;
      refresh();

    } else {

      retriveTodayHadithLoading.value =false;

      if (response.statusText == ApiClient.somethingWentWrong) {
      //  Toast.errorToast(response.body['message']);
        refresh();
        return;
      } else {

        ApiChecker.checkApi(response);

        refresh();
        return;
      }
    }
  }


   // Function to get current date in dd-MM-yyyy format
   void getCurrentFormattedDate() {
     final now = DateTime.now();
     final formatter = DateFormat('yyyy-MM-dd');
     formattedCurrentDate.value = formatter.format(now);

     debugPrint("formattedDate:${formattedCurrentDate.value}");
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

         if(retriveWaterCaloriesList.isNotEmpty){

           water.value = retriveWaterCaloriesList[0].water?.toDouble()??0.0*100/2500;
           calories.value=  retriveWaterCaloriesList[0].calories?.toDouble()??0.0*100/2600;

           debugPrint("retriveWaterCaloriesList:${response.body["data"]}");
         }


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

///======= current time ========

  var currentTime = ''.obs;

  void getCurrentTime() {
    final now = DateTime.now();
    currentTime.value= DateFormat('hh:mm a').format(now); // e.g. 08:45 PM
  }

 ///========= Get Prayer Times ==========

   RxList<PrayerTimeResponse> prayerTimeList = <PrayerTimeResponse>[].obs;

   RxBool retrivePrayerLoading = false.obs;

  var prayerName = ''.obs;

  var currentPrayerTime = ''.obs;

  Future<void> retrivePrayerTime(String date,{bool statue = false}) async{

    if(statue==false){

      retrivePrayerLoading.value = true;
    }

    var response = await ApiClient.getData(ApiUrl.prayersTime(date: date));

    if (response.statusCode == 200) {

      prayerTimeList.value = List.from(response.body["data"].map((m)=> PrayerTimeResponse.fromJson(m)));

      prayerTimeList[0].prayers?.forEach((prayer) {

        var formateTime =DateConverter.formatTime(prayer.time.toString());

          if (formateTime == currentTime.value) {
            prayerName.value = prayer.name.toString();
            currentPrayerTime.value = prayer.time.toString();

            print('match:${formateTime}');
          }

      });


      retrivePrayerLoading.value =false;
      refresh();

    } else {

      retrivePrayerLoading.value =false;

      if (response.statusText == ApiClient.somethingWentWrong) {
        Toast.errorToast(response.body['message']??"An error occurred. Please try again.");

        refresh();
        return;
      } else {

        ApiChecker.checkApi(response);

        refresh();
        return;
      }
    }
  }


///==================== Update Prayer time ================

  RxBool prayerUpdateLoading = false.obs;

  Future<void> prayerUpdate(String prayerName,String prayerTime,bool isComplete) async{

    prayerUpdateLoading.value = true;

    var body = {
      "date": formattedCurrentDate.value.toString(),
      "prayerName": prayerName,
      "time": prayerTime,
      "isComplete": isComplete
    };

    print("API Body=====: ${jsonEncode(body)}");

    var response = await ApiClient.putData(ApiUrl.prayersTimeUpdate,body);

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']!);

      prayerUpdateLoading.value =false;
      refresh();
      retrivePrayerTime(formattedCurrentDate.value,statue: true);

    } else {

      refresh();
      prayerUpdateLoading.value =false;

      Toast.errorToast(response.body['message']??"An error occurred. Please try again.");
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getCurrentFormattedDate();

    getCurrentTime();

   retriveTodayHadith();

   if(formattedCurrentDate.value.isNotEmpty){

     ///get prayer time
     retrivePrayerTime(formattedCurrentDate.value);

     ///retrive water date  for today
     retriveWaterCalories(formattedCurrentDate.value);
   }
  }



}