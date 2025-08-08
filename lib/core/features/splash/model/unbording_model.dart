


import 'package:prayer_app/core/utils/app_images/app_images.dart';
import 'package:prayer_app/core/utils/app_strings/app_strings.dart';

class UnbordingModel {
  String image;
  String title;
  String details;

  UnbordingModel({required this.image, required this.title, required this.details});
}

List<UnbordingModel> contents = [

  UnbordingModel(
      image: AppImages.onboarding,
      title: AppStrings.title,
      details: AppStrings.subtitle1
  ),

  UnbordingModel(
      image: AppImages.onboarding2,
      title: AppStrings.title2,
      details: AppStrings.subtitle2
  ),

  UnbordingModel(
      image: AppImages.onboarding3,
      title: AppStrings.title3,
      details: AppStrings.subtitle3
  ),
];