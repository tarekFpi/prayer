
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/home/home_controller.dart';
import 'package:prayer_app/core/features/prayers/prayers_controller.dart';
import 'package:prayer_app/core/helper/time_converter/time_converter.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_icons/app_icons.dart';



class PrayersLogScreen extends StatefulWidget {
  const PrayersLogScreen({super.key});

  @override
  State<PrayersLogScreen> createState() => _PrayersLogScreenState();
}

class _PrayersLogScreenState extends State<PrayersLogScreen> {

  DateTime selectedDate = DateTime(2025, 1, 1);

  int Prayers_count=0;

  int missed_count=0;

  final homeController = Get.put(HomeController());

  final prayerController = Get.put(PrayersController());

  final prayersIcon = [
    AppIcons.fajr,
    AppIcons.dhuhr,
    AppIcons.asr,
    AppIcons.maghrib,
    AppIcons.isha,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "Prayers Log",leftIcon: true,),

      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Obx(
           () {

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // View Prayers Log Button
                  Card(
                    elevation: 1,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 4.w,
                          ),
                          CustomText(text: "Total Prayers : ${prayerController.prayerTimeList[0].prayers?.isNotEmpty??true?
                          prayerController.prayerTimeList[0].prayers?.length:0}",fontSize: 16.sp,fontWeight: FontWeight.w500,),
                          Spacer(),

                        ],
                      ),
                    ),
                  ),


                  Card(
                    elevation: 1,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        children: [

                          CustomImage(imageSrc: AppIcons.pray3),

                          SizedBox(
                            width: 4.w,
                          ),
                          CustomText(text: "Prayed Prayers : ${prayerController.prayedLanght.value}",
                            fontSize: 16.sp,fontWeight: FontWeight.w400,color: Colors.black45,),

                        ],
                      ),
                    ),
                  ),

                  Card(
                    elevation: 1,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [

                          CustomImage(imageSrc: AppIcons.pray4),

                          SizedBox(
                            width: 4.w,
                          ),
                          CustomText(text: "Missed Prayers : ${prayerController.missingPrayerLanght.value}",fontSize: 16.sp,fontWeight: FontWeight.w400,color: Colors.black45,),

                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 12.h,
                  ),

                  CustomText(text: "Missed Prayers List",fontSize: 18.sp,fontWeight: FontWeight.w400,color: AppColors.black_03,),

                  SizedBox(
                    height: 8.h,
                  ),
                  /// Date Row
                  GestureDetector(
                    onTap: ()async{
                      prayerController.selectDateMissing();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month, color: AppColors.brinkPink),
                        SizedBox(width: 8),
                        //${waterController.selectedStartDate.value.isEmpty?waterController.currentDate.value:waterController.selectedStartDate.value}
                        Text(
                          'Date: ${prayerController.formattedCurrentDate.value.isEmpty?prayerController.selectedPrayerMissingDate.value:prayerController.formattedCurrentDate.value}',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),

                         Icon(Icons.arrow_drop_down,size: 28,)

                      ],
                    ),
                  ),

                   //_buildMissedPrayerList()

                  prayerController.retrivePrayerLoading.value
                      ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.brinkPink1,
                    ),
                  ):
                  prayerController.prayerTimeList.value.isEmpty?
                  SizedBox(
                    height: MediaQuery.of(context).size.height/4,
                    child: Center(
                      child: CustomText(
                        text: "prayer not yet!!",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightRed,
                      ),
                    ),
                  ):
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: prayerController.prayerTimeList[0].prayers?.length,
                      itemBuilder: (BuildContext context, index) {

                        final model = prayerController.prayerTimeList[0].prayers?[index];

                        if(model?.isComplete==false){
                          return Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ///Icon(prayer["icon"], color: Colors.orange),
                                  CustomImage(
                                      imageSrc: prayersIcon[index]),
                                  SizedBox(width: 12),
                                  Expanded(
                                      child: Text(
                                        "${model?.name}\n${DateConverter.formatTime(model?.time??"")},",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          decorationColor: Colors.grey,
                                        ),
                                        textAlign: TextAlign.start,
                                      )),
                                  homeController.prayerUpdateLoading.value?CircularProgressIndicator(color: AppColors.brinkPink1,):
                                  Icon(
                                    model?.isComplete==false? Icons.cancel : null,
                                    color: model?.isComplete==false?Colors.red : null,
                                    size: 28,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return SizedBox();

                      })
                ],
              ),
            );
          }
        ),
      ),

    );
  }
}









