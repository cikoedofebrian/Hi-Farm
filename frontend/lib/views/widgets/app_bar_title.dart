import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title,
    required this.isBackable,
    required this.isNextable,
    this.nextIcon,
  });

  final String title;
  final bool isBackable;
  final bool isNextable;
  final String? nextIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isBackable)
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.navigate_before,
                        size: 50,
                        color: Colors.white,
                      )),
                if (isNextable)
                  Iconify(
                    nextIcon ?? Majesticons.next_circle,
                    size: 30,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
