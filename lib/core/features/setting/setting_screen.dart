import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/components/custom_button/custom_button.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/auth/auth_controller.dart';
import 'package:prayer_app/core/features/profile/profile_controller.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_icons/app_icons.dart';
import 'package:toggle_switch/toggle_switch.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  // Toggle values for Adhan sounds
  bool makkahAdhan = false;
  bool madinaAdhan = true;
  bool autoLocation = false;

  final authController = Get.put(AuthController());

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "Setting",leftIcon: true,),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
           () {
              return Column(
                children: [
                  // Profile Section
                  Card(
                    elevation: 1,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text:
                                "${profileController.userProfileShow.value.fullName}",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),

                              CustomText(text:
                                profileController.userProfileShow.value.email.toString(),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios_rounded),
                            onPressed: () {
                              // Handle editing the profile
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  ///Adan Sounds Section
                  Container(
                    height: 200.h,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: AppColors.brinkPink1,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: CustomText(text: "Adhan Sounds",  fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,),
                        ),

                        SizedBox(height: 8.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text("Makkah Adhan",style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
                            ToggleSwitch(
                              minWidth: 40,
                              cornerRadius: 20.0,
                              activeBgColors: [[AppColors.brinkPink], [AppColors.primary]],
                              activeFgColor: AppColors.white_50,
                              inactiveBgColor: AppColors.white_50,
                              inactiveFgColor: Colors.black,
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              fontSize: 8,
                              labels: ['On', 'OFF'],
                              radiusStyle: true,
                              onToggle: (index) {
                                print('switched to: $index');
                              },
                              customTextStyles: [
                                TextStyle(fontWeight: FontWeight.bold),  // Apply fontWeight to 'On'
                                TextStyle(fontWeight: FontWeight.bold),
                              ],
                            )
                          ],
                        ),

                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Madina Adhan",style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
                            ToggleSwitch(
                              minWidth: 40,
                              cornerRadius: 20.0,
                              activeBgColors: [[AppColors.brinkPink], [AppColors.primary]],
                              activeFgColor: AppColors.white_50,
                              inactiveBgColor: AppColors.white_50,
                              inactiveFgColor: Colors.black,
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              fontSize: 8,
                              radiusStyle: true,
                              onToggle: (index) {
                                print('switched to: $index');
                              },
                              // Customizing labels manually to apply font weight
                              labels: [
                                'On',
                                'OFF',
                              ],
                              customTextStyles: [
                                TextStyle(fontWeight: FontWeight.bold),  // Apply fontWeight to 'On'
                                TextStyle(fontWeight: FontWeight.bold),
                              ],
                            )

                          ],
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: 8.h),

             ///=== Settings Options ======
                  Card(
                    color: Colors.white,
                    elevation: 0.5,
                    child: ListTile(
                      title: Text("Language", style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_03,
                      )),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to language selection screen
                      },
                    ),
                  ),

                 /* Card(
                    color: Colors.white,
                    elevation: 0.5,
                    child: ListTile(
                      title: Text("Auto-Location",style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_03,
                      )),
                      trailing:  ToggleSwitch(
                        minWidth: 45,
                        cornerRadius: 20.0,
                        activeBgColors: [[AppColors.brinkPink], [AppColors.primary]],
                        activeFgColor: AppColors.white_50,
                        inactiveBgColor: AppColors.white_50,
                        inactiveFgColor: Colors.black,
                        initialLabelIndex: 1,
                        totalSwitches: 2,
                        fontSize: 8,
                        labels: ['On', 'OFF'],
                        radiusStyle: true,
                        onToggle: (index) {
                          print('switched to: $index');
                        },
                        customTextStyles: [
                          TextStyle(fontWeight: FontWeight.bold),  // Apply fontWeight to 'On'
                          TextStyle(fontWeight: FontWeight.bold),
                        ],
                      ),
                    ),
                  ),*/

                  /// change password
                  Card(
                    color: Colors.white,
                    elevation: 0.5,
                    child: ListTile(
                      title: Text("Change Password",style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_03,
                      )),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {

                        Get.toNamed(AppRoutes.changePasswordScreen);

                      },
                    ),
                  ),

                /*  Card(
                    color: Colors.white,
                    elevation: 0.5,
                    child: ListTile(
                      title: Text("Preferences",style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_03,
                      )),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to preferences screen

                      },
                    ),
                  ),*/

                  Card(
                    color: Colors.white,
                    elevation: 0.5,
                    child: ListTile(
                      title: Text("Privacy Policy",style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_03,
                      )),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to privacy policy screen
                        Get.toNamed(AppRoutes.privacypolicyScreen);
                      },
                    ),
                  ),

                  Card(
                    color: Colors.white,
                    elevation: 0.5,
                    child: ListTile(
                      title: Text("Terms & Conditions",style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_03,
                      )),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to terms and conditions screen
                        Get.toNamed(AppRoutes.termsConditionsScreen);
                      },
                    ),
                  ),


                  // Logout Button
                  SizedBox(height: 20.h), // Add spacing before the button

                  ///Sign In Button
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: ElevatedButton(
                      onPressed: () {


                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: Colors.white,
                            insetPadding: EdgeInsets.all(8),
                            contentPadding: EdgeInsets.all(8),
                            title: SizedBox(),
                            content: SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.question_mark),

                                    CustomText(
                                      text: "Are You Sure?",
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black_80,
                                    ),

                                    CustomText(
                                      text: "Do you want to log out ?",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black_80,
                                    ),

                                    ///AppColors.brinkPink
                                    SizedBox(
                                      height: 8.h,
                                    ),

                                    CustomButton(
                                        onTap: () {
                                          Navigator.of(context).pop();

                                          authController.userLogOut();
                                        },
                                        title: "Yes",
                                        height: 45.h,
                                        fontSize: 12.sp,
                                        fillColor: AppColors.brinkPink),

                                    SizedBox(
                                      height: 12.h,
                                    ),

                                    CustomButton(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      title: "NO",
                                      height: 45.h,
                                      fontSize: 12.sp,
                                      fillColor: AppColors.white,
                                      textColor: AppColors.brinkPink,
                                      isBorder: true,
                                      borderWidth: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brinkPink,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          CustomImage(imageSrc: AppIcons.logout),
                          SizedBox(
                            width: 8.w,
                          ),
                          CustomText(text: "LogOut",color: AppColors.white,fontSize: 14.sp,fontWeight: FontWeight.bold,)
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      )
    );
  }
}
