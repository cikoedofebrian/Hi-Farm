import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 14 : 6,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isActive ? 20 : 100),
        color: isActive ? secondary : Colors.grey,
      ),
    );
  }
}
