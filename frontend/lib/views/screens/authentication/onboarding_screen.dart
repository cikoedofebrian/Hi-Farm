import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/image_string.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/auth_controller.dart';
import 'package:hifarm/models/page_data/onboarding_model.dart';
import 'package:hifarm/views/screens/features/home/home.dart';
import 'package:hifarm/views/widgets/dot_indicator.dart';
import '../../widgets/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _pageIndex = 0;

  late Future future;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    future = authController.tryAutoLogin();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<OnboardingModel> onboardingData = [
    OnboardingModel(
      title: 'Berbagi ke Umum',
      content:
          'Petani dapat sharing keluh kesah mereka selama menanam tanamannya ke publik.',
      image: onboardingImage1,
    ),
    OnboardingModel(
      title: 'Menjual Produk',
      content:
          'Petani dapat menjual hasil pertaniannya baik ke konsumen maupun distributor.',
      image: onboardingImage2,
    ),
    OnboardingModel(
      title: 'Pengetahuan',
      content:
          'Melalui aplikasi ini petani akan mendapatkan pengetahuan baru melalui artikel-artikel yang disediakan.',
      image: onboardingImage3,
    ),
  ];

  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: future,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (authController.token.isNotEmpty) {
                return const HomeScreen();
              }
              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (value) => setState(() {
                        _pageIndex = value;
                      }),
                      itemBuilder: (context, index) => OnboardingContent(
                          title: onboardingData[index].title,
                          content: onboardingData[index].content,
                          image: onboardingData[index].image),
                      itemCount: onboardingData.length,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              onboardingData.length,
                              (index) =>
                                  DotIndicator(isActive: _pageIndex == index)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_pageController.page == 2) {
                              Get.toNamed(
                                loginScreen,
                              );
                              return;
                            }
                            _pageController.nextPage(
                              curve: Curves.ease,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          child: Container(
                            width: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 1, color: AppColor.secondary),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: AppColor.primary,
                              radius: 32,
                              child: CircleAvatar(
                                radius: 26,
                                backgroundColor: AppColor.secondary,
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
