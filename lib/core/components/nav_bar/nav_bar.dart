// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/features/fitness/fitness_screen.dart';
import 'package:prayer_app/core/features/home/home_screen.dart';
import 'package:prayer_app/core/features/journal/journal_screen.dart';
import 'package:prayer_app/core/features/prayers/prayers_screen.dart';
import 'package:prayer_app/core/features/prayers/qibla_screen.dart';

import 'package:prayer_app/core/mytest_screen.dart';
import 'package:prayer_app/core/utils/app_colors/app_colors.dart';
import 'package:prayer_app/core/utils/app_icons/app_icons.dart';
import 'package:prayer_app/core/utils/app_strings/app_strings.dart';



class NavBar extends StatefulWidget {
  final int currentIndex;
  const NavBar({required this.currentIndex, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int bottomNavIndex;

  final List<String> selectedIcon = [
    AppIcons.home,
    AppIcons.journal,
    AppIcons.fitnes,
    AppIcons.prayers,
    AppIcons.qibla,
  ];


  final List<String> unselectedIcon = [
    AppIcons.home,
    AppIcons.journal,
    AppIcons.fitnes,
    AppIcons.prayers,
    AppIcons.qibla,
  ];

  final List<String> userNavText = [
    AppStrings.home,
    AppStrings.journal,
    AppStrings.fitness,
    AppStrings.prayers,
    AppStrings.qibla,
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        final isTablet = constraints.maxWidth > 600;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
            color: AppColors.white_50,
            borderRadius: BorderRadius.only(
                topLeft:Radius.circular(50),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)
            ),
          ),
          height: 80.h, // Adjust height for tablets
          width: constraints.maxWidth,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Equal spacing
            children: List.generate(
              selectedIcon.length,
                  (index) => Expanded( // Ensures even distribution
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (index == bottomNavIndex)
                        _buildSelectedNavItem(index, isTablet)
                      else
                        _buildUnselectedNavItem(index, isTablet),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// **Selected Navigation Item (Highlighted Button)**
  Widget _buildSelectedNavItem(int index, bool isTablet) {
    return Card(
      elevation: 70,
      shadowColor: AppColors.brinkPink,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft:Radius.circular(50),
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12)
        ),
      ),
      color: Colors.transparent,
      child: Container(
        height: 70.h,
        width:  70.w,
        decoration: BoxDecoration(
          color: AppColors.brinkPink,
          borderRadius:  BorderRadius.only(
              topLeft:Radius.circular(50),
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              selectedIcon[index],
              height:24.h,
              width: 24.w,
              color: AppColors.white_50,
            ),

            SizedBox(height: 6),
            CustomText(
              text: userNavText[index],
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              fontSize: isTablet ? 6.sp : 12.w,
            ),
          ],
        ),
      ),
    );
  }

  /// **Unselected Navigation Item**
  Widget _buildUnselectedNavItem(int index, bool isTablet) {
    return Column(
      children: [
        SvgPicture.asset(
          unselectedIcon[index],
          height: 24.h,
          width: 24.w,
          color: AppColors.grey_1,
        ),
        SizedBox(height: 4),
        CustomText(
          text: userNavText[index],
          color: AppColors.grey_1,
          fontWeight: FontWeight.w600,
          fontSize: isTablet ? 6.sp : 12.sp,
        ),
      ],
    );
  }

  /// **Navigation Tap Logic**
  void onTap(int index) {
    if (index != bottomNavIndex) {
      switch (index) {
        case 0:
          Get.offAll(() => HomeScreen());
          break;
        case 1:
          Get.offAll(() => JournalScreen());
          break;
        case 2:
           Get.offAll(() => FitnessScreen());
         // Get.offAll(() => BarChartWeek());
          break;
        case 3:
          Get.offAll(() => PrayersScreen());
          break;

        case 4:
           Get.offAll(() => QiblaDirectionScreen());

         // Get.offAll(() => QiblaCompass());
          break;
      }
    }
  }
}
