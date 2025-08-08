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

class VerificationMailScreen extends StatelessWidget {
  VerificationMailScreen({super.key});

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(

        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Column(
            children: [

              CustomImage(
                imageSrc: AppImages.appIcons,width: 70.w,height: 70.h,),
            ],
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_rounded, color: AppColors.black,size: isTablet?28.w:32.w
                  ,),
              );
            },
          ),
        ),

        body: SingleChildScrollView(
          child: Obx(
                  () {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Column(
                        children: [
                          CustomText(
                            top: 80.h,
                            text: AppStrings.emailConfirmation,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            bottom: 20.h,
                          ),
                          CustomText(
                            text: AppStrings.enterYourEmailForVerification,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            maxLines: 2,
                            bottom: 32.h,
                            color: AppColors.black,
                          ),

                          ///============ Email ============ forgetEmailController
                          CustomFormCard(
                            title: AppStrings.email,
                            // hasBackgroundColor: true,
                            titleColor: Colors.black,
                            fontSize: isTablet?16:16,
                            hintText: AppStrings.enterYourEmail,
                            controller:authController.forgetEmailController.value,

                          ),

                          SizedBox(
                            height: 12,
                          ),

                          ///============ sendVerificationCode  Button ============

                          authController.forgetPasswordLoading.value?CircularProgressIndicator(color: AppColors.brinkPink,):
                          CustomButton(
                            onTap: () {

                             // Get.toNamed(AppRoutes.otpScreen);

                              if(authController.forgetEmailController.value==""){
                                Toast.errorToast("email cannot be empty!");
                              }else{
                                authController.forgetPassword();
                              }

                            },
                            title: AppStrings.sendVerificationCode,
                            height: 60.h,
                            fontSize: 14.sp,
                            fillColor: AppColors.brinkPink,
                          ),
                        ],
                      ),


                    ],
                  ),
                );
              }
          ),
        ),
      );
    });
  }
}