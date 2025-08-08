import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/water/water_controller.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_icons/app_icons.dart';

import '../home/home_controller.dart' show HomeController;


class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {

  double waterAmount = 2500; // Initial value of the slider
  String selectedDay = "TH";


  final waterController = Get.put(WaterController());

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "Water",leftIcon: true,),
      floatingActionButton: FloatingActionButton(onPressed: (){

        Get.offNamed(AppRoutes.waterAddScreen);

      },child: Icon(Icons.add,size: 28,color: Colors.white,),backgroundColor: AppColors.brinkPink,),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Obx(
            () {

              double waterValue =0.0;

               if(waterController.retriveWaterCaloriesList.isNotEmpty)
                 waterValue = waterController.retriveWaterCaloriesList[0].water?.toDouble()??0.0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  // Title Section
                  CustomText(text: "Choose Date ",fontSize: 18.sp, fontWeight: FontWeight.w600),
                  SizedBox(height: 20.h),

                  ///Days Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(waterController.daysInMonth.length, (index) {
                        final date = waterController.daysInMonth[index];
                        final isSelected = waterController.selectedDate.value.day == date.day &&
                            waterController.selectedDate.value.month == date.month &&
                            waterController.selectedDate.value.year == date.year;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: () => waterController.selectDate(date),
                            child: Container(
                              width: 60,
                              height: 80,
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.brinkPink1 : Color(0xFFF6E1C5),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat.E().format(date), // e.g. Mon
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    DateFormat.d().format(date), // e.g. 12
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),


                  SizedBox(height: 16.h),

                  waterController.retriveWaterCaloriesLoading.value?Center(child: CircularProgressIndicator(color: AppColors.brinkPink1,)):
                  waterController.retriveWaterCaloriesList.isNotEmpty?
                  Column(
                    children: [
                      Slider(
                        activeColor: AppColors.brinkPink,
                        //inactiveColor: Colors.grey,
                        value: waterValue,
                        min: 0,
                        max: 2500,
                        divisions: 250,
                       // label: "${homeController.retriveWaterCaloriesList[0].water} ML",
                        onChanged: (double value) {
                          /* setState(() {
                        waterAmount = value;
                      });*/
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            CustomText(text: "${waterController.retriveWaterCaloriesList[0].water} ML",fontWeight: FontWeight.w600, color: AppColors.brinkPink,fontSize: 14.sp,),

                            CustomText(text: "2.5 ML",fontWeight: FontWeight.w600, color: AppColors.brinkPink,fontSize: 14.sp,),

                          ],
                        ),
                      ),
                    ],
                  ): SizedBox(
                    height: MediaQuery.of(context).size.height/9,
                    child: Center(
                      child: CustomText(
                        text: "No water yet!!",
                        fontSize:18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightRed,
                      ),
                    ),
                  ),


                  SizedBox(
                    height: 16.h,
                  ),

                  Center(child: CustomImage(imageSrc: AppIcons.waterlogo)),

                  SizedBox(
                    height: 16.h,
                  ),
                  Center(child: CustomText(text: "Note: Add your water intake to \n calculate your daily goal.",fontSize: 14.sp,fontWeight: FontWeight.w600,)),

                  SizedBox(
                    height: 28.h,
                  ),

                  // view water screen Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {

                        Get.toNamed(AppRoutes.waterHistoryScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brinkPink,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding:  EdgeInsets.symmetric(vertical: 14),
                      ),
                      child:  Text('View Water Intake History',style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                    ),
                  ),
                ],
              );
            }
          ),
        )
      ),

    );
  }
}
