import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController{

  RxInt currentIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex.value);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

}