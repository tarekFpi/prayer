
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prayer_app/core/features/profile/model/profile_response.dart';
import 'package:prayer_app/core/helper/shared_prefe/shared_prefe.dart';
import 'package:prayer_app/core/service/api_client.dart';
import 'package:prayer_app/core/service/api_url.dart';
import 'package:prayer_app/core/utils/toast.dart';


class ProfileController extends GetxController {

  ///======================================>> picker Cover photo  <<================================

  final ImagePicker pickerCover = ImagePicker();
  //File? imagePath;
  RxString chooseUserImage = "".obs;

  Future<void> chooseUserPhoto() async {
    try {
      final XFile? pickedFile =
      await pickerCover.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Convert XFile to File if needed

        chooseUserImage.value = pickedFile.path; // Ensure the file path is valid
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  ///========= profile address =========

  Position? _currentPosition;

  RxString currentAddress="".obs;

  Future<void> getUserCurrentLocation() async {
    try {

      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition();

      _currentPosition = position;


      debugPrint("_currentPosition: ${_currentPosition?.latitude},${_currentPosition?.longitude}");

      List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition?.latitude??0.0, _currentPosition?.longitude??0.0);

      if (placemarks.isNotEmpty) {

        Placemark place = placemarks[0];

        currentAddress.value ="${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

        cityUser.value = place.locality.toString();

        countryUser.value = place.country.toString();

        debugPrint("cityController:${cityUser.value}");
      } else {
        // address.value = "No address found.";
      }

    } catch (e) {
      print("Error getting location: $e");
    }
  }


  ///====== get user profile =============

  Rx<TextEditingController> fullNameController = TextEditingController().obs;

  RxString cityUser = "".obs;

  RxString countryUser = "".obs;

  Rx<ProfileResponse> userProfileShow = ProfileResponse().obs;

  RxBool userInfoShowLoading = false.obs;

  Future<void> userInformationShow() async {

    userInfoShowLoading.value=true;

    var response = await ApiClient.getData(ApiUrl.userProfileShow);

    if (response.statusCode == 200) {

      userProfileShow.value = ProfileResponse.fromJson(response.body["data"]);

      fullNameController.value.text =userProfileShow.value.fullName.toString();

      refresh();
      userInfoShowLoading.value=false;

    } else {

      userInfoShowLoading.value=false;
      refresh();
      Toast.errorToast(response.body['message']);
    }
  }

  ///======================================>> users-profile-show <<================================

  RxBool userInfoUpdateShowLoading = false.obs;

  Future<void> profileUpdate() async {

    userInfoUpdateShowLoading.value = true;

    Map<String, String> body = {
      "data": jsonEncode(
          {
            "fullName": fullNameController.value.text,
            "city": cityUser.value,
            "country": countryUser.value
          }
      ),
    };


    var response = await ApiClient.patchMultipartData(ApiUrl.updateProfile, body,
        multipartBody: [MultipartBody('file', File(chooseUserImage.value))]);

    final decodedBody = json.decode(response.body);

    if (response.statusCode == 200) {


      Toast.successToast(decodedBody["message"]);

      Get.back();
      refresh();
      userInfoUpdateShowLoading.value = false;

    } else {

      userInfoUpdateShowLoading.value = false;
      refresh();
      Toast.errorToast(response.body['message']);
    }
  }

///======== change password ==========

  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;


  RxBool changePasswordLoading = false.obs;

  Future<void> changePassword() async {

    changePasswordLoading(true);

    var body = {
      "oldPassword": passwordController.value.text,
      "newPassword": confirmPasswordController.value.text
    };

    debugPrint("${jsonEncode(body)}");

     var response = await ApiClient.patchData(ApiUrl.changePassword, jsonEncode(body));

    if (response.statusCode == 200) {

      changePasswordLoading(false);
      refresh();

      Toast.successToast(response.body["message"]);

      Get.back();
    } else {

    Toast.errorToast(response.body["message"]);

      changePasswordLoading(false);
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getUserCurrentLocation();

    userInformationShow();
  }
}