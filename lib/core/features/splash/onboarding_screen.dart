import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/components/custom_button/custom_button.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/splash/model/unbording_model.dart';
import 'package:prayer_app/core/features/splash/onboarding_controller.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_strings/app_strings.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final onboardingController = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600; // Detect if it's a tablet

          return Obx(
                  () {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: (){
                                Get.toNamed(AppRoutes.loginScreen);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                  text: AppStrings.skip,
                                  fontSize: 16.sp, // Bigger text for tablets
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.grey_1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),

                          CustomText(
                            text: contents[onboardingController.currentIndex.value].title,
                            fontSize:32.sp, // Bigger text for tablets
                            fontWeight: FontWeight.w400,
                            color: AppColors.black_80,
                            textAlign: TextAlign.center,
                            language: true,
                            bottom: 8,
                          ),

                          CustomText(
                            text: contents[onboardingController.currentIndex.value].details,
                            fontSize:14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey_1,
                            language: true,
                            textAlign: TextAlign.center,
                            maxLines: contents[onboardingController.currentIndex.value].details.length,
                          ),

                        ],
                      ),

                      CustomImage(
                        imageSrc: contents[onboardingController.currentIndex.value].image,
                        fit:BoxFit.fill,
                         width: 350.w,
                      ),

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,(index) => buildDot(index, context),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 12.h,
                      ),
                      CustomButton(
                        onTap: () {

                          if(onboardingController.currentIndex.value<2){
                            onboardingController.currentIndex.value = onboardingController.currentIndex.value+1;
                          }else{
                            Get.offNamed(AppRoutes.onboardingFourScreen);
                          }
                        },
                        title: onboardingController.currentIndex.value >= 2
                            ? 'Continue'
                            : AppStrings.next,
                        fontSize: 16.sp, // Bigger button text for tablets
                        width: double.infinity,
                        height: isTablet?70:60,
                        fillColor: AppColors.brinkPink,
                        // Wider button on tablets
                      )
                    ],
                  ),
                );
              }
          );
        },
      ),
    );
  }

  buildDot(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Container(
        height: 12,
        width: onboardingController.currentIndex.value == index ?12 : 12,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: onboardingController.currentIndex.value== index ? AppColors.brinkPink : AppColors.grey_1,

        ),
      ),
    );
  }
}
