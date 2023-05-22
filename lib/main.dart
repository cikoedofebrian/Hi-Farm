import 'package:flutter/material.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/views/screens/authentication/login_screen.dart';
import 'package:hifarm/views/screens/onboarding_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hi-Farm',
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      home: const OnboardingScreen(),
      getPages: [
        GetPage(
          name: loginScreen,
          page: () => const LoginScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
