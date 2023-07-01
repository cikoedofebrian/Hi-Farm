import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/app_theme.dart';
import 'package:hifarm/constants/get_page_route.dart';
import 'package:hifarm/controllers/bindings/controller_binding.dart';
import 'package:hifarm/views/screens/authentication/onboarding_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: AppColor.secondary, // status bar color
  ));
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme: darkAppTheme,
      themeMode: ThemeMode.light,
      initialBinding: ControllerBinding(),
      title: 'Hi-Farm',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
      home: const OnboardingScreen(),
      getPages: pageRoute,
    );
  }
}
