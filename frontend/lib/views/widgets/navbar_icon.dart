import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/controllers/homecontroller.dart';
import 'package:hifarm/views/widgets/navbar_indicator.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class NavbarIcon extends StatelessWidget {
  const NavbarIcon({
    super.key,
    required this.index,
    required this.icon,
    required this.text,
    this.size,
  });

  final int index;
  final String icon;
  final String text;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return InkWell(
      onTap: () => homeController.changeIndex(index),
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavbarIndicator(isSelected: homeController.selectedIndex == index),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Iconify(
                  icon,
                  size: size ?? 24,
                  color: tertiary,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  text,
                  style: const TextStyle(fontSize: 12, color: tertiary),
                ),
              ],
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
