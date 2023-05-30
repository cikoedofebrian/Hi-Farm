import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';

class RoundedTopPadding extends StatelessWidget {
  const RoundedTopPadding({
    super.key,
    this.title,
  });

  final String? title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40,
          color: AppColor.secondary,
        ),
        Container(
          alignment: Alignment.center,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: title != null
              ? Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              : null,
        ),
      ],
    );
  }
}
