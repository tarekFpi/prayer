import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/helper/shared_prefe/shared_prefe.dart';
import 'package:prayer_app/core/service/api_check.dart';
import 'package:prayer_app/core/service/api_client.dart';
import 'package:prayer_app/core/service/api_url.dart';
import 'package:prayer_app/core/utils/app_const/app_const.dart';
import 'package:prayer_app/core/utils/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {


  RxBool agreeStatue = false.obs;

  RxString checkValueStatues = "".obs;

  RxBool agreeStatus = false.obs;

  ///====================USER REGISTER CONTROLLER==================
  Rx<TextEditingController> fullNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;


  ///=====================USER REGISTER METHOD=====================
  RxBool userRegisterLoading = false.obs;

  Future<void> userRegister() async {

    userRegisterLoading.value = true;

    var body =  {
      "fullName": fullNameController.value.text,
      "email": emailController.value.text,
      "password": passwordController.value.text,
    };

    var response = await ApiClient.postData(ApiUrl.signUp, jsonEncode(body));


    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      Get.offNamed(AppRoutes.singupOtpScreen,arguments: [
        {
          "email":emailController.value.text
        }
      ]);

      clearUserRegisterTextFields();
      refresh();
      userRegisterLoading.value = false;

    } else {

      userRegisterLoading.value = false;
      Toast.errorToast(response.body['message']);
      if (response.statusText == ApiClient.somethingWentWrong) {

         Toast.errorToast(response.body['message']);

        return;
      } else {

        ApiChecker.checkApi(response);
        userRegisterLoading.value = false;
        refresh();
        return;
      }
    }
  }


  ///=========== CLEAR USER REGISTER TEXT FIELDS =============
  clearUserRegisterTextFields() {
    fullNameController.value.clear();
    emailController.value.clear();
    passwordController.value.clear();
    confirmPasswordController.value.clear();

  }

  ///====================== forgot otp verification =====================


  RxBool otpLoading = false.obs;

  Future<void> otpValidation(String email,String otp) async {

    otpLoading.value = true;

    refresh();
    var body = {
      "email": email,
      "otp": otp,
    };
    var response = await ApiClient.postData(ApiUrl.forgot_otpVerify, jsonEncode(body));
    if (response.statusCode == 200) {
      otpLoading.value = false;
      refresh();

      SharePrefsHelper.setString(AppConstants.bearerToken, response.body["data"]["resetToken"]);
      Toast.successToast(response.body['message']);

      Get.toNamed(AppRoutes.forgotPassword,
          arguments: [
            {
              "email":email
            }
          ]
      );



    } else {

      Toast.errorToast(response.body['message']);
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(response.body['message']);
        otpLoading.value = false;
        refresh();
        return;

      } else {
        ApiChecker.checkApi(response);
        otpLoading.value = false;
        refresh();
        return;
      }
    }
  }


/// singup email resetOtp verification

  RxBool otpResetLoading = false.obs;

  Future<void> otpResetValidation(String email) async {

    otpResetLoading.value = true;

    var body = {
      "email": email,
    };

    var response = await ApiClient.postData(ApiUrl.resetOtp, jsonEncode(body));
    if (response.statusCode == 200) {
      otpResetLoading.value = false;
      refresh();

      Toast.successToast(response.body['message']);

    } else {

      Toast.errorToast(response.body['message']);
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(response.body['message']);
        otpResetLoading.value = false;
        refresh();
        return;

      } else {
        ApiChecker.checkApi(response);
        otpResetLoading.value = false;
        refresh();
        return;
      }
    }
  }


  /// Forgot Password  email resetOtp verification

  RxBool forgotPasswordOtpResetLoading = false.obs;

  Future<void> forgotOtpResetValidation(String email) async {

    forgotPasswordOtpResetLoading.value = true;

    var body = {
      "email": email,
    };

    var response = await ApiClient.postData(ApiUrl.forgetEmail, jsonEncode(body));
    if (response.statusCode == 200) {
      forgotPasswordOtpResetLoading.value = false;
      refresh();

      Toast.successToast(response.body['message']);

    } else {

      forgotPasswordOtpResetLoading.value = false;
      Toast.errorToast(response.body['message']);
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(response.body['message']);

        refresh();
        return;

      } else {
        ApiChecker.checkApi(response);
        forgotPasswordOtpResetLoading.value = false;
        refresh();
        return;
      }
    }
  }



  ///===================== verification email singUp  =====================

  RxBool verificationEmailLoading = false.obs;

  Future<void> verificationEmail(String email,String code) async {

    verificationEmailLoading.value = true;

    var body = {
      "email": email,
      "otp": code,
    };

    var response = await ApiClient.postData(ApiUrl.verify_email, jsonEncode(body));

    if (response.statusCode == 201) {

      verificationEmailLoading.value = false;
      refresh();

      Toast.successToast(response.body['message']);

      Get.offNamed(AppRoutes.loginScreen);

    } else {

      Toast.errorToast(response.body['message']);

      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(response.body['message']);
        verificationEmailLoading.value = false;

        refresh();
        return;

      } else {

        ApiChecker.checkApi(response);
        verificationEmailLoading.value = false;
        refresh();
        return;
      }
    }
  }



  ///====================FORGET PASSWORD CONTROLLER==================
  Rx<TextEditingController> forgetEmailController = TextEditingController().obs;
  ///================= FORGET PASSWORD METHOD================

  RxBool forgetPasswordLoading = false.obs;

  Future<void> forgetPassword() async {

    forgetPasswordLoading.value = true;
    refresh();
    var body = {"email": forgetEmailController.value.text};

    var response = await ApiClient.postData(ApiUrl.forgetEmail, jsonEncode(body));

    if (response.statusCode == 200) {

      forgetPasswordLoading.value = false;

      refresh();

      Toast.successToast(response.body['message']);



      Get.toNamed(AppRoutes.otpScreen,arguments: [
        {
          "email":forgetEmailController.value.text
        }
      ]);

    } else {

      Toast.errorToast(response.body['message']);
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(response.body['message']);

        forgetPasswordLoading.value = false;
        refresh();
        return;
      } else {
        ApiChecker.checkApi(response);
        forgetPasswordLoading.value = false;
        refresh();
        return;
      }
    }
  }

  ///====================RESET PASSWORD CONTROLLER==================

  Rx<TextEditingController> resetNewPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> resetConfirmPasswordController =
      TextEditingController().obs;

  ///================= RESET PASSWORD METHOD================
  RxBool resetPasswordLoading = false.obs;

  Future<void> restPassword() async {
    resetPasswordLoading.value = true;

    var body = {
      "newPassword": resetConfirmPasswordController.value.text,
    };

    var response =
    await ApiClient.patchData(ApiUrl.forgotPassword, jsonEncode(body));

    if (response.statusCode == 200) {
      resetPasswordLoading.value = false;
      refresh();

      Toast.successToast("password Reset SuccessFull..");

      SharePrefsHelper.remove(AppConstants.bearerToken);

      Get.offNamed(AppRoutes.loginScreen);

    } else {

      Toast.errorToast(response.body['message']);
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(response.body['message']);

        resetPasswordLoading.value = false;
        refresh();
        return;
      } else {
        ApiChecker.checkApi(response);
        resetPasswordLoading.value = false;
        refresh();
        return;
      }
    }
  }

  ///======================LOGIN CONTROLLER=====================

  Rx<TextEditingController> loginEmailController = TextEditingController(
    text: kDebugMode ? "tiwas92783@kissgy.com" : "",
  ).obs;

  Rx<TextEditingController> loginPasswordController = TextEditingController(
    text: kDebugMode ? "" : "",
  ).obs;


  ///=====================LOGIN METHOD=====================
  RxBool loginLoading = false.obs;

  Future<void> userLogin() async {

    loginLoading.value = true;

    FirebaseMessaging messaging = FirebaseMessaging.instance;


    ///Step 3: Get the FCM token
    String? token = await messaging.getToken();

    print('FCMDeviceToken: $token');

    refresh();

    var body = {
      "email": loginEmailController.value.text,
      "password": loginPasswordController.value.text,
      "token": token
    };

   try{
     var response = await ApiClient.postData(ApiUrl.login, jsonEncode(body));

     if (response.statusCode == 200) {

       loginLoading.value = false;
       refresh();

       SharePrefsHelper.setString(AppConstants.bearerToken, response.body["data"]["accessToken"]);

       SharePrefsHelper.setString(AppConstants.userId, response.body["data"]["_id"]);

       SharePrefsHelper.setString(AppConstants.userEmail, response.body["data"]["email"]);

       Toast.successToast(response.body['message']);

       Get.offNamed(AppRoutes.homeScreen);

     } else {

       loginLoading.value = false;
       refresh();
       Toast.errorToast(response.body['message']);

     }
   }catch(e){

     Toast.errorToast("${e}");
   }
  }


/*  ///  Get FCM Token
  Future<String> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Step 1: Request notification permission
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    String? token;

    // Step 2: Check if permission is granted
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ Permission granted.');

      ///Step 3: Get the FCM token
        token = await messaging.getToken();
      print('FCMDeviceToken: $token');

      // You can now send this token to your server or Firestone
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {

      Toast.errorToast('❌ Permission denied.');
    } else if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {

      Toast.errorToast('🤔 Permission not determined.');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {

      Toast.errorToast('🕓 Permission provisional (iOS).');
    }

    return token.toString();
  }*/


///===================== userLogOut =====================

  RxBool logOutLoading = false.obs;

  Future<void> userLogOut() async {

    logOutLoading.value = true;
    refresh();
    var body = {
      "": "",
    };

    var response = await ApiClient.postData(ApiUrl.logOut, jsonEncode(body));

    if (response.statusCode == 200) {

         logOutLoading.value = false;
         refresh();

          Toast.successToast(response.body['message']);
          SharePrefsHelper.remove(AppConstants.bearerToken);
          Get.offNamed(AppRoutes.loginScreen);

    } else {

      logOutLoading.value = false;
      refresh();
      Toast.errorToast(response.body['message']);

    }
  }


  ///=================================>> GoogleSignIn  <<===========================

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google Authentication
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User canceled the sign-in
      }

      // Obtain the authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;

    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  ///=================================>> GoogleSignIn api implementation <<===========================

  RxBool googleAuthLoading = false.obs;

  Future<void> googleSignInApi(String email,String fcmToken,String image,String fullName,String number,String provider) async {

    refresh();

    var body = {
      "email": email,
      "fcmToken": fcmToken,
      "provider": provider,
      "image": image,
      "fullName": fullName,
      "phoneNumber":number,
      "address":"",
    };

    var response = await ApiClient.postData(ApiUrl.socialAuth, jsonEncode(body));


    if (response.statusCode == 200) {

      googleAuthLoading.value = false;
      refresh();


      SharePrefsHelper.setString(
          AppConstants.bearerToken, response.body["data"]["accessToken"]);

      Toast.successToast(response.body['message']);

      Get.offNamed(AppRoutes.homeScreen);

    } else {

      Toast.errorToast(response.body['message']);

        googleAuthLoading.value = false;
        refresh();

    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
   // user.value = null;
  }
}