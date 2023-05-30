import 'package:flutter/material.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class RoundedPage extends StatelessWidget {
  const RoundedPage({super.key, required this.child, required this.title});

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedTopPadding(title: title),
        child,
      ],
    );
  }
}
