import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/models/data/news_model.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final MNews data = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                children: [
                  Text(
                    data.judul,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.network(data.url),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    data.description,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
