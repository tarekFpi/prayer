
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/components/nav_bar/nav_bar.dart';
import 'package:prayer_app/core/features/home/home_controller.dart';
import 'package:prayer_app/core/features/prayers/prayers_controller.dart';
import 'package:prayer_app/core/helper/time_converter/time_converter.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_icons/app_icons.dart';


class PrayersScreen extends StatefulWidget {
  const PrayersScreen({super.key});

  @override
  State<PrayersScreen> createState() => _PrayersScreenState();
}

class _PrayersScreenState extends State<PrayersScreen> {

  DateTime selectedDate = DateTime.now();

  final homeController = Get.put(HomeController());

  final prayerController = Get.put(PrayersController());

  final prayersIcon = [
    AppIcons.fajr,
    AppIcons.dhuhr,
    AppIcons.asr,
    AppIcons.maghrib,
    AppIcons.isha,
  ];

  // Method to format the selected Gregorian date into Hijri format
  String formatHijriDate(DateTime date) {
    HijriCalendar hijriDate = HijriCalendar.fromDate(date); // Convert to Hijri
    return "${hijriDate.hDay}th ${hijriDate.getLongMonthName()}, ${hijriDate.hYear}h"; // Format as "Day Month Year"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "Prayers",),

      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Obx(
               () {
                return Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(
                      height: 12.h,
                    ),
                    // Tabs for Everyday, Week, Month
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Next Prayer Section
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.brinkPink, // Light orange background
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizedBox(height: 8),
                              // Prayer Name and Time
                              Row(
                                children: [

                                  CustomImage(imageSrc: AppIcons.pra),

                                  SizedBox(
                                    width: 4.w,
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      // Next Prayer Header
                                      CustomText(
                                          text: "Next Prayer",
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white,
                                      ),

                                      if(homeController.prayerName.value.isNotEmpty && homeController.currentPrayerTime.value.isNotEmpty)
                                      CustomText(
                                          text: "${homeController.prayerName.value}\t ${homeController.currentPrayerTime.value},",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white,
                                      ),

                                    ],
                                  ),

                                  Spacer(),

                                  Icon(
                                    Icons.location_on,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),

                                  Flexible(
                                    child: CustomText(
                                       text:  prayerController.address.value,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              // Date and Location
                              Row(
                                children: [
                                  CustomImage(imageSrc: AppIcons.calendar,width: 24,height: 24,),
                                  SizedBox(width: 8),
                                  Text(
                                      homeController.formattedCurrentDate.value,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.white,
                                      )
                                  ),
                                  Spacer(),

                                  CustomImage(imageSrc: AppIcons.calendar,width: 24,height: 24,),

                                  SizedBox(width: 8),
                                  CustomText(
                                     text:  formatHijriDate(selectedDate),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.white,
                                    maxLines: 1,
                                  )
                                ],
                              ),


                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        // View Prayers Log Button
                        InkWell(
                          onTap: (){
                            Get.toNamed(AppRoutes.prayersLogScreen);
                          },
                          child: Card(
                            elevation: 1,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [

                                  CustomImage(imageSrc: AppIcons.pray2),

                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  CustomText(text: "View Prayers Log",fontSize: 14.sp,fontWeight: FontWeight.w800,color: AppColors.black_04,),
                                  Spacer(),

                                  Icon(Icons.arrow_forward_ios_rounded,size: 24,)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(blurRadius: 4, color: Colors.grey.shade300)
                        ],
                      ),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          CustomText(text: "All Prayers History",fontWeight: FontWeight.bold,fontSize: 18.sp,color: AppColors.black_04,),

                          SizedBox(
                            height: 8.h,
                          ),

                          // _buildPrayerList()
                          homeController.retrivePrayerLoading.value
                              ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.brinkPink1,
                            ),
                          ):
                          homeController.prayerTimeList.value.isEmpty?
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
                              itemCount: homeController.prayerTimeList[0].prayers?.length,
                              itemBuilder: (BuildContext context, index) {

                                final model = homeController.prayerTimeList[0].prayers?[index];

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
                                        InkWell(
                                          onTap: (){

                                            /*    if(model?.isComplete==false){
                                            homeController.prayerUpdate(model?.name??"",model?.time??"",true);
                                          }if(model?.isComplete==true){
                                            homeController.prayerUpdate(model?.name??"",model?.time??"",false);
                                          }
                                          HapticFeedback.lightImpact();*/
                                          },
                                          child: Icon(
                                            model?.isComplete==false? Icons.cancel : Icons.check_circle,
                                            color: model?.isComplete==false?Colors.red : Colors.green,
                                            size: 28,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),


                  ],
                );
              }
            ),
          )
        ],
      ),

      bottomNavigationBar: NavBar(currentIndex: 3),
    );
  }
}



Widget _buildPrayerList() {
  final prayers = [
    {"name": "Fajr", "time": "05:33 AM", "icon": AppIcons.fajr, "status": true},
    {"name": "Dhuhr", "time": "12:15 PM", "icon":AppIcons.dhuhr, "status": true},
    {"name": "Asr", "time": "3:45 PM", "icon": AppIcons.asr, "status": true},
    {"name": "Maghrib", "time": "6:30 PM", "icon": AppIcons.maghrib, "status": false},
    {"name": "Isha", "time": "08:30 PM", "icon": AppIcons.isha, "status": true},
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(blurRadius: 8, color: Colors.grey.shade300)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


         SizedBox(height: 12),
        ...prayers.map((prayer) => _buildPrayerTile(prayer)).toList(),
      ],
    ),
  );
}

Widget _buildPrayerTile(Map<String, dynamic> prayer) {
  return Card(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Icon(prayer["icon"], color: Colors.orange),
          CustomImage(imageSrc: prayer["icon"]),
          SizedBox(width: 12),
          Expanded(child: Text("${prayer['name']}\n${prayer['time']}",style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            decorationColor: Colors.grey,
          ),textAlign: TextAlign.start,)),
          Icon(
            prayer["status"] ? Icons.check_circle : Icons.cancel,
            color: prayer["status"] ? Colors.green : Colors.red,
          ),
        ],
      ),
    ),
  );
}


