import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/controllers/feedcontroller.dart';
import 'package:hifarm/views/widgets/post_comment.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final int id = Get.arguments;
    final FeedController feedController = Get.find();
    final data = feedController.list.firstWhere((element) => element.id == id);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.bottomLeft,
                  color: AppColor.secondary,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 60, bottom: 20),
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.navigate_before_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
                const RoundedTopPadding(),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: Image.asset(
                                        "assets/home_images/Rectangle 160.png"),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(data.user.name),
                                ],
                              ),
                              const Icon(Icons.more_vert_rounded)
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            data.description,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        itemBuilder: (context, index) => Image.network(
                          data.pics[0],
                          fit: BoxFit.cover,
                        ),
                        itemCount: 10,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Comments (12)',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ...List.generate(
                            10,
                            (index) => const PostComment(),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  offset: Offset(0, -1),
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 2,
                )
              ]),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.send_rounded,
                    color: AppColor.tertiary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
