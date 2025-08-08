// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/splash/model/unbording_model.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_images/app_images.dart';
import 'package:prayer_app/core/utils/app_const/app_const.dart';
import 'package:prayer_app/core/helper/shared_prefe/shared_prefe.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      Future.delayed(const Duration(seconds: 3), () async{

        var token = await SharePrefsHelper.getString(AppConstants.bearerToken);

        if(token.isNotEmpty){

          Get.offAllNamed(AppRoutes.homeScreen);

        }else{

         Get.offAllNamed(AppRoutes.onboardingScreen);
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body:ListView(
        children: [
          Column(
            //clipBehavior: Clip.none,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text("",),

              Align(
                alignment: Alignment.center,
                child: CustomImage(
                    imageSrc: AppImages.appIcons),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  AppImages.splashImage,
                  fit: BoxFit.fill,
                  height: size.height/1,
                  width: size.width,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
