// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:prayer_app/core/features/auth/singup/singup_otp_screen.dart';
import 'package:prayer_app/core/features/auth/verification_mail_screen.dart';
import 'package:prayer_app/core/features/auth/forgot_password.dart';
import 'package:prayer_app/core/features/auth/login_screen.dart';
import 'package:prayer_app/core/features/auth/singup/signup_screen.dart';
import 'package:prayer_app/core/features/auth/verification_otp_screen.dart';
import 'package:prayer_app/core/features/home/home_screen.dart';
import 'package:prayer_app/core/features/prayers/Prayers_log_screen.dart';
import 'package:prayer_app/core/features/privacyPolicy/about_us_screen.dart';
import 'package:prayer_app/core/features/privacyPolicy/privacyPolicy_screen.dart';
import 'package:prayer_app/core/features/privacyPolicy/terms_conditions_screen.dart';
import 'package:prayer_app/core/features/profile/change_passwod_screen.dart';
import 'package:prayer_app/core/features/profile/profile_screen.dart';
import 'package:prayer_app/core/features/setting/setting_screen.dart';
import 'package:prayer_app/core/features/splash/onboardingFourScreen.dart';
import 'package:prayer_app/core/features/splash/onboarding_screen.dart';
import 'package:prayer_app/core/features/splash/splash_screen.dart';
import 'package:prayer_app/core/features/tracker_mood/tracker_mode_screen.dart';
import 'package:prayer_app/core/features/water/water_add_screen.dart';
import 'package:prayer_app/core/features/water/water_history_screen.dart';
import 'package:prayer_app/core/features/water/water_screen.dart';


///=========================App Routes=========================
class AppRoutes {
  static const String splashScreen = "/SplashScreen";
  static const String onboardingScreen = "/OnboardingScreen";
  static const String loginScreen = "/LoginScreen";
  static const String locationMapScreen = "/LocationMapScreen";
  static const String otpScreen = "/OtpScreen";
  static const String verificationMailScreen = "/VerificationMailScreen";
  static const String signupScreen = "/SignupScreen";
  static const String homeScreen = "/HomeScreen";
  static const String prayersLogScreen = "/PrayersLogScreen";
  static const String profileScreen = "/ProfileScreen";
  static const String settingScreen = "/SettingScreen";
  static const String forgotPassword = "/ForgotPassword";
  static const String trackerModeScreen = "/TrackerModeScreen";
  static const String waterScreen = "/WaterScreen";
  static const String privacypolicyScreen = "/PrivacypolicyScreen";
  static const String termsConditionsScreen = "/TermsConditionsScreen";
  static const String aboutUSScreen = "/AboutUSScreen";
  static const String waterAddScreen = "/WaterAddScreen";
  static const String waterHistoryScreen = "/WaterHistoryScreen";
  static const String onboardingFourScreen = "/OnboardingFourScreen";
  static const String singupOtpScreen = "/SingupOtpScreen";
  static const String changePasswordScreen = "/ChangePasswordScreen";


  static List<GetPage> routes = [

    ///===========================Authentication==========================

   GetPage(name: splashScreen, page: () => SplashScreen()),
   GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
   GetPage(name: onboardingFourScreen, page: () => OnboardingFourScreen()),
   GetPage(name: loginScreen, page: () => LoginScreen()),
   GetPage(name: signupScreen, page: () => SignupScreen()),
   GetPage(name: homeScreen, page: () => HomeScreen()),
   GetPage(name: prayersLogScreen, page: () => PrayersLogScreen()),
   GetPage(name: profileScreen, page: () => ProfileScreen()),
   GetPage(name: settingScreen, page: () => SettingScreen()),
   GetPage(name: otpScreen, page: () => OtpScreen()),
   GetPage(name: verificationMailScreen, page: () => VerificationMailScreen()),
   GetPage(name: forgotPassword, page: () => ForgotPassword()),
   GetPage(name: trackerModeScreen, page: () => TrackerModeScreen()),
   GetPage(name: waterScreen, page: () => WaterScreen()),

   GetPage(name: privacypolicyScreen, page: () => PrivacypolicyScreen()),
   GetPage(name: termsConditionsScreen, page: () => TermsConditionsScreen()),
   GetPage(name: aboutUSScreen, page: () => AboutUSScreen()),
   GetPage(name: waterAddScreen, page: () => WaterAddScreen()),
   GetPage(name: waterHistoryScreen, page: () => WaterHistoryScreen()),
   GetPage(name: singupOtpScreen, page: () => SingupOtpScreen()),

   GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),

  ];

}
