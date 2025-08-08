import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/components/custom_button/custom_button.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/splash/onboarding_controller.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_images/app_images.dart';
import 'package:prayer_app/core/utils/app_strings/app_strings.dart';

class OnboardingFourScreen extends StatelessWidget {
  OnboardingFourScreen({super.key});

  final onboardingController = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: '',),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

         Padding(
           padding: const EdgeInsets.only(top: 42),
           child: CustomImage(
               imageSrc: AppImages.appIcons,width: 140.w,height: 140.h,),
         ),

         SizedBox(
           height: 70.h,
         ),

         CustomText(
           text: "Alhumdulillah for everything",
           fontSize: 18.sp,
           fontWeight: FontWeight.w500,
           color: AppColors.black_03,
         ),


         SizedBox(
           height: 30.h,
         ),

         Padding(
           padding: const EdgeInsets.only(left: 12,right: 12),
           child: CustomButton(
             onTap: () {

               Get.offNamed(AppRoutes.loginScreen);
             },
             title:  'Sign In',
             fontSize: 16.sp, // Bigger button text for tablets
             width: double.infinity,
             height:60,
             fillColor: AppColors.brinkPink,
             // Wider button on tablets
           ),
         ),

            SizedBox(
              height: 8.h,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CustomText(
                  text: AppStrings.dontHaveAccount,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black_03,
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.signupScreen);
                  },
                  child: CustomText(
                    text: AppStrings.singUpText,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.brinkPink.withOpacity(0.8),
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppImages.splashImage,
                fit: BoxFit.fill,
                height: size.height/2,
                width: size.width,
              ),
            ),

          ],
        ),
      )

    );
  }
}