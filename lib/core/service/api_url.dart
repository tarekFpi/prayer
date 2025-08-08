class ApiUrl {

 /// static const String baseUrl = "http://10.0.60.55:5001/v1";

  static const String baseUrl = "http://10.10.10.90:5000";

  static const String imageUrl = "http://10.10.10.90:5000";


///========================= Authentication =========================

  static const String login = "/api/auth/signin";

  static const String logOut = "/api/auth/signout";

  static const String forgotPassword = "/api/auth/reset-password";

  ///Forgot Password OTP Verify
  static const String forgot_otpVerify = "/api/auth/forget-password-verify";

  /// Resend email verification code singUp
  static const String resetOtp = "/api/auth/resend";

  /// Forgot Password email verification code singUp
  static const String forgetEmail = "/api/auth/forget-password";

  static const String forgotCreateNewPassword = "/auth/reset-password";
  static const String signUp = "/api/auth/signup";
  static const String register = "/user/create";
  static const String createNewPassword = "/auth/change-password";

  static const String aboutUS = "/about-us/retrive";

  static const String privacyPolicy = "/api/terms";

  static const String termsCondition = "/api/policy";

/// Verify user email singUp
   static const String verify_email = "/api/auth/verify-signup-otp";

/// socialAuth
  static const String socialAuth = "/api/auth/social-signin";

  ///============= Profile Apis ===============
  static String getUserProfile({required String userId}) => "/user/$userId";
  static String getReviewMode({required String userId}) => "/review-mode/user/intervals/$userId";
  static String friendSearch({required String cetagory, required String query}) => "/user/search?$cetagory=$query";


  ///=========================== Get Hadiths for Today api  ===========================
  static String todayHadith = "/api/hadith/today";


  ///=========================== Get Activity By Date api  ===========================
  static String activitiesWaterCalories ({required String date}) =>"/api/activities/history?date=$date";


  ///=========================== Get Prayer Times api  ===========================

  static String prayersTime ({required String date}) =>"/api/prayers?date=$date";


  ///=========================== Update water Activity api  ===========================
  static String addWater ="/api/activities";

/// Update Prayer
  static String prayersTimeUpdate ="/api/prayers";

  ///  Create Journal
  static String journalCreate ="/api/journal";


  ///=========================== Get All Journals  ===========================
  static String getJournals ="/api/journal";

  /// or date
  static String getDateByJournals ({required String date}) =>"/api/journal?date=$date";

  /// Update Journal
  static String updateJournals ({required String updateId}) =>"/api/journal/$updateId";

 /// Delete Tracker
  static String deleteJournals ({required String deleteId}) =>"/api/journal/$deleteId";


  ///Change profile picture
  static String chageProfile ({required String userId}) =>"/user/update/profile-picture/$userId";

  ///get user profile show
  static String userProfileShow ="/api/auth/me";

  ///user profile  update
  static String updateProfile ="/api/auth/update-profile";

  ///user change Password
  static String changePassword ="/api/auth/change-password";

  /// Get All Trackers
  static String getMoodTracker ="/api/user-moods";

  /// saveTrackers mood
  static String saveMoodTracker ="/api/user-moods";

  /// trackers mood by search
  static String moodByDateTracker({required String date})=>"/api/user-moods?date=$date";

  /// Get Activity History By Date Range

  static String fitnessDailyWeekMonth ({required String fromDate,required String endDate}) =>"/api/activities/history-by-date?from=$fromDate&end=$endDate";

  /// week report
  static String fitnessWeek ({required bool status}) =>"/api/activities/history-by-date?week=$status";

  /// step count value api
  static String stepUpdate ="/api/activities";
}