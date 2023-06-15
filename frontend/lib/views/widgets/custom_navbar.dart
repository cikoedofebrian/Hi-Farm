import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/controllers/home_controller.dart';
import 'package:hifarm/views/widgets/navbar_icon.dart';
import 'package:iconify_flutter/icons/teenyicons.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/carbon.dart';

class CustomNav extends StatefulWidget {
  const CustomNav({super.key});

  // final Function(int) onItemTapped;

  @override
  State<CustomNav> createState() => _CustomNavState();
}

class _CustomNavState extends State<CustomNav> {
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 2, color: AppColor.formColor)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavbarIcon(
              index: 0,
              icon: homeController.selectedIndex == 0
                  ? Teenyicons.home_solid
                  : Teenyicons.home_outline,
              text: 'Beranda',
            ),
            NavbarIcon(
              index: 1,
              icon: homeController.selectedIndex == 1
                  ? Teenyicons.shop_solid
                  : Teenyicons.shop_outline,
              text: 'Belanja',
            ),
            NavbarIcon(
              index: 2,
              icon: homeController.selectedIndex == 2
                  ? Ph.newspaper_fill
                  : Ph.newspaper,
              text: 'Berita',
              size: 28,
            ),
            NavbarIcon(
              index: 3,
              icon: homeController.selectedIndex == 3
                  ? Carbon.user_avatar_filled_alt
                  : Carbon.user_avatar,
              text: 'Profil',
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
