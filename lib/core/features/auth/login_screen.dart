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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer_app/core/utils/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool valuefirst = false;

  final authController = Get.put(AuthController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding:   EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        child: Obx((){

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 32),

              ///App Logo
              CustomImage(
                imageSrc: AppImages.appIcons,width: 130.w,height: 130.h,),

              const SizedBox(height: 24),

              CustomText(text: "Sign In to your Account",
                color: Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w400,
              ),

              const SizedBox(height: 4),

              CustomText(text: "Welcome back! Please enter your details",
                color: Colors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),

              const SizedBox(height: 32),


              CustomFormCard(
                prefixIcon: Icon(Icons.email_outlined),
                ///title: AppStrings.email,
                title: "",
                hintText: AppStrings.enterYourEmail,
                hasBackgroundColor: true,
                fontSize: 8,
                controller: authController.loginEmailController.value,
              ),

              CustomFormCard(
                prefixIcon: Icon(Icons.lock_outline),
                titleColor: Colors.black,
                //title: AppStrings.password,
                title:"",
                fontSize: 8,
                hintText: AppStrings.enterYourPassword,
                hasBackgroundColor: true,
                isPassword: true,
                controller: authController.loginPasswordController.value,

              ),

              SizedBox(
                height: 12,
              ),

              ///Terms Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  ///Remember Me Checkbox
                  Row(
                    children: [

                      Checkbox(
                        value: valuefirst,
                        checkColor: AppColors.white,
                        activeColor: AppColors.brinkPink,
                        onChanged: (bool? newValue) {
                          setState(() {
                            valuefirst = newValue!;
                          });
                        },
                      ),
                      CustomText(
                        text: "Remember me",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_03,
                      ),
                    ],
                  ),

                  /// Forgot Password
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.verificationMailScreen);
                    },
                    child: CustomText(
                      text: AppStrings.forgotPassword,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.brinkPink,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Sign In Button
              authController.loginLoading.value?CircularProgressIndicator(color: AppColors.brinkPink,):
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                  onPressed: () {

                    if(authController.loginEmailController.value.text==""){
                      Toast.errorToast("email cannot be empty!");
                    }else if(authController.loginEmailController.value.text==""){
                      Toast.errorToast("password cannot be empty!");
                    }else{

                      authController.userLogin();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brinkPink,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: CustomText(text: "Sign In",color: AppColors.white,fontSize: 14.sp,fontWeight: FontWeight.w800,),
                ),
              ),

              const SizedBox(height: 16),

              // Or Divider
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:  [
                    SizedBox(
                        width: 150.w,
                        child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Or'),
                    ),
                    SizedBox(
                        width: 150.w,
                        child: Divider(thickness: 1)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Social Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [

              /*    Container(
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

                  GestureDetector(
                    onTap: () async{

                      final user = await authController.signInWithGoogle();

                      if (user != null) {

                        authController.googleAuthLoading.value
                            ? CircularProgressIndicator()
                            :  authController.googleSignInApi(user.email.toString(), user.uid, user.photoURL.toString(), user.displayName.toString(), user.phoneNumber.toString(),"GOOGLE");

                      } else {

                        Toast.errorToast("Google sign-in failed");
                      }
                    },
                    child: Container(
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

                  Get.toNamed(AppRoutes.signupScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:   [

                    Text("Don't have an account? "),
                    Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.brinkPink),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}


