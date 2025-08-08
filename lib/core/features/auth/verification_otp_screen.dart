
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/components/custom_button/custom_button.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/auth/auth_controller.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_images/app_images.dart';
import 'package:prayer_app/core/utils/app_strings/app_strings.dart';



class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  String? email;

  final authController = Get.put(AuthController());

  final newTextEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.arguments[0]["email"]!=null){

      email = Get.arguments[0]["email"];
    }


  }

  @override
  void dispose() {
    newTextEditingController.dispose();

    super.dispose();
  }


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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Obx((){
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height/1.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Column(
                      children: [

                        CustomText(
                          top: 40.h,
                          text: AppStrings.enterCode,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          bottom: 20.h,
                        ),
                        CustomText(
                          text: AppStrings.enterTheCodeTitle,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          maxLines: 2,
                          bottom: 30.h,
                          color: AppColors.black,
                        ),

                        ///CustomPinCode(controller: authController.otpController.value),

                        Padding(
                          padding:   EdgeInsets.only(left: 8, right: 8),
                          child: PinCodeTextField(
                            textStyle: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            appContext: context,
                            length: 6,
                            enableActiveFill: true,
                            animationType: AnimationType.fade,
                            animationDuration: Duration(milliseconds: 300),
                            controller: newTextEditingController,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(16),
                              fieldHeight: 55,
                              fieldWidth: 45.0,
                              inactiveColor: AppColors.grey_1,
                              activeColor: AppColors.grey_1,
                              activeFillColor: AppColors.grey_1,
                              inactiveFillColor: AppColors.grey_1,
                              selectedFillColor: AppColors.grey_1,
                              disabledColor: AppColors.grey_1,
                              selectedColor: AppColors.grey_1,
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            CustomText(
                              text: AppStrings.ididntFind,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black_04,
                              right: 10,
                            ),

                            authController.forgotPasswordOtpResetLoading.value?CircularProgressIndicator(color: AppColors.brinkPink,):
                            GestureDetector(
                              onTap: (){
                                authController.forgotOtpResetValidation(email.toString());
                              },
                              child: CustomText(
                                text: AppStrings.sendAgain,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: AppColors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),


                    ///============ otpValidation Button ============
                    authController.otpLoading.value?CircularProgressIndicator(color: AppColors.brinkPink,):
                    CustomButton(
                      onTap: () {

                        authController.otpValidation(email.toString(),newTextEditingController.text.toString());
                      },
                      title: AppStrings.sendCode,
                      height:60.h,
                      fontSize: 14.sp,
                      fillColor: AppColors.brinkPink,
                    ),
                  ],
                ),
              ),
            );
          })
        ),
      );
    });

  }
}

