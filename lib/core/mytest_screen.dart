import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prayer_app/core/components/custom_image/custom_image.dart';
import 'package:prayer_app/core/utils/app_icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class QiblaCompass extends StatelessWidget {
  const QiblaCompass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QiblahDirection>(
          stream: FlutterQiblah.qiblahStream,
          builder: (_, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

            final qiblahDirection = snapshot.data!;
            final compassAngle = qiblahDirection.direction;
            final qiblahAngle = qiblahDirection.qiblah;


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



                // Qibla arrow points toward Mecca
                /*    Transform.rotate(
               angle: -compassAngle * (pi / 180),
               child: Icon(Icons.arrow_back,color: Colors.white,),
             ),*/

                Transform.rotate(
                  angle: -compassAngle * (pi / 180),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [



                     // Flexible(child: CustomImage(imageSrc: AppIcons.qibla2,width: 65,height: 65,)),

                      Transform.rotate(
                        angle: -compassAngle * (pi / 180), // this points to Mecca!
                        child: CustomImage(
                         imageSrc: AppIcons.qibla2,width: 70,height: 70,
                        ),
                      ),

                       Icon(Icons.arrow_back,color: Colors.black,),


                 /*    Expanded(
                        child: Transform.rotate(
                          angle: -compassAngle * (pi / 180),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(AppIcons.arrow_icon,),
                        ),
                      )*/


                    ],
                  ),
                ),
                // Optional: center dot
             //   Icon(Icons.circle, size: 8, color: Colors.black),
              ],
            );
          },
        ),
      ),
    );
  }
}


