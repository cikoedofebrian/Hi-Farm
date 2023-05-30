import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            color: AppColor.secondary,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
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
                            const Text('Rahel Jessy'),
                          ],
                        ),
                        const Icon(Icons.more_vert_rounded)
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                        'Infonya lur baru nanem cabe, semoga bisa berbuah lebat ya'),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Image.asset('assets/home_images/image 1.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      'Comments (12)',
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
