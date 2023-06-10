import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/constants/routes.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, bottom: 10),
      child: InkWell(
        onTap: () => Get.toNamed(addNewPost),
        child: const CircleAvatar(
          radius: 36,
          backgroundColor: AppColor.secondary,
          child: CircleAvatar(
            radius: 26,
            backgroundColor: AppColor.primary,
            child: Icon(
              Icons.add_rounded,
              size: 30,
              color: AppColor.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
