import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/features/privacyPolicy/privay_controller.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';


class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {

  final privayController = Get.put(PrivayController());

  @override
  void initState() {

    // TODO: implement initState
    privayController.showTermsCondition();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "Terms & Conditions",leftIcon: true,
        ),
        body:Obx(
                () {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      privayController.terms_conditionLoading.value?Center(child: CircularProgressIndicator(color: AppColors.brinkPink,)):
                      HtmlWidget('${privayController.terms_condition.value}',textStyle: TextStyle(color: Colors.black,))

                    ],
                  ),
                ),
              );
            }
        )

    );
  }

}
