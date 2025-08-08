import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prayer_app/core/utils/toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prayer_app/core/service/api_client.dart';
import 'package:prayer_app/core/service/api_url.dart';
import 'model/prayer_time_response.dart';

class PrayersController extends GetxController {


  ///===================== Create new event =====================

  Position? _currentPosition;

  RxString address="".obs;

  Future<void> getUserCurrentLocation() async {
    try {

      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition();

      _currentPosition = position;

      debugPrint("_currentPosition: ${_currentPosition?.latitude},${_currentPosition?.longitude}");

      List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition?.latitude??0.0, _currentPosition?.longitude??0.0);

      if (placemarks.isNotEmpty) {

        Placemark place = placemarks[0];


        address.value ="${place.street}, ${place.country}";

      } else {
          address.value = "address found.";
      }

    } catch (e) {
      print("Error getting location: $e");
    }
  }


  ///======= Get all missing Prayer Times ==============

  RxList<PrayerTimeResponse> prayerTimeList = <PrayerTimeResponse>[].obs;

  RxBool retrivePrayerLoading = false.obs;

  RxInt prayedLanght= 0.obs;

  RxInt missingPrayerLanght= 0.obs;

  Future<void> retrivePrayerMissingTime(String currentDate) async{

   retrivePrayerLoading.value = true;

   missingPrayerLanght.value=0;
   prayedLanght.value=0;

    var response = await ApiClient.getData(ApiUrl.prayersTime(date: currentDate));

    if (response.statusCode == 200) {

      prayerTimeList.value = List.from(response.body["data"].map((m)=> PrayerTimeResponse.fromJson(m)));

      prayerTimeList[0].prayers?.forEach((prayer) {

        if(prayer.isComplete == true){

          prayedLanght.value++;

          print("prayedLanght:${prayedLanght.value}");

        }if(prayer.isComplete == false){

          missingPrayerLanght.value++;

          print("missing:${prayedLanght.value}");

        }
      });

      retrivePrayerLoading.value =false;
      refresh();

    } else {

      retrivePrayerLoading.value =false;

      Toast.errorToast(response.body['message']);
    }
  }


  var selectedDate = DateTime.now().obs;

  // Reactive date string
  var formattedCurrentDate = ''.obs;

  // Function to get current date in dd-MM-yyyy format
  void getCurrentFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    formattedCurrentDate.value = formatter.format(now);

    debugPrint("formattedDate:${formattedCurrentDate.value}");
  }


  /// ===== selected date prayers time log =======

  RxString selectedPrayerMissingDate="".obs;

  void selectDateMissing() async {

    DateTime? pickedDate = await showDatePicker(
      context: Get.context!, initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if(pickedDate != null ){

      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      selectedPrayerMissingDate.value = formattedDate;

      retrivePrayerMissingTime(selectedPrayerMissingDate.value);
    }
  }



  @override
  void onInit() {
    super.onInit();

    getUserCurrentLocation();

    /// current date
    getCurrentFormattedDate();

    if(formattedCurrentDate.value.isNotEmpty){

      ///get prayer time
      retrivePrayerMissingTime(formattedCurrentDate.value,);
    }

  }


}