import 'dart:async';
import 'package:get/get.dart';
import 'package:prayer_app/core/utils/toast.dart';

class TimerController extends GetxController {



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    showToastAfter2Seconds();
  }

  void showToastAfter2Seconds() {

   /* Timer.periodic(Duration(seconds: 5), (time) {
     Toast.successToast("hello");
    });*/
  }


}
