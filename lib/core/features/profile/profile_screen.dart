import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayer_app/core/components/custom_from_card/custom_from_card.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/profile/profile_controller.dart';
import 'package:prayer_app/core/service/api_url.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/toast.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "Profile",leftIcon: true,),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Obx(
              () {
              return Column(
                children: [
                  // Profile Picture Section


                  (profileController.chooseUserImage.value=="" && profileController.userProfileShow.value.image!=null)?
                 Stack(
                    children: [
                      Container(
                        height: 150.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          border: Border.all(
                            width: 1,
                            color: AppColors.primary,
                          ),
                          image: DecorationImage(
                            image: NetworkImage("${ApiUrl.imageUrl}/${profileController.userProfileShow.value.image ?? ""}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(

                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon:  Icon(
                              Icons.camera_alt,
                              color: Colors.orange,

                            ),
                            onPressed: () {
                              profileController.chooseUserPhoto();

                            },
                          ),
                        ),
                      ),
                    ],
                  ):  Stack(
                    children: [
                      /*CircleAvatar(
                        radius: 80.r,
                        backgroundImage: AssetImage('assets/icons/profile_image2.png'), // Replace with actual profile image path
                      ),*/
                      Container(
                        height: 150.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          border: Border.all(
                            width: 1,
                            color: AppColors.primary,
                          ),
                          image: DecorationImage(
                            image: FileImage(File(profileController.chooseUserImage.value)),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(

                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 3,
                              ),
                            ],

                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.orange,
                              size: 24,
                            ),
                            onPressed: () {
                              // Handle the image change logic
                              profileController.chooseUserPhoto();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h,),
                  // Location Info
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     CustomText(text: profileController.fullNameController.value.text,fontSize: 18.sp, fontWeight: FontWeight.w400),
                     SizedBox(
                       height: 4.h,
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Icon(Icons.location_on, color: Colors.grey.shade700),
                         SizedBox(width: 4),
                         Flexible(
                           child: CustomText(text: profileController.currentAddress.value,fontSize: 14, fontWeight: FontWeight.w400,
                            maxLines: 3,
                           ),
                         )
                       ],
                     ),

                    ],
                  ),
                  SizedBox(height: 16.h),

                  // User Name
                  CustomFormCard(
                    prefixIcon: Icon(Icons.person),
                    title: "Full Name",
                    titleColor: AppColors.black_04,
                    hintText: "Full Name",
                    hasBackgroundColor: true,
                    controller: profileController.fullNameController.value,
                  ),

                /*  SizedBox(height: 16.h),

                  // Password
                  CustomFormCard(
                    prefixIcon: Icon(Icons.lock_outline),
                    titleColor: AppColors.black_04,
                    title: "Password",
                    hintText: "Password",
                    hasBackgroundColor: true,
                    isPassword: true,
                    controller: passwordController,
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
                    controller: confirmPasswordController,
                  ),

                  */
                  SizedBox(height: 16.h),

                  ///Sign In Button

                  profileController.userInfoUpdateShowLoading.value?Center(child: CircularProgressIndicator(color: Colors.amber,)):
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {

                        if(profileController.fullNameController.value.text==""){

                          Toast.errorToast("User name is empty!!");

                        }else if(profileController.chooseUserImage.value==""){

                          Toast.errorToast("User image is empty!!");

                        }else{
                          profileController.profileUpdate();
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
