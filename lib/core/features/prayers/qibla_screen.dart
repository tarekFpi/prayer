
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:prayer_app/core/components/custom_text/custom_text.dart';
import 'package:prayer_app/core/components/nav_bar/nav_bar.dart';
import 'package:prayer_app/core/features/profile/profile_controller.dart';
import 'package:prayer_app/core/utils/app_icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_qiblah/flutter_qiblah.dart';



class QiblaDirectionScreen extends StatefulWidget {
  const QiblaDirectionScreen({super.key});

  @override
  State<QiblaDirectionScreen> createState() => _QiblaDirectionScreenState();
}

class _QiblaDirectionScreenState extends State<QiblaDirectionScreen> {

  final profileController = Get.put(ProfileController());

  var direction = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "Qibla",),

      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    ///Qibla heading
                    CustomText(text: "Find the Qibla direction",fontSize: 18.sp,fontWeight: FontWeight.w600),
                    SizedBox(height: 30),

                   // CustomImage(imageSrc: AppIcons.qibla1),

                    StreamBuilder<QiblahDirection>(
                      stream: FlutterQiblah.qiblahStream,
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) return CircularProgressIndicator();

                        var qiblahDirection = snapshot.data!;
                        final compassAngle = qiblahDirection.direction;
                        final qiblahAngle = qiblahDirection.qiblah;

                        direction = qiblahDirection.direction;

                        // Difference = angle to rotate Qibla needle
                        final needleRotation = (qiblahAngle - compassAngle) * (pi / 180);

                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            // Compass background rotates with heading
                            Transform.rotate(
                              angle: -compassAngle * (pi / 180),
                              child: SvgPicture.asset('assets/images/compass_background.svg'),
                            ),

                            SizedBox(
                              width: 200,
                              child: Transform.rotate(
                              angle: -compassAngle * (pi / 180),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                 Stack(
                                   alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [

                                       Positioned(
                                          right: 140,
                                          bottom: -25,
                                          child: Transform.rotate(
                                        angle: -compassAngle * (pi / 180), // this points to Mecca!
                                        child: CustomImage(
                                          imageSrc: AppIcons.qibla2,width: 70,height: 70,
                                        ),
                                      )),

                                     ///arrow_back
                                   /// Icon(Icons.arrow_back,color: Colors.black,size: 32,),

                                      Padding(
                                        padding: const EdgeInsets.only(right: 55),
                                        child: SvgPicture.asset(AppIcons.arrow_icon,),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                                                        ),
                            )

                            // Optional: center dot
                         //   Icon(Icons.circle, size: 8, color: Colors.black),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 30),

                    ///Location, direction, distance info
                    Obx(
                        () {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            CustomText(text: "Current Location: ${profileController.currentAddress.value}",fontSize: 14,
                             maxLines: 3,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 8),

                            CustomText(text: "Direction: ${direction.round()}",fontSize: 14.sp,),
                            SizedBox(height: 8),

                           // CustomText(text: "Distance: 4,184 km to Kaaba",fontSize: 14.sp,),


                          ],
                        );
                      }
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 4),
    );
  }
}




