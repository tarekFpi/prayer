
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/core/components/custom_button/custom_button.dart';
import 'package:prayer_app/core/components/custom_from_card/custom_from_card.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/components/nav_bar/nav_bar.dart';
import 'package:prayer_app/core/features/journal/journal_controller.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_icons/app_icons.dart';
import 'package:prayer_app/core/utils/toast.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {


  final journalController = Get.put(JournalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.all(8),
            contentPadding: EdgeInsets.all(8),
            ///clipBehavior: Clip.antiAliasWithSaveLayer,
            title:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const CustomText(
                  text: "",
                  fontSize: 12,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  bottom: 8,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {

                        Navigator.of(context).pop();
                        journalController.reflectionController.value.clear();
                        journalController.goalsController.value.clear();
                        journalController.challengesController.value.clear();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 32,
                        color: Colors.black,
                      )),
                )
              ],
            ),
            content: Obx((){

              return SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height/1.4,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          CustomText(text: "Today’s Reflection",fontSize: 16.sp,fontWeight: FontWeight.w600,color: AppColors.black_04,),

                          /// Heading TextField
                          TextField(
                            controller: journalController.reflectionController.value,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: "reflection |",
                              hintStyle: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),

                          SizedBox(
                            height: 12,
                          ),
                          CustomText(text: "Goals for the Day",fontSize: 16.sp,fontWeight: FontWeight.w600,color: AppColors.black_04,),

                          /// Heading body
                          TextField(
                            controller: journalController.goalsController.value,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: "goals |",
                              hintStyle: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),


                          SizedBox(
                            height: 12,
                          ),
                          CustomText(text: "Challenges Faced",fontSize: 16.sp,fontWeight: FontWeight.w600,color: AppColors.black_04,),

                          /// Heading body
                          TextField(
                            controller: journalController.challengesController.value,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: "challenges |",
                              hintStyle: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),

                      journalController.journalCreateLoading.value?CircularProgressIndicator(
                        color: AppColors.brinkPink1,
                      ):
                      Padding(
                        padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
                        child:CustomButton(
                          onTap: () {

                            if(journalController.reflectionController.value.text==""){
                              Toast.errorToast("reflection is Empty!!");
                            }else if(journalController.goalsController.value.text==""){
                              Toast.errorToast("goals is Empty!!");
                            }else if(journalController.challengesController.value.text==""){
                              Toast.errorToast("challenges is Empty!!");
                            }else{
                              journalController.journalCreate();

                              if(journalController.journalCreateLoading.value){

                                Navigator.of(context).pop();
                              }
                            }

                          },
                          title: "Create",
                          height: 60.h,
                          textColor: AppColors.black,
                          fillColor: AppColors.brinkPink,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );

      },child: Icon(Icons.add,size: 28,color: Colors.white,),backgroundColor: AppColors.brinkPink,),

      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "My Journal",),

      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Obx(
           () {
            return RefreshIndicator(child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Date Row
                    GestureDetector(
                      onTap: ()async{

                        journalController.selectJournalDate();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month, color: Colors.orange),
                          SizedBox(width: 8),
                          Text(
                              '${journalController.formattedStartDate.value=="select date"?journalController.formattedCurrentDate.value:journalController.formattedStartDate.value}',
                              //style: TextStyle(fontWeight: FontWeight.w600,),
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                decorationColor: Colors.black,
                                decorationThickness: 2,
                              )
                          ),

                          IconButton(
                            icon: Icon(Icons.arrow_drop_down,size: 28,),
                            onPressed: () async {

                            },
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 12),

                    /// Today's Reflection
                    journalController.retriveJournalsLoading.value?Center(child: CircularProgressIndicator(color: AppColors.brinkPink1,)):
                    journalController.retriveAJournalLList.isEmpty?
                    SizedBox(
                      height: MediaQuery.of(context).size.height/3,
                      child: Center(
                        child: CustomText(
                          text: "No journal yet!!",
                          fontSize:18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightRed,
                        ),
                      ),
                    ):
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: journalController.retriveAJournalLList.length,
                        itemBuilder: (BuildContext context, index){

                          final model =journalController.retriveAJournalLList[0];

                          if(index==0){
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      CustomText(text: "Today’s Reflection",fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.black_04,
                                        textAlign: TextAlign.start,maxLines: 2,),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      index==0? Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.brinkPink1,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.white, // Shadow color
                                                spreadRadius: 3, // Spread the shadow
                                                offset: Offset(0, 4), // Shadow position
                                              ),
                                            ]
                                        ),
                                        child:  Padding(padding:EdgeInsets.all(16),
                                          child: Row(
                                          children: [

                                            Expanded(
                                              child: CustomText(text: "${model.reflection}",fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.white,
                                                textAlign: TextAlign.start,maxLines: 2,),
                                            ),

                                            SizedBox(width: 8),
                                            GestureDetector(
                                                onTap: (){

                                                  journalController.reflectionController.value.text=model.reflection.toString();
                                                  journalController.goalsController.value.text=model.goals.toString();
                                                  journalController.challengesController.value.text=model.challenges.toString();

                                                  showDialog(
                                                    context: Get.context!,
                                                    barrierDismissible: false,
                                                    builder: (ctx) => AlertDialog(
                                                      backgroundColor: Colors.white,
                                                      insetPadding: EdgeInsets.all(8),
                                                      contentPadding: EdgeInsets.all(8),
                                                      ///clipBehavior: Clip.antiAliasWithSaveLayer,
                                                      title:Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [

                                                          const CustomText(
                                                            text: "",
                                                            fontSize: 12,
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.w500,
                                                            bottom: 8,
                                                          ),

                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: InkWell(
                                                                onTap: () {

                                                                  Navigator.of(context).pop();
                                                                  journalController.reflectionController.value.clear();
                                                                  journalController.goalsController.value.clear();
                                                                  journalController.challengesController.value.clear();
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  size: 32,
                                                                  color: Colors.black,
                                                                )),
                                                          )
                                                        ],
                                                      ),
                                                      content: SingleChildScrollView(
                                                        child: SizedBox(
                                                          width: MediaQuery.sizeOf(context).width,
                                                          height: MediaQuery.sizeOf(context).height/3,

                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [


                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [

                                                                  CustomText(text: "Today’s Reflection",fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.black_04,),

                                                                  /// Heading TextField
                                                                  TextField(
                                                                    controller: journalController.reflectionController.value,
                                                                    style: TextStyle(
                                                                      fontSize: 14.sp,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Colors.black,
                                                                    ),
                                                                    decoration: InputDecoration(
                                                                      hintText: "reflection |",
                                                                      hintStyle: TextStyle(
                                                                        fontSize: 18.sp,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Colors.grey,
                                                                      ),
                                                                      border: InputBorder.none,
                                                                    ),
                                                                    maxLines: 2,
                                                                  ),

                                                                /*         SizedBox(
                                                                    height: 12,
                                                                  ),
                                                                  CustomText(text: "Goals for the Day",fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.black_04,),

                                                                  /// Heading body
                                                                  TextField(
                                                                    controller: journalController.goalsController.value,
                                                                    style: TextStyle(
                                                                      fontSize: 14.sp,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Colors.black,
                                                                    ),
                                                                    decoration: InputDecoration(
                                                                      hintText: "goals |",
                                                                      hintStyle: TextStyle(
                                                                        fontSize: 18.sp,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Colors.grey,
                                                                      ),
                                                                      border: InputBorder.none,
                                                                    ),
                                                                    maxLines: 2,
                                                                  ),


                                                                  SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  CustomText(text: "Challenges Faced",fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.black_04,),

                                                                  /// Heading body
                                                                  TextField(
                                                                    controller: journalController.challengesController.value,
                                                                    style: TextStyle(
                                                                      fontSize: 14.sp,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Colors.black,
                                                                    ),
                                                                    decoration: InputDecoration(
                                                                      hintText: "challenges |",
                                                                      hintStyle: TextStyle(
                                                                        fontSize: 18.sp,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Colors.grey,
                                                                      ),
                                                                      border: InputBorder.none,
                                                                    ),
                                                                    maxLines: 2,
                                                                  ),*/
                                                                ],
                                                              ),


                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
                                                                child:CustomButton(
                                                                  onTap: () {

                                                                    if(journalController.reflectionController.value.text==""){
                                                                      Toast.errorToast("reflection is Empty!!");
                                                                    }
                                                                    else{

                                                                      journalController.journalUpdate(model.id.toString());

                                                                      if(journalController.journalUpdateLoading.value){
                                                                        Navigator.of(context).pop();
                                                                      }
                                                                    }
                                                                  },
                                                                  title: "Update",
                                                                  height: 60.h,
                                                                  textColor: AppColors.black,
                                                                  fillColor: AppColors.brinkPink,
                                                                  fontSize: 14.sp,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: CustomImage(imageSrc: AppIcons.edit,width: 24,)),

                                            SizedBox(width: 16),

                                            journalController.journalDeleteLoading.value?CircularProgressIndicator(
                                              color: AppColors.brinkPink1,
                                            ):
                                            GestureDetector(
                                                onTap: (){
                                             journalController.journalDelete(model.id.toString());

                                             },
                                            child: Icon(Icons.delete, size: 24, color: Colors.white)),
                                          ],
                                        ),),
                                      ):CustomText(text: "${model.reflection}",fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.black_04,
                                        textAlign: TextAlign.start,maxLines: 2,),

                                    ],
                                  ),


                                  SizedBox(
                                    height: 22.h,
                                  ),

                                  CustomText(text: "Goals for the Day",fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.black_04,
                                    textAlign: TextAlign.start,maxLines: 2,),
                                  SizedBox(
                                    height: 8.h,
                                  ),

                                  Container(
                                    width: double.infinity,

                                    decoration: BoxDecoration(
                                      // color: backgroundColor ?? Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.grey_5.withOpacity(0.2), // Shadow color
                                            spreadRadius: 3, // Spread the shadow
                                            offset: Offset(0, 4), // Shadow position
                                          ),
                                        ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Expanded(
                                                child: CustomText(text: ". ${model.goals}",fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,color: Colors.black,textAlign: TextAlign.start,maxLines: 2,),
                                              ),

                                              SizedBox(width: 8),
                                              GestureDetector(
                                                  onTap: (){

                                                    //journalController.reflectionController.value.text=model.reflection.toString();
                                                    journalController.goalsController.value.text=model.goals.toString();
                                                   // journalController.challengesController.value.text=model.challenges.toString();

                                                    showDialog(
                                                      context: Get.context!,
                                                      barrierDismissible: false,
                                                      builder: (ctx) => AlertDialog(
                                                        backgroundColor: Colors.white,
                                                        insetPadding: EdgeInsets.all(8),
                                                        contentPadding: EdgeInsets.all(8),
                                                        ///clipBehavior: Clip.antiAliasWithSaveLayer,
                                                        title:Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [

                                                            const CustomText(
                                                              text: "",
                                                              fontSize: 12,
                                                              color: AppColors.black,
                                                              fontWeight: FontWeight.w500,
                                                              bottom: 8,
                                                            ),

                                                            Align(
                                                              alignment: Alignment.centerRight,
                                                              child: InkWell(
                                                                  onTap: () {

                                                                    Navigator.of(context).pop();
                                                                    //journalController.reflectionController.value.clear();
                                                                    journalController.goalsController.value.clear();
                                                                   // journalController.challengesController.value.clear();
                                                                  },
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    size: 32,
                                                                    color: Colors.black,
                                                                  )),
                                                            )
                                                          ],
                                                        ),
                                                        content: SingleChildScrollView(
                                                          child: SizedBox(
                                                            width: MediaQuery.sizeOf(context).width,
                                                            height: MediaQuery.sizeOf(context).height/3,

                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [


                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [


                                                                    CustomText(text: "Goals for the Day",fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.black_04,),

                                                                    /// Heading body
                                                                    TextField(
                                                                      controller: journalController.goalsController.value,
                                                                      style: TextStyle(
                                                                        fontSize: 14.sp,
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.black,
                                                                      ),
                                                                      decoration: InputDecoration(
                                                                        hintText: "goals |",
                                                                        hintStyle: TextStyle(
                                                                          fontSize: 18.sp,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Colors.grey,
                                                                        ),
                                                                        border: InputBorder.none,
                                                                      ),
                                                                      maxLines: 2,
                                                                    ),

                                                                  ],
                                                                ),

                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
                                                                  child:CustomButton(
                                                                    onTap: () {


                                                                      if(journalController.goalsController.value.text==""){
                                                                        Toast.errorToast("goal is Empty!!");
                                                                      }
                                                                      else{

                                                                        journalController.journalUpdate(model.id.toString());

                                                                        if(journalController.journalUpdateLoading.value){
                                                                          Navigator.of(context).pop();
                                                                        }
                                                                      }
                                                                    },
                                                                    title: "Update",
                                                                    height: 60.h,
                                                                    textColor: AppColors.black,
                                                                    fillColor: AppColors.brinkPink,
                                                                    fontSize: 14.sp,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: CustomImage(imageSrc: AppIcons.edit,width: 24,)),

                                              SizedBox(width: 16),

                                              journalController.journalDeleteLoading.value?CircularProgressIndicator(
                                                color: AppColors.brinkPink1,
                                              ):
                                              GestureDetector(
                                                  onTap: (){
                                                    journalController.journalDelete(model.id.toString());

                                                  },
                                                  child: Icon(Icons.delete, size: 24, color: Colors.grey.shade700)),
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 22.h,
                                  ),

                                  CustomText(text: "Challenges Faced",fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.black_04,
                                    textAlign: TextAlign.start,maxLines: 2,),

                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      // color: backgroundColor ?? Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.grey_5.withOpacity(0.2), // Shadow color
                                            spreadRadius: 3, // Spread the shadow
                                            offset: Offset(0, 4), // Shadow position
                                          ),
                                        ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Expanded(
                                                  child: CustomText(text: ". ${model.challenges}",fontSize: 14.sp,fontWeight: FontWeight.w400,color: Colors.black,textAlign: TextAlign.start,maxLines: 3,)),

                                              SizedBox(width: 8),
                                              GestureDetector(
                                                  onTap: (){

                                                    journalController.challengesController.value.text=model.challenges.toString();

                                                    showDialog(
                                                      context: Get.context!,
                                                      barrierDismissible: false,
                                                      builder: (ctx) => AlertDialog(
                                                        backgroundColor: Colors.white,
                                                        insetPadding: EdgeInsets.all(8),
                                                        contentPadding: EdgeInsets.all(8),
                                                        ///clipBehavior: Clip.antiAliasWithSaveLayer,
                                                        title:Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [

                                                            const CustomText(
                                                              text: "",
                                                              fontSize: 12,
                                                              color: AppColors.black,
                                                              fontWeight: FontWeight.w500,
                                                              bottom: 8,
                                                            ),

                                                            Align(
                                                              alignment: Alignment.centerRight,
                                                              child: InkWell(
                                                                  onTap: () {

                                                                    Navigator.of(context).pop();
                                                                   // journalController.reflectionController.value.clear();
                                                                   // journalController.goalsController.value.clear();
                                                                    journalController.challengesController.value.clear();
                                                                  },
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    size: 32,
                                                                    color: Colors.black,
                                                                  )),
                                                            )
                                                          ],
                                                        ),
                                                        content: SingleChildScrollView(
                                                          child: SizedBox(
                                                            width: MediaQuery.sizeOf(context).width,
                                                            height: MediaQuery.sizeOf(context).height/3,

                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [


                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [

                                                               /*     CustomText(text: "Today’s Reflection",fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.black_04,),

                                                                    /// Heading TextField
                                                                    TextField(
                                                                      controller: journalController.reflectionController.value,
                                                                      style: TextStyle(
                                                                        fontSize: 14.sp,
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.black,
                                                                      ),
                                                                      decoration: InputDecoration(
                                                                        hintText: "reflection |",
                                                                        hintStyle: TextStyle(
                                                                          fontSize: 18.sp,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Colors.grey,
                                                                        ),
                                                                        border: InputBorder.none,
                                                                      ),
                                                                      maxLines: 2,
                                                                    ),


                                                                    SizedBox(
                                                                      height: 12,
                                                                    ),
                                                                    CustomText(text: "Goals for the Day",fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.black_04,),

                                                                    /// Heading body
                                                                    TextField(
                                                                      controller: journalController.goalsController.value,
                                                                      style: TextStyle(
                                                                        fontSize: 14.sp,
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.black,
                                                                      ),
                                                                      decoration: InputDecoration(
                                                                        hintText: "goals |",
                                                                        hintStyle: TextStyle(
                                                                          fontSize: 18.sp,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Colors.grey,
                                                                        ),
                                                                        border: InputBorder.none,
                                                                      ),
                                                                      maxLines: 2,
                                                                    ),
*/

                                                                    SizedBox(
                                                                      height: 8,
                                                                    ),
                                                                    CustomText(text: "Challenges Faced",fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.black_04,),

                                                                    /// Heading body
                                                                    TextField(
                                                                      controller: journalController.challengesController.value,
                                                                      style: TextStyle(
                                                                        fontSize: 14.sp,
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.black,
                                                                      ),
                                                                      decoration: InputDecoration(
                                                                        hintText: "challenges |",
                                                                        hintStyle: TextStyle(
                                                                          fontSize: 18.sp,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Colors.grey,
                                                                        ),
                                                                        border: InputBorder.none,
                                                                      ),
                                                                      maxLines: 2,
                                                                    ),
                                                                  ],
                                                                ),

                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
                                                                  child:CustomButton(
                                                                    onTap: () {

                                                                    /*  if(journalController.reflectionController.value.text==""){
                                                                        Toast.errorToast("reflection is Empty!!");
                                                                      }else if(journalController.goalsController.value.text==""){
                                                                        Toast.errorToast("goal is Empty!!");
                                                                      }else*/
                                                                      if(journalController.challengesController.value.text==""){
                                                                        Toast.errorToast("challenges is Empty!!");
                                                                      }
                                                                      else{

                                                                        journalController.journalUpdate(model.id.toString());

                                                                        if(journalController.journalUpdateLoading.value){
                                                                          Navigator.of(context).pop();
                                                                        }
                                                                      }
                                                                    },
                                                                    title: "Update",
                                                                    height: 60.h,
                                                                    textColor: AppColors.black,
                                                                    fillColor: AppColors.brinkPink,
                                                                    fontSize: 14.sp,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: CustomImage(imageSrc: AppIcons.edit,width: 24,)),

                                              SizedBox(width: 16),

                                              journalController.journalDeleteLoading.value?CircularProgressIndicator(
                                                color: AppColors.brinkPink1,
                                              ):
                                              GestureDetector(
                                                  onTap: (){
                                                    journalController.journalDelete(model.id.toString());

                                                  },
                                                  child: Icon(Icons.delete, size: 20, color: Colors.grey.shade700)),
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            );
                          }

                        })
                  ],
                )
              ],
            ), onRefresh: ()async{
              await  journalController.searchJournalDateList(journalController.formattedCurrentDate.value);();
            });
          }
        ),
      ),

      bottomNavigationBar: NavBar(currentIndex: 1),
    );
  }
}



