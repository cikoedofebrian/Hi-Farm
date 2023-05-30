import 'package:flutter/material.dart';
import 'package:hifarm/views/widgets/news_post.dart';
import 'package:hifarm/views/widgets/scrollable_rounded_page.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableRoundedPage(
        topContent: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Berita',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        body: Column(
          children: List.generate(
            30,
            (index) => const NewsPost(),
          ),
        ),
        height: 0.12);
  }
}
