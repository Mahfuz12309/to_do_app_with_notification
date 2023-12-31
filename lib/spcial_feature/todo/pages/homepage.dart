import 'package:flutter/material.dart';
import 'package:to_do_app_with_notification/default/utils/constants.dart';
import 'package:to_do_app_with_notification/default/widgets/appstyle.dart';
import 'package:to_do_app_with_notification/default/widgets/reueable_text.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ReusableText(
                text: "Todo ",
                style: appstyle(30, AppConst.kcyan, FontWeight.bold)),
                
      
                ReusableText(
                text: "Todo ",
                style: appstyle(30, AppConst.kcyan, FontWeight.bold)),
      
                ReusableText(
                text: "Todo ",
                style: appstyle(30, AppConst.kcyan, FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}




