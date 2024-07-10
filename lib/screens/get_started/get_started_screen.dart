import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simply_poem/utils/app_text.dart';
import 'package:simply_poem/utils/constants/assets.dart';
import 'package:simply_poem/utils/constants/pallete.dart';
import 'package:simply_poem/widgets/buttonWidget.dart';

import '../login_and_authentication/login.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(vertical: 20.h),
        child: ButtonWidget(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          },
          text: AppText.getStarted,
        ),
      ),
      backgroundColor: Pallete.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(CustomAssets.getStartedIcon),
        ],
      ),
    );
  }
}
