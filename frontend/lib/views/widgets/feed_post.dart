import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/routes.dart';

class FeedPost extends StatelessWidget {
  const FeedPost({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Get.toNamed(postDetails),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
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
              height: size,
              width: size,
              child: Image.asset('assets/home_images/image 1.png'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
