import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/image_string.dart';
import 'package:hifarm/controllers/feed_controller.dart';
import 'package:hifarm/controllers/user_controller.dart';
import 'package:hifarm/views/widgets/custom_loading_indicator.dart';
import 'package:hifarm/views/widgets/feed_post.dart';
import 'package:hifarm/views/widgets/keyword_not_found.dart';
import 'package:hifarm/views/widgets/scrollable_rounded_page.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final FeedController feedController = Get.find();
  final UserController userController = Get.find();
  late final TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (feedController.isLoading) {
      feedController.fetchPostData();
    }
    return Obx(
      () => feedController.isLoading
          ? const CustomLoadingIndicator()
          : RefreshIndicator(
              onRefresh: () async {
                feedController.changeLoading(true);
                await feedController.fetchPostData();
              },
              child: ScrollableRoundedPage(
                topContent: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(height: 56, child: Image.asset(homeImage1)),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Halo, ${userController.user.name}!',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14),
                              ),
                              Text(
                                'Bagaimana keadaan peternakanmu?',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: _textEditingController,
                      style: Theme.of(context).textTheme.labelMedium!,
                      decoration: InputDecoration(
                        hintText: 'Ada yang bisa kami bantu?',
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            overflow: TextOverflow.ellipsis),
                        suffixIcon: IconButton(
                          padding: const EdgeInsets.only(right: 12),
                          icon: const Icon(
                            Icons.search,
                            color: AppColor.secondary,
                          ),
                          onPressed: () => feedController
                              .searchPost(_textEditingController.text),
                        ),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Obx(
                      () {
                        if (feedController.lastSearched.isNotEmpty) {
                          return Column(
                            children: [
                              Text(
                                'Menampilkan hasil untuk "${feedController.lastSearched}"',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    Container(
                      color: Colors.white,
                      child: feedController.list.isNotEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.only(bottom: 100),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  FeedPost(data: feedController.list[index]),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: feedController.list.length,
                            )
                          : const KeywordNotFound(
                              description:
                                  'Belum ada postingan dengan keyword ini.',
                            ),
                    ),
                  ],
                ),
                height: 0.19,
              ),
            ),
    );
  }
}
