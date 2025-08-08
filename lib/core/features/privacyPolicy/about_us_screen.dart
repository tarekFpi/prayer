import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer_app/core/components/custom_royel_appbar/custom_royel_appbar.dart';


class AboutUSScreen extends StatefulWidget {
  const AboutUSScreen({super.key});

  @override
  State<AboutUSScreen> createState() => _AboutUSScreenState();
}

class _AboutUSScreenState extends State<AboutUSScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(titleName: "About Us",leftIcon: true,
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Privacy Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Terms",
                      style: GoogleFonts.abhayaLibre(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                        "Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. "
                        "Sapien, consequat ultrices morbi orci semper sit nulla. "
                        "Leo auctor ut etiam est, amet aliquet ut vivamus. "
                        "Odio vulputate est id tincidunt fames.",
                    style: GoogleFonts.abhayaLibre(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                        "Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. "
                        "Sapien, consequat ultrices morbi orci semper sit nulla. "
                        "Leo auctor ut etiam est, amet aliquet ut vivamus. "
                        "Odio vulputate est id tincidunt fames.",
                     style: GoogleFonts.abhayaLibre(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                ],
              ),

              SizedBox(height: 8),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. "
                    "Sapien, consequat ultrices morbi orci semper sit nulla. "
                    "Leo auctor ut etiam est, amet aliquet ut vivamus. "
                    "Odio vulputate est id tincidunt fames.",
                style: GoogleFonts.abhayaLibre(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. "
                    "Sapien, consequat ultrices morbi orci semper sit nulla. "
                    "Leo auctor ut etiam est, amet aliquet ut vivamus. "
                    "Odio vulputate est id tincidunt fames.",
                style: GoogleFonts.abhayaLibre(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

}
