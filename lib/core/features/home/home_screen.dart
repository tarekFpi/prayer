import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/core/app_routes/app_routes.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_netwrok_image/custom_network_image.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/components/nav_bar/nav_bar.dart';
import 'package:prayer_app/core/features/fitness/fitness_controller.dart';
import 'package:prayer_app/core/features/home/home_controller.dart';
import 'package:prayer_app/core/features/home/timer_controller%20.dart';
import 'package:prayer_app/core/features/profile/profile_controller.dart';
import 'package:prayer_app/core/features/tracker_mood/mood_tracker_controller.dart';
import 'package:prayer_app/core/helper/time_converter/time_converter.dart';
import 'package:prayer_app/core/service/api_url.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_icons/app_icons.dart';
import 'package:prayer_app/core/utils/app_images/app_images.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:prayer_app/core/components/custom_button/custom_button.dart';
import 'package:prayer_app/core/features/auth/auth_controller.dart';
import 'package:prayer_app/core/utils/app_strings/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime selectedDate = DateTime.now();

  DateTime selectedDate1 = DateTime.now();

  final authController = Get.put(AuthController());

  final homeController = Get.put(HomeController());

  final profileController = Get.put(ProfileController());

  final moodTrackerController = Get.put(MoodTrackerController());

  /// Method to format the selected Gregorian date into Hijri format
  String formatHijriDate(DateTime date) {
    HijriCalendar hijriDate = HijriCalendar.fromDate(date); // Convert to Hijri
    return "${hijriDate.hDay}th ${hijriDate.getLongMonthName()}, ${hijriDate.hYear}h"; // Format as "Day Month Year"
  }

  final prayersIcon = [
    AppIcons.fajr,
    AppIcons.dhuhr,
    AppIcons.asr,
    AppIcons.maghrib,
    AppIcons.isha,
  ];

  final  fitnessController = Get.find<FitnessController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// _buildHeader

                _buildHeader(),

                SizedBox(
                  height: 12.h,
                ),

                homeController.retriveTodayHadithLoading.value
                    ? CircularProgressIndicator(
                        color: AppColors.brinkPink1,
                      ):

                    /// HadithCard
                   Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.brinkPink,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            if (homeController.retriveTodayHadithList.value.source !=null)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text:
                                          "Today’s ${homeController.retriveTodayHadithList.value.source}",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8.h),
                                    CustomText(
                                      text:
                                          "${homeController.retriveTodayHadithList.value.content}.",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      maxLines: 10,
                                      color: AppColors.white,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            if (homeController
                                .retriveTodayHadithList.value.source==null)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Today’s Hadith",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8.h),
                                    CustomText(
                                      text:
                                          "The strong believer is better and more beloved to Allah than the weak believer, while there is good in both. Strive for that which will benefit you, seek the help of Allah, and do not give up. \n .Sahih Muslim, Hadith 64",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      maxLines: 10,
                                      color: AppColors.white,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(width: 8),
                            Image.asset(
                              'assets/icons/mosq1.png',
                              height: 150.h,
                              width: 150.w,
                            ),
                          ],
                        ),
                      ),

                SizedBox(height: 16),

                /// today water is not empty show
                if(homeController.retriveWaterCaloriesList.isNotEmpty)
                Row(
                  children: [
                    _buildCard(
                        title: 'Water',
                        icon: Icons.water_drop_outlined,
                         value: '${homeController.retriveWaterCaloriesList[0].water!=null?homeController.retriveWaterCaloriesList[0].water:0.0}',
                      //  value: '0.0',
                        unit: '3,500 OF ${homeController.water} ML',
                        progress: 0.5,
                        status: true),
                    const SizedBox(width: 12),
                    _buildCard(
                        title: 'Calories',
                        icon: Icons.local_fire_department_outlined,
                        value: '${homeController.retriveWaterCaloriesList[0].calories!=null?homeController.retriveWaterCaloriesList[0].calories:0.0}',
                       // value: '0.0',
                        unit: '2,600 OF ${homeController.calories} KCAL',
                        progress: 0.75,
                        status: false),
                  ],
                ),

                /// Water Calories List empty show
                if(homeController.retriveWaterCaloriesList.isEmpty)
                Row(
                  children: [
                    _buildCard(
                        title: 'Water',
                        icon: Icons.water_drop_outlined,
                        value: '0.0',
                        unit: '3,500 OF ${homeController.water} ML',
                        progress: homeController.water.toDouble(),
                        status: true),
                    const SizedBox(width: 12),
                    _buildCard(
                        title: 'Calories',
                        icon: Icons.local_fire_department_outlined,
                        value: '0.0',
                        unit: '2,600 OF ${homeController.calories} KCAL',
                        progress:homeController.calories.toDouble(),
                        status: false),
                  ],
                ),

                SizedBox(height: 16),


                /// all prayers today time
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(blurRadius: 8, color: Colors.grey.shade300)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "All Prayers Today",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),

                      SizedBox(height: 12),

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

                                           if(model?.isComplete==false){
                                              homeController.prayerUpdate(model?.name??"",model?.time??"",true);
                                            }if(model?.isComplete==true){
                                              homeController.prayerUpdate(model?.name??"",model?.time??"",false);
                                            }
                                            HapticFeedback.lightImpact();
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

                SizedBox(height: 16),

                /// mood tracker
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    //color: AppColors.brinkPink.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(AppImages.bagImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mood Tracker',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              decorationColor: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                            //  Get.toNamed(AppRoutes.trackerModeScreen);
                            },
                            child: Text(
                              'View Details',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFD9A17C),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// Mood Options (Grid Style)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                
                                    Get.toNamed(AppRoutes.trackerModeScreen, arguments: [
                                      {"moodTitle": AppStrings.feelSad}
                                    ]);
                                
                                  },
                                  child: moodButton(AppIcons.feelsad, AppStrings.feelSad, isSelected: true),
                                ),
                              ),

                              SizedBox(width: 8.w),
                              
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                
                                    Get.toNamed(AppRoutes.trackerModeScreen, arguments: [
                                      {"moodTitle": AppStrings.feelAnxious}
                                    ]);
                                
                                  },
                                  child: moodButton(AppIcons.feelan, AppStrings.feelAnxious),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.trackerModeScreen, arguments: [
                                      {"moodTitle": AppStrings.feelNervous}
                                    ]);
                                  },
                                  child: moodButton(AppIcons.nervous, AppStrings.feelNervous),
                                ),
                              ),
                              SizedBox(width: 8.w),

                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                
                                    Get.toNamed(AppRoutes.trackerModeScreen, arguments: [
                                      {"mooodTitle": AppStrings.feelDepressed}
                                    ]);
                                  },
                                  child: moodButton(AppIcons.feeldep, AppStrings.feelDepressed),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.trackerModeScreen, arguments: [
                                      {"moodTitle": AppStrings.feelHappy}
                                    ]);
                                  },
                                  child: moodButton(AppIcons.feelhap, AppStrings.feelHappy),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.trackerModeScreen, arguments: [
                                      {"moodTitle": AppStrings.feelExcited}
                                    ]);
                                  },
                                  child: moodButton(AppIcons.feelex, AppStrings.feelExcited),
                                ),
                              ),
                            ],
                          ), 
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }



  Widget _buildHeader() {
    return Obx(
      () {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi, ${profileController.userProfileShow.value.fullName}!",
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      decorationColor: Colors.grey,
                    )),

                /// Date Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [

                          Text(
                            '${DateFormat('dd MMMM, yyyy').format(selectedDate)}',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          // Icon(Icons.arrow_drop_down, size: 24),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Icon(Icons.calendar_month, color: Colors.orange),
                          // SizedBox(width: 8),

                          Text("${formatHijriDate(selectedDate1)}",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                decorationColor: Colors.grey,
                              )),
                          // Icon(Icons.arrow_drop_down,size: 24,)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {

                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(300.0, 130.0, 0.0, 0.0),
                  color: Colors.white,
                  items: [
                    PopupMenuItem<String>(
                      value: 'profile',
                      child: CustomText(
                          text: "Profile",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                      onTap: () {
                        Get.toNamed(AppRoutes.profileScreen);
                      },
                    ),
                    PopupMenuItem<String>(
                      value: 'setting',
                      child: CustomText(
                        text: "Setting",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      onTap: () {
                        //settingScreen
                        Get.toNamed(AppRoutes.settingScreen);
                      },
                    ),
                    PopupMenuItem<String>(
                      value: 'logOut',
                      child: CustomText(
                        text: "LogOut",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      onTap: () {

                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: Colors.white,
                            insetPadding: EdgeInsets.all(8),
                            contentPadding: EdgeInsets.all(8),
                            title: SizedBox(),
                            content: SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.question_mark),

                                    CustomText(
                                      text: "Are You Sure?",
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black_80,
                                    ),

                                    CustomText(
                                      text: "Do you want to log out ?",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black_80,
                                    ),

                                    ///AppColors.brinkPink
                                    SizedBox(
                                      height: 8.h,
                                    ),

                                    CustomButton(
                                        onTap: () {
                                          Navigator.of(context).pop();

                                          authController.userLogOut();

                                          ///firebase google logout
                                          authController.signOut();
                                        },
                                        title: "Yes",
                                        height: 45.h,
                                        fontSize: 12.sp,
                                        fillColor: AppColors.brinkPink),

                                    SizedBox(
                                      height: 12.h,
                                    ),

                                    CustomButton(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      title: "NO",
                                      height: 45.h,
                                      fontSize: 12.sp,
                                      fillColor: AppColors.white,
                                      textColor: AppColors.brinkPink,
                                      isBorder: true,
                                      borderWidth: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
              child:profileController.userProfileShow.value.image!=null?
              Container(
                height: 64.h,
                width: 64.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  border: Border.all(
                    width: 1,
                    color: AppColors.primary,
                  ),
                  image: DecorationImage(
                    image: NetworkImage("${ApiUrl.imageUrl}/${profileController.userProfileShow.value.image ?? ""}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ):
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            )
          ],
        );
      }
    );
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
      child: GestureDetector(
        onTap: () {
          if (status) {
            Get.toNamed(AppRoutes.waterScreen);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
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
                  CustomText(
                    text: title,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    textAlign: TextAlign.start,
                  ),
                  Icon(icon, color: Color(0xFFD9A17C), size: 20),
                ],
              ),
              const SizedBox(height: 8),
              CustomText(
                text: value,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFFD9A17C),
              ),
              const SizedBox(height: 4),
              CustomText(
                text: unit,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
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
      ),
    );
  }


  /// Mood Button Widget
  Widget moodButton(String icons, String text, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFDF5F0) : Colors.white,
        border: Border.all(
          color: isSelected ? const Color(0xFFD9A17C) : Colors.black12,
          width: isSelected ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      width: 160,
      child: Row(
        children: [
          //Text(emoji, style: const TextStyle(fontSize: 18)),
          CustomImage(imageSrc: icons,width: 24,height: 24,),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: isSelected ? const Color(0xFFD9A17C) : Colors.black87,
                )
            ),
          ),
        ],
      ),
    );
  }
}
