import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.color,
  });
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
          color: color ?? AppColor.secondary, size: 50),
    );
  }
}
