
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/components/custom_button/custom_button.dart';
import 'package:prayer_app/core/components/custom_from_card/custom_from_card.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/auth/auth_controller.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_images/app_images.dart';
import 'package:prayer_app/core/utils/app_strings/app_strings.dart';
import 'package:prayer_app/core/utils/toast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  String? email;

  final authController = Get.put(AuthController());



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: SingleChildScrollView(
            child: Obx(
               () {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top section with text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // App Logo
                        CustomImage(
                          imageSrc: AppImages.appIcons,width: 70.w,height: 70.h,),

                        SizedBox(
                          height: 24.h,
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            text: "Set a New Password",
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            bottom: 20.h,
                          ),
                        ),

                        CustomText(text: "Create a new password. Ensure it differs from previous ones for security.",fontSize: 12.sp,
                          maxLines: 2,textAlign: TextAlign.start,)
                      ],
                    ),

                    SizedBox(height: 48), // Add spacing if needed

                    // Middle section with form fields
                    Column(
                      children: [

                        CustomFormCard(
                          prefixIcon: Icon(Icons.lock_outline),
                          titleColor: Colors.black,
                          //title: AppStrings.password,
                          title:"",
                          hintText: "Password",
                          hasBackgroundColor: true,
                          isPassword: true,
                          controller: authController.resetNewPasswordController.value,
                        ),

                        CustomFormCard(
                          prefixIcon: Icon(Icons.lock_outline),
                          titleColor: Colors.black,
                          //title: AppStrings.password,
                          title:"",
                          hintText: "Confirm Password",
                          hasBackgroundColor: true,
                          isPassword: true,
                          controller: authController.resetConfirmPasswordController.value,
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Add spacing if needed

                    ///Bottom section with button
                    authController.resetPasswordLoading.value?CircularProgressIndicator(color: AppColors.brinkPink,):
                    CustomButton(
                      onTap: () {

                        if(authController.resetNewPasswordController.value.text==""){

                          Toast.errorToast("New password is Empty..!!");
                        }else if(authController.resetConfirmPasswordController.value.text==""){

                          Toast.errorToast("Confirm password is Empty..!!");

                        }else if(authController.resetNewPasswordController.value.text!=authController.resetConfirmPasswordController.value.text){

                          Toast.errorToast("Password & Confirm Password do not match!");
                        }else{

                          authController.restPassword();
                        }

                      },
                      title: AppStrings.updatePasswordText,
                      height: 60.h,
                      fontSize: isTablet ? 10.sp : 14.sp,
                    fillColor: AppColors.brinkPink,
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      );
    });

  }
}

