import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 25, bottom: 10),
      child: CircleAvatar(
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
    );
  }
}
