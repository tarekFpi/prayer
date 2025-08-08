 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:prayer_app/core/components/custom_from_card/custom_from_card.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/features/profile/profile_controller.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/toast.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "Change password",leftIcon: true,),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Obx(
                  () {
                return Column(
                  children: [
                    // Profile Picture Section

                    SizedBox(height: 16.h,),

                  /// old  Password
                  CustomFormCard(
                    prefixIcon: Icon(Icons.lock_outline),
                    titleColor: AppColors.black_04,
                    title: "Password",
                    hintText: "Password",
                    hasBackgroundColor: true,
                    isPassword: true,
                    controller: profileController.passwordController.value,
                  ),

                  SizedBox(height: 16.h),

                  // Confirm Password
                  CustomFormCard(
                    prefixIcon: Icon(Icons.lock_outline),
                    titleColor: AppColors.black_04,
                    title: "Confirm Password",
                    hintText: "Confirm Password",
                    hasBackgroundColor: true,
                    isPassword: true,
                    controller: profileController.confirmPasswordController.value,
                  ),


                    SizedBox(height: 24.h),

                    ///===new- password ====

                   // profileController.changePasswordLoading.value?Center(child: CircularProgressIndicator(color: Colors.amber,)):
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {

                          if(profileController.passwordController.value.text==""){

                            Toast.errorToast("old password is empty!!");

                          }else if(profileController.confirmPasswordController.value.text==""){

                            Toast.errorToast("new password is empty!!");

                          }else{
                            profileController.changePassword();
                          }

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brinkPink,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Update',style: TextStyle(color: AppColors.white),),
                      ),
                    ),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}
