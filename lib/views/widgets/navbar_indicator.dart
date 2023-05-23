import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';

class NavbarIndicator extends StatelessWidget {
  const NavbarIndicator({super.key, req, required this.isSelected});

  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Container(
        height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: tertiary,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            )
          ],
        ),
      );
    } else {
      return const SizedBox(height: 5);
    }
  }
}
