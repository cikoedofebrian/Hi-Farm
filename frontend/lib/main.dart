import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/bindings/controller_binding.dart';
import 'package:hifarm/views/screens/authentication/login_screen.dart';
import 'package:hifarm/views/screens/authentication/onboarding_screen.dart';
import 'package:hifarm/views/screens/authentication/register_screen.dart';
import 'package:hifarm/views/screens/features/home/feed/add_new_post.dart';
import 'package:hifarm/views/screens/features/home/feed/add_post_location.dart';
import 'package:hifarm/views/screens/features/home/feed/post_details.dart';
import 'package:hifarm/views/screens/features/home/home.dart';
import 'package:get/get.dart';
import 'package:hifarm/views/screens/features/home/news/news_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinding(),
      title: 'Hi-Farm',
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleSmall: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          labelSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
          labelMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        ),
        primaryColor: AppColor.secondary,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColor.formColor,
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
          name: onboardingScreen,
          page: () => const OnboardingScreen(),
        ),
        GetPage(
          name: loginScreen,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: registerScreen,
          page: () => const RegisterScreen(),
        ),
        GetPage(
          name: newsDetails,
          page: () => const NewsDetails(),
        ),
        GetPage(
          name: homeScreen,
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: addNewPost,
          page: () => const AddNewPost(),
        ),
        GetPage(
          name: postDetails,
          page: () => const PostDetails(),
        ),
        GetPage(
          name: addPostLocation,
          page: () => const AddPostLocation(),
        )
      ],
    );
  }
}
