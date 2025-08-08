import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/components/custom_from_card/custom_from_card.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/auth/auth_controller.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_icons/app_icons.dart';
import 'package:prayer_app/core/utils/app_images/app_images.dart';
import 'package:prayer_app/core/utils/app_strings/app_strings.dart';
import 'package:prayer_app/core/utils/toast.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {


  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Obx(
            () {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),

                  CustomImage(imageSrc: AppImages.appIcons,width: 130.w,height: 130.h,),


                  const SizedBox(height: 32),

                    Text(
                    'Sign Up to your Account',
                    style: GoogleFonts.gloock(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                    Text(
                    'Welcome back! Please enter your details',
                    style: GoogleFonts.gloock(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 32),


                  CustomFormCard(
                    prefixIcon: Icon(Icons.person),
                    title: "",
                    hintText: AppStrings.enterYourName,
                    hasBackgroundColor: true,
                    controller: authController.fullNameController.value,
                  ),


                  CustomFormCard(
                    prefixIcon: Icon(Icons.email_outlined),
                    title: "",
                    hintText: AppStrings.enterYourEmail,
                    hasBackgroundColor: true,
                    controller: authController.emailController.value,
                  ),

                  CustomFormCard(
                    prefixIcon: Icon(Icons.lock_outline),
                    titleColor: Colors.black,
                    title: "",
                    hintText: AppStrings.enterYourPassword,
                    hasBackgroundColor: true,
                    isPassword: true,
                    controller:authController.passwordController.value,
                  ),

                  CustomFormCard(
                    prefixIcon: Icon(Icons.lock_outline),
                    titleColor: Colors.black,
                    title: "",
                    hintText: AppStrings.enterYourPassword,
                    hasBackgroundColor: true,
                    isPassword: true,
                    controller:authController.confirmPasswordController.value,
                  ),

                  ///terms Checkbox
                  Row(
                    children: [
                      Checkbox(
                          checkColor: AppColors.white,
                          activeColor: AppColors.brinkPink,
                          value: authController.agreeStatus.value, onChanged: (newValue) {

                           authController.agreeStatus.value = newValue!;
                         }),

                        Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'Agree with ',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms and Conditions',
                               // style: TextStyle(fontWeight: FontWeight.bold),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 12.sp
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Sign In Button
                 authController.userRegisterLoading.value?CircularProgressIndicator(color: AppColors.primary,):
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {

                        if(authController.fullNameController.value.text==""){

                          Toast.errorToast("full name cannot be empty!");

                        }else if(authController.emailController.value.text==""){

                          Toast.errorToast("email cannot be empty!");

                        }else if(authController.passwordController.value.text==""){

                          Toast.errorToast("password cannot be empty!");

                        }else if(authController.confirmPasswordController.value.text==""){

                          Toast.errorToast("confirm password cannot be empty!");

                        }else if(authController.agreeStatus.value==false){

                          Toast.errorToast("Agree with Terms and Conditions?");
                        }else{

                          authController.userRegister();


                        }


                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brinkPink,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text('Sign Up', style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                        decorationColor: Colors.grey,
                      )
                      ),),
                    ),


                  const SizedBox(height: 16),

                  // Or Divider
                  Row(
                    children: const [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Or'),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Social Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [

               /*       Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Color(0xFF1877F2), // Facebook Blue Color
                          radius: 20,
                          child: Icon(
                            Icons.facebook,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),*/

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            radius: 20,
                            child: CustomImage(imageSrc: AppIcons.google_icon,width: 24,height: 24,)

                        ),
                      ),

                      SizedBox(
                        width: 28.w,
                      ),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 20,
                          child: Icon(
                            Icons.apple,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                      //  SocialIconButton(icon: Icons.apple),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Signup Link
                  GestureDetector(
                    onTap: (){

                       Get.offNamed(AppRoutes.loginScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        Text(
                          " Sign In",
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.brinkPink,
                              decorationColor: Colors.grey,
                            )
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 8.h,
                  ),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: 'By signing up, you agree to our?',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          text: ' Terms of Service ',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.brinkPink,
                              decorationColor: Colors.grey,
                            )
                        ),

                        TextSpan(
                          text: 'Privacy Policy',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.brinkPink,
                              decorationColor: Colors.grey,
                            )
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
