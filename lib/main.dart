import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_app_with_notification/default/utils/constants.dart';
import 'package:to_do_app_with_notification/spcial_feature/onboarding/pages/onboarding.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 825),
      minTextAdapt: true,
      builder: (context,child) {
        return MaterialApp(
          title: 'To Do App with notification',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppConst.kblack,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true
          ),
          themeMode: ThemeMode.dark,
          home: const OnBoarding(),
        );
      }
    );
  }
}
