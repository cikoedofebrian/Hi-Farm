import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    required this.function,
    required this.text,
  });

  final String text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.tertiary,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
