import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/water/water_controller.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/toast.dart';

class WaterHistoryScreen extends StatefulWidget {


  WaterHistoryScreen({super.key});

  @override
  State<WaterHistoryScreen> createState() => _WaterHistoryScreenState();
}

class _WaterHistoryScreenState extends State<WaterHistoryScreen> {

  final List<WaterData> history = [
   // WaterData(date: '01 May, 2025', target: 2500, consumed: 1200),
  /*  WaterData(date: '30 December 2024', target: 2500, consumed: 1750),
    WaterData(date: '29 December 2024', target: 2500, consumed: 1200),
    WaterData(date: '28 December 2024', target: 2500, consumed: 1200),*/
  ];

  final waterController = Get.put(WaterController());

  DateTime selectedDate = DateTime(2025, 1, 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Safe to call setState or update observables here
      if(waterController.currentDate.value.isNotEmpty){

        waterController.retriveWaterCalories(waterController.currentDate.value);

      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: "History",leftIcon: true,),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Obx(
              () {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Date Row
                  GestureDetector(
                    onTap: ()async{

                       waterController.selectHistoryDate();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month, color: AppColors.brinkPink),
                        SizedBox(width: 8),

                        CustomText(text: 'Date: ${waterController.selectedStartDate.value.isEmpty?waterController.currentDate.value:waterController.selectedStartDate.value}', fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,),

                        Icon(Icons.arrow_drop_down,size: 28,)
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // Today's
                  CustomText(text: "Today’s",fontSize: 16.sp, fontWeight: FontWeight.bold),

                  SizedBox(height: 8),
                 // WaterCard(data: history[0]),

                  SizedBox(height: 16),

                  // Previous Days
                  waterController.retriveWaterCaloriesLoading.value?
                  Center(child: CircularProgressIndicator(color: AppColors.brinkPink1,)):
                  waterController.retriveWaterCaloriesList.isEmpty?
                  SizedBox(
                    height: MediaQuery.of(context).size.height/2,
                    child: Center(
                      child: CustomText(
                        text: "No history yet!!",
                        fontSize:18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightRed,
                      ),
                    ),
                  ):
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: waterController.retriveWaterCaloriesList.length,
                    itemBuilder: (context, index) {
                      final item = waterController.retriveWaterCaloriesList[index];

                      var remaining =(2500-waterController.retriveWaterCaloriesList[index].water);

                      var discount =(waterController.retriveWaterCaloriesList[index].water*100)/2500;

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCF7F2), // match the background from Figma
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: "Target",fontSize: 14.sp,),

                                SizedBox(
                                  height: 12.h,
                                ),
                                CustomText(text: "2500 ml",fontSize: 14.sp),
                              ],
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                CustomText(text: "Consumed",fontSize: 14.sp),

                                SizedBox(
                                  height: 12.h,
                                ),
                                CustomText(text: "${item.water}"),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: "Remaining"),
                                SizedBox(
                                  height: 12.h,
                                ),
                                CustomText(text: "${remaining} ml"),
                              ],
                            ),


                            ///Progress Indicator
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: CircularProgressIndicator(
                                    value: 0.5,
                                    strokeWidth: 6,
                                    backgroundColor: Colors.orange.shade100,
                                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDDA87A)),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text("${discount}%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    Icon(Icons.water_drop, color: Colors.lightBlue, size: 16),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
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

// Data class
class WaterData {
  final String date;
  final int target;
  final int consumed;

  WaterData({required this.date, required this.target, required this.consumed});
}

// Custom Card
class WaterCard extends StatelessWidget {
  final WaterData data;

  const WaterCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int remaining = data.target - data.consumed;
    final double percent = data.consumed / data.target;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF7F2), // match the background from Figma
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Target",fontSize: 14.sp,),

              SizedBox(
                height: 12.h,
              ),
              CustomText(text: "2500 ml",fontSize: 14.sp),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              CustomText(text: "Consumed",fontSize: 14.sp),

              SizedBox(
                height: 12.h,
              ),
              CustomText(text: "1200 ml"),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Remaining"),
              SizedBox(
                height: 12.h,
              ),
              CustomText(text: "1300 ml"),
            ],
          ),


          // Progress Indicator
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  value: 0.5,
                  strokeWidth: 6,
                  backgroundColor: Colors.orange.shade100,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDDA87A)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("50%", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Icon(Icons.water_drop, color: Colors.lightBlue, size: 16),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}


