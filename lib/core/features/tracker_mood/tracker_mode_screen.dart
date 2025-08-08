

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/core/components/custom_from_card/custom_from_card.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_netwrok_image/custom_network_image.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/components/custom_text_field/custom_text_field.dart';
import 'package:prayer_app/core/features/tracker_mood/mood_tracker_controller.dart';
import 'package:prayer_app/core/helper/time_converter/time_converter.dart';
import 'package:prayer_app/core/service/api_url.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_icons/app_icons.dart';
import 'package:prayer_app/core/utils/toast.dart';


class TrackerModeScreen extends StatefulWidget {


  const TrackerModeScreen({super.key,});

  @override
  State<TrackerModeScreen> createState() => _TrackerModeScreenState();
}

class _TrackerModeScreenState extends State<TrackerModeScreen> {

  DateTime selectedDate = DateTime(2025, 1, 1);

  var categoryId="";

  var moodTitle="";

  final moodTrackerController = Get.put(MoodTrackerController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Get.arguments[0]["moodTitle"] !=null)  {

      moodTitle = Get.arguments[0]["moodTitle"];

      /// mood tracker
      moodTrackerController.retriveTrackersMood();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    moodTrackerController.moodTrackersList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "Mood Tracker",leftIcon: true,),
      body: RefreshIndicator(child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
                    () {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CustomFormCard(
                        title: "",
                        hintText: "What made you feel this way today?",
                        maxLine: 6,
                        controller: moodTrackerController.descriptionController.value,
                      ),

                      SizedBox(
                        height: 12.h,
                      ),

                      /// Feel Sad
                      if(moodTitle=="Feel Sad")
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// Feel Sad static Dua
                            Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    children: [

                                      CustomText(text: "Feel Sad",fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
                                      Spacer(),
                                      CustomImage(imageSrc: AppIcons.feelsad,width: 32,height: 32,),
                                    ],
                                  ),
                                  SizedBox(height: 6),

                                  CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.black_02,),
                                  SizedBox(height: 6),

                                  CustomText(text: "Cry if you need to. Allah listens. Even tears are a form of du'a.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

                                  SizedBox(height: 6),

                                  CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

                                  CustomText(text: "Allah, the Eternal Refuge.He neither begets nor is born,Nor is there to Him any equivalent.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

                                  SizedBox(height: 6),
                                  CustomText(text: "${moodTrackerController.formattedCurrentDate.value}",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.black_03,maxLines: 1,textAlign: TextAlign.start),

                                ],
                              ),
                            ),

                            SizedBox(
                              height: 12.h,
                            ),

                            CustomText(
                              text: "Mood History",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black_04,
                            ),

                            SizedBox(
                              height: 8.h,
                            ),

                            GestureDetector(
                              onTap: ()async{

                                moodTrackerController.searchSelectDate();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month, color: Colors.orange),
                                  SizedBox(width: 8),

                                  CustomText(
                                    text: "${moodTrackerController.searchSelectedDate.value.isEmpty?"select date": moodTrackerController.searchSelectedDate.value}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  IconButton(
                                    icon: Icon(Icons.arrow_drop_down,size: 28,),
                                    onPressed: () async {
                                      moodTrackerController.searchSelectDate();
                                    },
                                  )
                                ],
                              ),
                            ),

                            ///Mood History Feel Sad dynamic Dua

                            moodTrackerController.retriveTrackersMoodLoading.value?Center(
                              child: CircularProgressIndicator(
                                color: AppColors.brinkPink1,
                              ),
                            ):moodTrackerController.moodTrackersList.isEmpty?
                            SizedBox(
                              height: MediaQuery.of(context).size.height/4,
                              child: Center(
                                child: CustomText(
                                  text: "no mood yet!!",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.lightRed2,
                                ),
                              ),
                            ):
                            ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: moodTrackerController.moodTrackersList.length,
                                itemBuilder: (BuildContext context,index){

                                  final model =moodTrackerController.moodTrackersList[index];

                                  return Container(
                                    padding: EdgeInsets.all(12),
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [

                                            CustomText(text: "Feel Sad",fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
                                            Spacer(),
                                            CustomImage(imageSrc: AppIcons.feelsad,width: 32,height: 32,),
                                            //Text(date, style: TextStyle(fontSize: 12)),
                                          ],
                                        ),

                                        SizedBox(height: 6),

                                        CustomText(text: "${model.title}",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.black_02,),
                                        SizedBox(height: 6),

                                        CustomText(text: "${model.description}",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.black_02,),
                                        SizedBox(height: 6),

                                        CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.black_02,),
                                        SizedBox(height: 6),

                                        CustomText(text: "Cry if you need to. Allah listens. Even tears are a form of du'a.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

                                        SizedBox(height: 6),

                                        CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

                                        CustomText(text: "Allah, the Eternal Refuge.He neither begets nor is born,Nor is there to Him any equivalent.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

                                        SizedBox(height: 6),
                                        CustomText(text: "${moodTrackerController.formattedCurrentDate.value}",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.black_04,maxLines: 2,textAlign: TextAlign.start),

                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),


                      /// Feel Anxious
                      if(moodTitle=="Feel Anxious")
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// Feel Anxious static Dua
                            Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    children: [

                                      CustomText(text: "Feel Anxious",fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
                                      Spacer(),
                                      CustomImage(imageSrc: AppIcons.feelan,width: 32,height: 32,),
                                    ],
                                  ),

                                  SizedBox(height: 6),
                                  CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                  SizedBox(height: 6),

                                  CustomText(text: "Allah is Sufficient for us, and He is the Best Disposer of affairs.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

                                  SizedBox(height: 6),

                                  CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

                                  CustomText(text: "La ilaha illa Anta, Subhanaka, inni kuntu minaz-zalimeen.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

                                  SizedBox(height: 6),
                                  CustomText(text: "${moodTrackerController.formattedCurrentDate.value}",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.black_03,maxLines: 1,textAlign: TextAlign.start),

                                ],
                              ),
                            ),

                            SizedBox(
                              height: 12.h,
                            ),

                            CustomText(
                              text: "Mood History",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black_02,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            GestureDetector(
                              onTap: ()async{

                                moodTrackerController.searchSelectDate();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month, color: Colors.orange),
                                  SizedBox(width: 8),

                                  CustomText(
                                    text: "${moodTrackerController.searchSelectedDate.value.isEmpty?"select date": moodTrackerController.searchSelectedDate.value}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  IconButton(
                                    icon: Icon(Icons.arrow_drop_down,size: 28,),
                                    onPressed: () async {
                                      moodTrackerController.searchSelectDate();
                                    },
                                  )
                                ],
                              ),
                            ),

                           ///Mood History Feel Anxious dynamic Dua
                            moodTrackerController.retriveTrackersMoodLoading.value?Center(
                              child: CircularProgressIndicator(
                                color: AppColors.brinkPink1,
                              ),
                            ):moodTrackerController.moodTrackersList.isEmpty?
                            SizedBox(
                              height: MediaQuery.of(context).size.height/4,
                              child: Center(
                                child: CustomText(
                                  text: "no mood yet!!",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.lightRed2,
                                ),
                              ),
                            ):
                            ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: moodTrackerController.moodTrackersList.length,
                                itemBuilder: (BuildContext context,index){

                                  final model =moodTrackerController.moodTrackersList[index];

                                  return  Container(
                                    padding: EdgeInsets.all(12),
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [

                                            CustomText(text: "Feel Anxious",fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
                                            Spacer(),
                                            CustomImage(imageSrc: AppIcons.feelan,width: 32,height: 32,),
                                            //Text(date, style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                        SizedBox(height: 6),

                                        CustomText(text: "${model.title}",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "${model.description}",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "Allah is Sufficient for us, and He is the Best Disposer of affairs.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

                                        SizedBox(height: 6),

                                        CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

                                        CustomText(text: "La ilaha illa Anta, Subhanaka, inni kuntu minaz-zalimeen",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

                                        SizedBox(height: 6),
                                        CustomText(text: "${moodTrackerController.formattedCurrentDate.value}",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.black_04,maxLines: 2,textAlign: TextAlign.start),

                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),

                      /// Feel Nervous
                      if(moodTitle=="Feel Nervous")
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// Feel Nervous static Dua
                            Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    children: [

                                      CustomText(text: "Feel Nervous",fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
                                      Spacer(),
                                      CustomImage(imageSrc: AppIcons.nervous,width: 32,height: 32,),
                                    ],
                                  ),
                                  SizedBox(height: 6),

                                  CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                  SizedBox(height: 6),

                                  CustomText(text: "Ya Hayyu Ya Qayyum, bi Rahmatika astagheeth.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

                                  SizedBox(height: 6),

                                  CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

                                  CustomText(text: "Allah, the Eternal Refuge.He neither begets nor is born,Nor is there to Him any equivalent.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

                                  SizedBox(height: 6),
                                  CustomText(text: "${moodTrackerController.formattedCurrentDate.value}",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.black_03,maxLines: 1,textAlign: TextAlign.start),

                                ],
                              ),
                            ),

                            SizedBox(
                              height: 12.h,
                            ),

                            CustomText(
                              text: "Mood History",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black_02,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            GestureDetector(
                              onTap: ()async{

                                moodTrackerController.searchSelectDate();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month, color: Colors.orange),
                                  SizedBox(width: 8),

                                  CustomText(
                                    text: "${moodTrackerController.searchSelectedDate.value.isEmpty?"select date": moodTrackerController.searchSelectedDate.value}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  IconButton(
                                    icon: Icon(Icons.arrow_drop_down,size: 28,),
                                    onPressed: () async {
                                      moodTrackerController.searchSelectDate();
                                    },
                                  )
                                ],
                              ),
                            ),

                             ///Mood History Feel Nervous dynamic Dua
                            moodTrackerController.retriveTrackersMoodLoading.value?Center(
                              child: CircularProgressIndicator(
                                color: AppColors.brinkPink1,
                              ),
                            ):moodTrackerController.moodTrackersList.isEmpty?
                            SizedBox(
                              height: MediaQuery.of(context).size.height/4,
                              child: Center(
                                child: CustomText(
                                  text: "no mood yet!!",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.lightRed2,
                                ),
                              ),
                            ):

                            ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: moodTrackerController.moodTrackersList.length,
                                itemBuilder: (BuildContext context,index){

                                  final model = moodTrackerController.moodTrackersList[index];

                                  return  Container(
                                    padding: EdgeInsets.all(12),
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [

                                            CustomText(text: "Feel Anxious",fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
                                            Spacer(),
                                            CustomImage(imageSrc: AppIcons.nervous,width: 32,height: 32,),
                                            //Text(date, style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                        SizedBox(height: 6),
                                        CustomText(text: "${model.title}",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "${model.description}",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "Allah is Sufficient for us, and He is the Best Disposer of affairs.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

                                        SizedBox(height: 6),

                                        CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

                                        CustomText(text: "La ilaha illa Anta, Subhanaka, inni kuntu minaz-zalimeen",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

                                        SizedBox(height: 6),
                                        CustomText(text: "${moodTrackerController.formattedCurrentDate.value}",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.black_04,maxLines: 2,textAlign: TextAlign.start),

                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),

                      /// Feel Depressed
                      if(moodTitle=="Feel Depressed")
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                          ///  Feel Depressed static Dua
                            Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    children: [

                                      CustomText(text: "Feel Depressed",fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
                                      Spacer(),
                                      CustomImage(imageSrc: AppIcons.feeldep,width: 32,height: 32,),
                                    ],
                                  ),
                                  SizedBox(height: 6),

                                  CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                  SizedBox(height: 6),

                                  CustomText(text: "Allah is sufficient for us, and He is the best disposer of affairs.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

                                  SizedBox(height: 6),

                                  CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

                                  CustomText(text: "La ilaha illa Anta, Subhanaka, inni kuntu minaz-zalimeen",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

                                  SizedBox(height: 6),
                                  CustomText(text: "${moodTrackerController.formattedCurrentDate.value}",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.black_03,maxLines: 1,textAlign: TextAlign.start),

                                ],
                              ),
                            ),

                            SizedBox(
                              height: 12.h,
                            ),

                            CustomText(
                              text: "Mood History",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black_02,
                            ),

                            GestureDetector(
                              onTap: ()async{

                                moodTrackerController.searchSelectDate();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month, color: Colors.orange),
                                  SizedBox(width: 8),

                                  CustomText(
                                    text: "${moodTrackerController.searchSelectedDate.value.isEmpty?"select date": moodTrackerController.searchSelectedDate.value}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  IconButton(
                                    icon: Icon(Icons.arrow_drop_down,size: 28,),
                                    onPressed: () async {
                                      moodTrackerController.searchSelectDate();
                                    },
                                  )
                                ],
                              ),
                            ),

                            SizedBox(height: 8),

                          ///Mood History Feel Nervous dynamic Dua
                            ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: moodTrackerController.moodTrackersList.length,
                                itemBuilder: (BuildContext context,index){

                                  final model= moodTrackerController.moodTrackersList[index];

                                  return Container(
                                    padding: EdgeInsets.all(12),
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [

                                            CustomText(text: "Feel Depressed",fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
                                            Spacer(),
                                            CustomImage(imageSrc: AppIcons.feeldep,width: 32,height: 32,),
                                            //Text(date, style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                        SizedBox(height: 6),

                                        CustomText(text: "${model.title}",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "${model.description}",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "Allah is sufficient for us, and He is the best disposer of affairs.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

                                        SizedBox(height: 6),

                                        CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

                                        CustomText(text: "La ilaha illa Anta, Subhanaka, inni kuntu minaz-zalimeen",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

                                        SizedBox(height: 6),
                                        CustomText(text: "${moodTrackerController.formattedCurrentDate.value}",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.black_04,maxLines: 2,textAlign: TextAlign.start),

                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),

                      /// Feel Depressed
                      if(moodTitle=="Feel Happy")
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                          ///Feel Happy static Dua
                            Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    children: [

                                      CustomText(text: "Feel Happy",fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
                                      Spacer(),
                                      CustomImage(imageSrc: AppIcons.feelhap,width: 32,height: 32,),
                                    ],
                                  ),
                                  SizedBox(height: 6),

                                  CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                  SizedBox(height: 6),

                                  CustomText(text: "No matter where you are in life, take a moment to remember Allah.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

                                  SizedBox(height: 6),

                                  CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

                                  CustomText(text: "So remember Me; I will remember you.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

                                  SizedBox(height: 6),
                                  CustomText(text: "${moodTrackerController.formattedCurrentDate.value}",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.black_03,maxLines: 1,textAlign: TextAlign.start),

                                ],
                              ),
                            ),

                            SizedBox(
                              height: 12.h,
                            ),

                            CustomText(
                              text: "Mood History",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black_02,
                            ),

                            GestureDetector(
                              onTap: ()async{

                                moodTrackerController.searchSelectDate();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month, color: Colors.orange),
                                  SizedBox(width: 8),

                                  CustomText(
                                    text: "${moodTrackerController.searchSelectedDate.value.isEmpty?"select date": moodTrackerController.searchSelectedDate.value}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  IconButton(
                                    icon: Icon(Icons.arrow_drop_down,size: 28,),
                                    onPressed: () async {

                                    },
                                  )
                                ],
                              ),
                            ),

                            SizedBox(height: 8),

                        ///Mood History Feel Happy dynamic Dua
                            ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: moodTrackerController.moodTrackersList.length,
                                itemBuilder: (BuildContext context,index){

                                  final model = moodTrackerController.moodTrackersList[index];

                                  return Container(
                                    padding: EdgeInsets.all(12),
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [

                                            CustomText(text: "Feel Happy",fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
                                            Spacer(),
                                            CustomImage(imageSrc: AppIcons.feelhap,width: 32,height: 32,),
                                            //Text(date, style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                        SizedBox(height: 6),

                                        CustomText(text: "${model.title}",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "${model.description}",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "No matter where you are in life, take a moment to remember Allah.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

                                        SizedBox(height: 6),

                                        CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

                                        CustomText(text: "La ilaha illa Anta, Subhanaka, inni kuntu minaz-zalimeen",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

                                        SizedBox(height: 6),
                                        CustomText(text: "${moodTrackerController.formattedCurrentDate.value}",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.black_04,maxLines: 2,textAlign: TextAlign.start),

                                      ],
                                    ),
                                  );
                                }),

                          ],
                        ),

                      /// Feel Excited
                      if(moodTitle=="Feel Excited")
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            ///Feel Excited static Dua
                            Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    children: [

                                      CustomText(text: "Feel Excited",fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
                                      Spacer(),
                                      CustomImage(imageSrc: AppIcons.feelex,width: 32,height: 32,),
                                    ],
                                  ),
                                  SizedBox(height: 6),

                                  CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                  SizedBox(height: 6),

                                  CustomText(text: "How amazing is it that the King of the heavens and the earth promises to remember you.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

                                  SizedBox(height: 6),

                                  CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

                                  CustomText(text: "This verse is a direct and beautiful promise from Allah — when you take a moment to remember Him.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

                                  SizedBox(height: 6),
                                  CustomText(text: "${moodTrackerController.formattedCurrentDate.value}",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.black_03,maxLines: 1,textAlign: TextAlign.start),

                                ],
                              ),
                            ),

                            SizedBox(
                              height: 12.h,
                            ),

                            CustomText(
                              text: "Mood History",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black_02,
                            ),

                            GestureDetector(
                              onTap: ()async{

                                moodTrackerController.searchSelectDate();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month, color: Colors.orange),
                                  SizedBox(width: 8),

                                  CustomText(
                                    text: "${moodTrackerController.searchSelectedDate.value.isEmpty?"select date": moodTrackerController.searchSelectedDate.value}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  IconButton(
                                    icon: Icon(Icons.arrow_drop_down,size: 28,),
                                    onPressed: () async {
                                      moodTrackerController.searchSelectDate();
                                    },
                                  )
                                ],
                              ),
                            ),

                            SizedBox(height: 8),

                            ///Mood History Feel Excited dynamic Dua
                            ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: moodTrackerController.moodTrackersList.length,
                                itemBuilder: (BuildContext context,index){

                                  final model =moodTrackerController.moodTrackersList[index];

                                  return   Container(
                                    padding: EdgeInsets.all(12),
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [

                                            CustomText(text: "Feel Excited",fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
                                            Spacer(),
                                            CustomImage(imageSrc: AppIcons.feelex,width: 32,height: 32,),
                                            //Text(date, style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                        SizedBox(height: 6),

                                        CustomText(text: "${model.title}",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "${model.description}",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
                                        SizedBox(height: 6),

                                        CustomText(text: "No matter where you are in life, take a moment to remember Allah.",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

                                        SizedBox(height: 6),

                                        CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

                                        CustomText(text: "La ilaha illa Anta, Subhanaka, inni kuntu minaz-zalimeen",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

                                        SizedBox(height: 6),
                                        CustomText(text: "${moodTrackerController.formattedCurrentDate.value}",fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.black_04,maxLines: 2,textAlign: TextAlign.start),

                                      ],
                                    ),
                                  );
                                })

                          ],
                        ),
                    ],
                  );
                }
            ),
          )
        ],
      ), onRefresh: ()async{
        await moodTrackerController.retriveTrackersMood();
      }),
      bottomNavigationBar:
      Obx(() {

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              moodTrackerController.saveTrackersMoodLoading.value?CircularProgressIndicator():
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {

                      if(moodTrackerController.descriptionController.value.text==""){
                        Toast.errorToast("description is empty!!");
                      }else{

                        moodTrackerController.saveTrackersMood(moodTitle);
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brinkPink,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Add',style: TextStyle(color: AppColors.white),),
                  ),
                ),
              ),

            ],
          );
        }
      ),
    );
  }
}


// Custom Widget for Mood Card
class MoodCard extends StatelessWidget {
  final String emotion;
  final String advice;
  final String dua;
  final String date;


  const MoodCard({
    Key? key,
    required this.emotion,
    required this.advice,
    required this.dua,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.brinkPink.withOpacity(0.3), // Approx from screenshot
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [

              CustomText(text: emotion,fontWeight: FontWeight.bold,fontSize: 16.sp,color: AppColors.green,),
              Spacer(),
              Image.asset(AppIcons.face1)
              //Text(date, style: TextStyle(fontSize: 12)),
            ],
          ),
          SizedBox(height: 8),

          CustomText(text: "Spiritual Advice",fontWeight: FontWeight.w600,fontSize: 14.sp,color: AppColors.purple,),
          SizedBox(height: 6),

          CustomText(text: advice,fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start,),

          SizedBox(height: 6),

          CustomText(text: "Dua for You",fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.black_03,),

          CustomText(text: dua,fontWeight: FontWeight.w600,fontSize: 12.sp,color: AppColors.grey_1,maxLines: 2,textAlign: TextAlign.start),

        ],
      ),
    );
  }
}
