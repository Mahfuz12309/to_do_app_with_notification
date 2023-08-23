import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app_with_notification/default/utils/constants.dart';
import 'package:to_do_app_with_notification/default/widgets/appstyle.dart';
import 'package:to_do_app_with_notification/default/widgets/height_spacer.dart';
import 'package:to_do_app_with_notification/default/widgets/reueable_text.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AppConst.kheight,
        width: AppConst.kwidth,
        color: AppConst.kwhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset("assets/images/todo for app.png"),
            ),
            HeightSpacer(hight: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReusableText(
                  text: "EaseTask",
                  style: appstyle(40, AppConst.kbluelight, FontWeight.bold),
                ),
                const HeightSpacer(hight: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    "Welcome!Add your task fast and with ease to track",
                    textAlign: TextAlign.center,
                    style: appstyle(18, AppConst.kblack, FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
