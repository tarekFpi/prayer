
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/components/nav_bar/nav_bar.dart';
import 'package:prayer_app/core/features/fitness/fitness_controller.dart';
import 'package:prayer_app/core/features/home/home_controller.dart';
import 'package:prayer_app/core/helper/extensions/color_extensions.dart';
import 'package:prayer_app/core/helper/time_converter/time_converter.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_app/core/helper/extensions/color_extensions.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/toast.dart';


class FitnessScreen extends StatefulWidget {
    FitnessScreen({super.key});

    final Color leftBarColor = AppColors.brinkPink1;
    final Color rightBarColor = AppColors.contentColorRed;
    final Color avgColor =

    AppColors.contentColorOrange.avg(AppColors.contentColorRed);

    @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {


  final int maxSteps = 8000;


 // final  fitnessController = Get.put(FitnessController());

  final  fitnessController = Get.find<FitnessController>();

  final homeController = Get.put(HomeController());



  DateTime _selectedDate = DateTime.now();

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;


  final double width = 7;

  late List<BarChartGroupData> rawBarGroups=[];
  late List<BarChartGroupData> showingBarGroups=[];

  int touchedGroupIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(fitnessController.currentIndex.value==0){

      fitnessController.retriveDailyMonth(fitnessController.formattedCurrentDate.value,fitnessController.formattedCurrentDate.value);

    }
  }

  late BarChartGroupData  barGroup0;
  late BarChartGroupData  barGroup1;
  late BarChartGroupData  barGroup2;
  late BarChartGroupData  barGroup3;
  late BarChartGroupData  barGroup4;
  late BarChartGroupData  barGroup5;
  late BarChartGroupData  barGroup6;

  @override
  Widget build(BuildContext context) {

    barGroup0 = BarChartGroupData(x: 0, barRods: []);
    barGroup1 = BarChartGroupData(x: 1, barRods: []);
    barGroup2 = BarChartGroupData(x: 2, barRods: []);
    barGroup3 = BarChartGroupData(x: 3, barRods: []);
    barGroup4 = BarChartGroupData(x: 4, barRods: []);
    barGroup5 = BarChartGroupData(x: 5, barRods: []);
    barGroup6 = BarChartGroupData(x: 6, barRods: []);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "Fitness",),

      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Obx(
              () {


              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    height: 50.h,
                    width: MediaQuery.of(context).size.width/1,
                    decoration: BoxDecoration(
                      color: AppColors.white_50,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                          List.generate(fitnessController.nameList.length, (index) {
                            return GestureDetector(
                              onTap: (){
                                fitnessController.currentIndex.value = index;

                                if(fitnessController.currentIndex.value==0){

                                  fitnessController.stepTotalStep.value=0.0;

                                 fitnessController.retriveDailyMonth(fitnessController.formattedCurrentDate.value,fitnessController.formattedCurrentDate.value);

                                 _selectedStartDate = null;
                                 _selectedEndDate = null;

                                }

                                if(fitnessController.currentIndex.value==1){

                                  fitnessController.stepTotalStep.value=0.0;

                               // var  previousDate = fitnessController.getPrevious7Days();

                                  fitnessController.retriveWeek();
                                  _selectedStartDate = null;
                                 _selectedEndDate = null;

                                }if(fitnessController.currentIndex.value==2){

                                  fitnessController.stepTotalStep.value=0.0;
                                }


                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width /4,
                                //  height: 50.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: fitnessController.currentIndex.value == index
                                      ? AppColors.brinkPink
                                      : AppColors.white,
                                ),
                                child: CustomText(
                                  text: fitnessController.nameList[index],
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                              ),
                            );
                          })),
                    ),
                  ),

                  SizedBox(
                    height: 16,
                  ),

                  ///Tabs for Everyday,
                 if(fitnessController.retriveAJournalLList.isNotEmpty && fitnessController.currentIndex.value==0)
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                     itemCount: fitnessController.retriveAJournalLList.length,
                      itemBuilder: (BuildContext context,index){
                     //  final model= fitnessController.retriveAJournalLList[0];

                       if(index==0){
                         return Container(
                           width: double.infinity,
                           height: 180.h,
                           padding: EdgeInsets.only(left: 8,right: 8,bottom: 12,),
                           decoration: BoxDecoration(
                             color: AppColors.brinkPink, // Light orange background
                             borderRadius: BorderRadius.circular(12),
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [

                               SizedBox(height: 4),

                               CustomText(text: "Today's Fitness Reminder",fontSize: 18.sp,fontWeight: FontWeight.w800,color: Colors.white,),
                               SizedBox(height: 8),

                               ///title Text
                               CustomText(text:
                               "${fitnessController.retriveAJournalLList[0].reflection}",fontSize: 14.sp,textAlign: TextAlign.start,color: Colors.white,
                                 fontWeight: FontWeight.w400,
                                 maxLines: 1,
                               ),
                               SizedBox(height: 8),

                               ///content Text
                               CustomText(text:
                               "${fitnessController.retriveAJournalLList[0].goals}",
                                 fontSize: 12.sp,textAlign: TextAlign.start,color: Colors.white,
                                 fontWeight: FontWeight.w400,
                                 maxLines: 3,
                               ),
                             ],
                           ),
                         );
                       }else{
                        SizedBox();
                       }
                       return null;

                  }),


                  SizedBox(
                    height: 16.h,
                  ),

                  if(fitnessController.currentIndex.value==0)
                   Column(
                     children: [

                       CircularProgressWithText(
                         progress:fitnessController.stepTotalStep.value, // 75% progress
                         stepCount: '${fitnessController.stepTotalStep.value.toDouble()}',
                         iconData: Icons.directions_walk,
                         //Icon(Icons.directions_walk, size: 24),
                       ),

                       SizedBox(
                         height: 12.h,
                       ),

                     /*  Center(
                         child: CustomText(text:
                         "count:${fitnessController.steps.value}",
                             fontSize: 24.sp,textAlign: TextAlign.center,color: Colors.black
                         ),
                       ),*/
                     ],
                   ) ,

                  if(fitnessController.currentIndex.value==1)
                  SizedBox(
                    height: 350,
                    child: Card(
                      color: Colors.white,
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView(
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Step Count
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [

                                    Icon(Icons.directions_walk, size: 24),
                                    SizedBox(width: 8),

                                    CustomText(text:
                                    "Steps",
                                        fontSize: 22.sp,textAlign: TextAlign.start,color: Colors.brown
                                    ),

                                  ///Text("Steps", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                CustomText(text:
                                "${fitnessController.retriveDailyMonthList.value.calculation?.totalStep}",
                                    fontSize: 18.sp,textAlign: TextAlign.start,color: Colors.brown
                                ),
                                 ///Text("8000", style: TextStyle(fontSize: 18, color: Colors.brown)),
                              ],
                            ),
                            const SizedBox(height: 24),

                            ///Chart
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(fitnessController.retriveDailyMonthList.value.history?.length ?? 0, (index) {
                                final historyItem = fitnessController.retriveDailyMonthList.value.history![index];
                            
                                // Ensure maxValue is properly set and not 0
                                double maxValue = fitnessController.maxValue.value;
                            
                                // Ensure maxValue is not 0 to avoid division by zero
                                if (maxValue == 0) {
                                  maxValue = 1;  // Set to 1 to avoid division by zero error (you can handle this differently as needed)
                                }
                            
                                // Safely calculate the height factor (percentage) for this specific item
                                // Make sure historyItem.step is not null, default to 0 if null
                                double stepValue = historyItem.step?.toDouble() ?? 0.0;
                            
                                // Calculate the height factor as a percentage
                                double heightFactor = stepValue / maxValue;
                            
                                // Check if the height factor exceeds 1.0, clamp it to 1.0
                                if (heightFactor > 1.0) {
                                  heightFactor = 1.0;  // Cap it to 1.0 if it's greater than 100%
                                }
                            
                                return Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      /// Full bar (using FractionallySizedBox)
                                      Container(
                                        margin: EdgeInsets.only(left: 8, right: 6),
                                        width: 20,  // Width of the bar
                                        height: 200,  // Static height for the container
                                        decoration: BoxDecoration(
                                          color: Colors.brown[100],
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: FractionallySizedBox(
                                            heightFactor: heightFactor, // Use the calculated percentage
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.brinkPink,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // Display the day name or any additional info
                                      CustomText(
                                        text: "${historyItem.day}",
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        language: true,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            )



                            // Aspect Ratio or Adjusted Column for BarChart
                         /*   Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 12),
                                // Using a fixed height for the chart container
                                Container(
                                  height: 240, // Explicit height for the BarChart container
                                  child: BarChart(
                                    BarChartData(
                                      maxY: 20,
                                      barTouchData: BarTouchData(
                                        touchTooltipData: BarTouchTooltipData(
                                          getTooltipColor: ((group) {
                                            return Colors.grey;
                                          }),
                                          getTooltipItem: (a, b, c, d) => null,
                                        ),
                                        touchCallback: (FlTouchEvent event, response) {
                                          if (response == null || response.spot == null) {
                                            setState(() {
                                              touchedGroupIndex = -1;
                                              showingBarGroups = List.of(rawBarGroups);
                                            });
                                            return;
                                          }

                                          touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                                          setState(() {
                                            if (!event.isInterestedForInteractions) {
                                              touchedGroupIndex = -1;
                                              showingBarGroups = List.of(rawBarGroups);
                                              return;
                                            }
                                            showingBarGroups = List.of(rawBarGroups);
                                            if (touchedGroupIndex != -1) {
                                              var sum = 0.0;
                                              for (final rod in showingBarGroups[touchedGroupIndex].barRods) {
                                                sum += rod.toY;
                                              }
                                              final avg = sum /
                                                  showingBarGroups[touchedGroupIndex].barRods.length;

                                              showingBarGroups[touchedGroupIndex] =
                                                  showingBarGroups[touchedGroupIndex].copyWith(
                                                    barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                                                      return rod.copyWith(toY: avg, color: Colors.blue);
                                                    }).toList(),
                                                  );
                                            }
                                          });
                                        },
                                      ),
                                      titlesData: FlTitlesData(
                                        show: true,

                                        rightTitles: const AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                        topTitles: const AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: bottomTitles,
                                            reservedSize: 42,
                                          ),
                                        ),
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            reservedSize: 16,
                                            interval: 1,
                                            getTitlesWidget: leftTitles,
                                          ),
                                        ),
                                      ),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      barGroups: showingBarGroups,
                                      gridData: FlGridData(show: false),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),*/


                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8.h,
                  ),

                  if(fitnessController.currentIndex.value==2)
                   Column(
                     children: [
                       GridView.builder(
                         itemCount: 31,
                         shrinkWrap: true,
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 7, // 7 days per week
                         ),
                         itemBuilder: (context, index) {
                           final day = index + 1;


                           return Padding(
                             padding: const EdgeInsets.all(4.0),
                             child: Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(8),
                                 color: Colors.white,
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.black.withOpacity(0.1),
                                     blurRadius: 8,
                                     offset: Offset(0, 4),
                                   ),
                                 ],
                               ),
                               child: GestureDetector(
                                 onTap: () {
                                   setState(() {
                                     DateTime selectedDay = DateTime(_selectedDate.year, _selectedDate.month, day);

                                     if (_selectedStartDate == null) {
                                       // If no start date is selected, set this date as the start date
                                       _selectedStartDate = selectedDay;
                                       _selectedEndDate = null; // Clear end date if start is changed
                                     } else if (_selectedEndDate == null && selectedDay.isAfter(_selectedStartDate!)) {
                                       // Set the end date if it's after the start date
                                       _selectedEndDate = selectedDay;

                                       if(_selectedStartDate != null && _selectedEndDate != null){

                                            var endDate =DateConverter.timeDateFormetString(_selectedEndDate.toString());

                                            var fromDate =DateConverter.timeDateFormetString(_selectedStartDate.toString());

                                            fitnessController.retriveDailyMonth(fromDate,endDate);
                                       }
                                     } else {
                                       // If both start and end are selected, reset the start date
                                       _selectedStartDate = selectedDay;
                                       _selectedEndDate = null;
                                     }
                                   });
                                 },
                                 child: Container(
                                   alignment: Alignment.center,
                                   decoration: BoxDecoration(
                                     color: (_selectedStartDate != null && _selectedEndDate != null && day >= _selectedStartDate!.day && day <= _selectedEndDate!.day)
                                         ? AppColors.brinkPink
                                         : (_selectedStartDate?.day == day
                                         ? AppColors.brinkPink
                                         : (_selectedEndDate?.day == day ? AppColors.brinkPink : Colors.transparent)),
                                     borderRadius: BorderRadius.circular(8),
                                   ),
                                   child: Text(
                                     '$day',
                                     style: TextStyle(color: (_selectedStartDate?.day == day || _selectedEndDate?.day == day) ? Colors.white : Colors.black),
                                   ),
                                 ),
                               ),
                             ),
                           );
                         },
                       ),

                       SizedBox(
                         height: 8.h,
                       ),
                      /* CircularProgressWithText(
                         progress: 0.75, // 75% progress
                         stepCount: '9,592', // Step count
                         iconData: Icons.directions_walk,
                         //Icon(Icons.directions_walk, size: 24),
                       ),*/

                       CircularProgressWithText(
                          progress:  fitnessController.stepTotalStep.value ,
                         stepCount: '${fitnessController.stepTotalStep.value}', // Step count// Step count
                         iconData: Icons.directions_walk,
                         //Icon(Icons.directions_walk, size: 24),
                       ),
                     ],
                   ),

                  SizedBox(
                    height: 8.h,
                  ),

                  /// today water is not empty show
                  if(fitnessController.retriveDailyMonthList.value.calculation.toString().isNotEmpty)
                    Row(
                      children: [
                        _buildCard(
                            title: 'Water',
                            icon: Icons.water_drop_outlined,
                            value: '${fitnessController.retriveDailyMonthList.value.calculation?.totalWater}',
                            //  value: '0.0',
                            unit: '2,500 OF ${fitnessController.water} ML',
                            progress: fitnessController.water.toDouble(),
                            status: true),
                        const SizedBox(width: 12),
                        _buildCard(
                            title: 'Calories',
                            icon: Icons.local_fire_department_outlined,
                            value: '${fitnessController.retriveDailyMonthList.value.calculation?.totalCalories}',
                            // value: '0.0',
                            unit: '2,600 OF ${fitnessController.calories} KCAL',
                            progress: fitnessController.calories.toDouble(),
                            status: false),
                      ],
                    ),

                  /// Water Calories List empty show
                  if(fitnessController.retriveDailyMonthList.value.calculation.toString().isEmpty)
                    Row(
                      children: [
                        _buildCard(
                            title: 'Water',
                            icon: Icons.water_drop_outlined,
                            value: '0.0',
                            unit: '2,500 OF ${homeController.water} ML',
                            progress: fitnessController.water.toDouble(),
                            status: true),

                        const SizedBox(width: 12),

                        _buildCard(
                            title: 'Calories',
                            icon: Icons.local_fire_department_outlined,
                            value: '0.0',
                            // value: '0.0',
                            unit: '2,600 OF ${fitnessController.calories} KCAL',
                            progress: fitnessController.calories.toDouble(),
                            status: false),
                      ],
                    ),


                  SizedBox(
                    height: 8.h,
                  ),

                /*      Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Track Your Effort Section
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Track Your Effort Title
                              Text(
                                "Track Your Effort",
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decorationColor: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 10),
                              // Question
                              Text(
                                "Did you exercise today?",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )
                              ),
                              SizedBox(height: 8),
                              Text(
                                "✨ Remember: A strong believer is more beloved to Allah!",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.brinkPink,
                                  )
                              ),
                              SizedBox(height: 10),
                              // Radio Buttons for Yes/No
                              Row(
                                children: [
                                  // Yes Button
                                  Radio<String>(
                                    value: 'Yes',
                                    groupValue: _exerciseChoice,
                                    activeColor: AppColors.brinkPink,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _exerciseChoice = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Yes",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  // No Button
                                  Radio<String>(
                                    value: 'No',
                                    groupValue: _exerciseChoice,
                                    activeColor: AppColors.brinkPink,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _exerciseChoice = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "No",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      )
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              // Reminder Text

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Share with Friends Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brinkPink,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person,size: 24,color: Colors.white,),
                              SizedBox(
                              width: 6,
                            ),
                            Text('Share With Friends',
                                ///style: TextStyle(color: AppColors.white)
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                )
                            )
                            ],
                          )),
                        ),

                    ],
                  )
*/

                ],
              );
            }
          ),
        ),
      ),

      bottomNavigationBar: NavBar(currentIndex: 2),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '';
    } else if (value == 10) {
      text = '';
    } else if (value == 19) {
      text = '';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

/*

  Widget bottomTitles(double value, TitleMeta meta) {

    final titles = <String>['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    final Widget text = Text(dayList.isNotEmpty?
      dayList[value.toInt()]:"",
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }
*/

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: 20,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: 20,
        ),
      ],
    );
  }


}






Widget _buildCard({
  required String title,
  required IconData icon,
  required String value,
  required String unit,
  required double progress,
  required bool status,
}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              CustomText(text:
              title,
                  fontSize: 14.sp,textAlign: TextAlign.start,fontWeight: FontWeight.w800,
              ),

              Icon(icon, color: Color(0xFFD9A17C), size: 24),
            ],
          ),
          const SizedBox(height: 8),

          CustomText(text:
          value,
            fontSize: 22.sp,textAlign: TextAlign.start,fontWeight: FontWeight.w800,
            color: Color(0xFFD9A17C),
          ),
          const SizedBox(height: 4),
          Text(
            unit,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFF5EDE7),
              valueColor: const AlwaysStoppedAnimation(Color(0xFFD9A17C)),
              minHeight: 6,
            ),
          ),

        ],
      ),
    ),
  );
}

// Custom Tab Button for selection
class TabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  const TabButton({required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
      child: Text(text),
    );
  }
}

// Custom Progress Widget for Water and Calories
class ProgressWidget extends StatelessWidget {
  final String label;
  final int value;
  final int total;
  final IconData icon;

  const ProgressWidget({
    required this.label,
    required this.value,
    required this.total,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.orange.shade300),
        SizedBox(height: 8),
        Text(
          '$value / $total',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: value / total,
          color: Colors.orange.shade300,
          backgroundColor: Colors.grey.shade300,
        ),
      ],
    );
  }
}

// Custom Yes/No choice button
class ChoiceButton extends StatelessWidget {
  final String text;

  const ChoiceButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(text),
      style: ElevatedButton.styleFrom(

        side: BorderSide(color: Colors.orange),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      ),
    );
  }
}


class CircularProgressWithText extends StatelessWidget {
  final double progress; // Progress value between 0.0 and 1.0
  final String stepCount; // Step count value to display in the center
  final IconData iconData; // Icon data for the figure (person)

  CircularProgressWithText({
    required this.progress,
    required this.stepCount,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular progress bar
          SizedBox(
            width: 180,
            height: 180,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.brinkPink),
            ),
          ),
          // Icon in the center
          Positioned(
            top: 60,
            child: Icon(
              iconData,
              size: 40,
              color: Colors.black,
            ),
          ),


          // Step count in the center
          Positioned(
            bottom: 30,
            child: Text(
              stepCount,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}