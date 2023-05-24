import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/views/screens/authentication/login_screen.dart';
import 'package:hifarm/views/screens/authentication/register_screen.dart';
import 'package:hifarm/views/screens/features/home/home.dart';
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
          titleSmall: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          titleMedium: TextStyle(fontSize: 14),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          labelSmall: TextStyle(fontWeight: FontWeight.w600, fontSize: 9),
        ),
        primaryColor: secondary,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: formColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
      home: const OnboardingScreen(),
      getPages: [
        GetPage(
          name: loginScreen,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: registerScreen,
          page: () => const RegisterScreen(),
        ),
        GetPage(name: homeScreen, page: () => const HomeScreen()),
      ],
    );
  }
}
