import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:hifarm/controllers/home_controller.dart';
import 'package:hifarm/views/widgets/custom_floating_action_button.dart';
import 'package:hifarm/views/widgets/custom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: Stack(
              children: [
                Obx(() => homeController.getPage()),
                KeyboardVisibilityBuilder(builder: (context, isKeyboardActive) {
                  if (!isKeyboardActive) {
                    return Positioned(
                      bottom: 0,
                      left: 0,
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (homeController.selectedIndex == 0)
                              const CustomFloatingActionButton(),
                            const CustomNav(),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}
