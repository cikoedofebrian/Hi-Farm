import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/controllers/news_controller.dart';
import 'package:hifarm/views/widgets/custom_loading_indicator.dart';
import 'package:hifarm/views/widgets/news_post.dart';
import 'package:hifarm/views/widgets/scrollable_rounded_page.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.find();
    if (newsController.isLoading) {
      newsController.fetchNewsData();
    }
    return Obx(() {
      if (newsController.isLoading) {
        return const CustomLoadingIndicator();
      }
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
        body: ListView.builder(
          padding: const EdgeInsets.only(bottom: 120),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              NewsPost(data: newsController.list[index]),
          itemCount: newsController.list.length,
        ),
        height: 0.12,
      );
    });
  }
}
