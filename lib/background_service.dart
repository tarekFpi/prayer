import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'core/features/fitness/fitness_controller.dart';

@pragma('vm:entry-point')
class BackgroundService {


  // Function to get current date in dd-MM-yyyy format
  void getCurrentFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    // Debugging the formatted date
    debugPrint("Formatted Date: ${formatter.format(now)}");
  }

  static Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,  // This method will be called to start the background service
        autoStart: true,
        isForegroundMode: true,  // Keeps the service running in foreground
        notificationChannelId: 'ajan_channel',
        initialNotificationTitle: 'Ajan Service Running',
        initialNotificationContent: 'Waiting for prayer times...',
         foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        onForeground: onStart,
        onBackground: onBackground,
      ),
    );
  }

  static Future<bool> onBackground(ServiceInstance service,) async {
    onStart(service);  // Reuse onStart logic for background
    return true;
  }

  // Add @pragma('vm:entry-point') annotation here to ensure the method is accessible from native code
  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) {

    //final  fitnessController = Get.put(FitnessController());

    Timer.periodic(Duration(milliseconds: 10), (timer) async {
      final now = DateTime.now();
      print("date: ${now.toIso8601String()}");
      await stepCountTimes();
    });

  }


  // This function checks prayer times from an API
  static Future<void> stepCountTimes() async {

    debugPrint("stepCountTimes:");

/*    var body = {
      "step": stepCount,
    };

    var response = await ApiClient.patchData(ApiUrl.stepUpdate,jsonEncode(body));

    if (response.statusCode == 200) {

      debugPrint("stepCount successFull..");

    } else {
      Toast.errorToast("An error occurred. Please try again.");
    }*/
  }


  // Method to play the Azan sound
  static Future<void> playAzan(String prayerName) async {
    final audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource("audio/prayer.mp3"));

  }
}