import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/privacyPolicy/privay_controller.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';

class PrivacypolicyScreen extends StatefulWidget {
  const PrivacypolicyScreen({super.key});

  @override
  State<PrivacypolicyScreen> createState() => _PrivacypolicyScreenState();
}

class _PrivacypolicyScreenState extends State<PrivacypolicyScreen> {

  final privacyController = Get.put(PrivayController());


  @override
  void initState() {
    // TODO: implement initState

    privacyController.showPrivacyPolicyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "Privacy Policy",leftIcon: true,
        ),
       body:Obx(
        () {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

             privacyController.privacy_policyLoading.value?Center(child: CircularProgressIndicator(color: AppColors.brinkPink,)):
              HtmlWidget('${privacyController.privacy_policyList.value}',textStyle: TextStyle(color: Colors.black,))

            ],
          ),
        ),
      );
    }
    ),

    );
  }

}
