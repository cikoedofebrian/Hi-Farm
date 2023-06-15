import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/home_controller.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/teenyicons.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final ShopController shopController = Get.find();
    // final UserController userController = Get.find();
    return Padding(
      padding: const EdgeInsets.only(right: 25, bottom: 10),
      child: Obx(
        () => InkWell(
          onTap: () {
            if (homeController.selectedIndex == 0) {
              Get.toNamed(addNewPost);
            } else {
              if (shopController.shop != null) {
                Get.toNamed(viewShop);
              } else {
                Get.toNamed(newStore);
              }
            }
          },
          child: CircleAvatar(
            radius: 36,
            backgroundColor: AppColor.secondary,
            child: CircleAvatar(
              radius: 26,
              backgroundColor: AppColor.primary,
              child: homeController.selectedIndex == 0
                  ? const Icon(
                      Icons.add_rounded,
                      size: 30,
                      color: AppColor.tertiary,
                    )
                  : const Iconify(
                      Teenyicons.shop_solid,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
