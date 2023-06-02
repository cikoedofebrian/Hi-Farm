import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/views/widgets/rounded_item.dart';

class ScrollableRoundedPage extends StatelessWidget {
  const ScrollableRoundedPage({
    super.key,
    required,
    required this.topContent,
    required this.body,
    required this.height,
  });
  final double height;
  final Widget topContent;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          floating: true,
          backgroundColor: AppColor.secondary,
          expandedHeight: MediaQuery.of(context).size.height * height,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: topContent,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Stack(
              children: [
                Container(
                  height: 40,
                  color: AppColor.secondary,
                ),
                RoundedItem(child: body),
              ],
            ),
            childCount: 1,
          ),
        )
      ],
    );
  }
}
