import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/home_controller.dart';
import 'package:hifarm/models/data/news_model.dart';

class NewsPost extends StatelessWidget {
  const NewsPost({
    super.key,
    required this.data,
  });

  final MNews data;
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return InkWell(
      onTap: () => Get.toNamed(
        newsDetails,
        arguments: data,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        color: Theme.of(context).primaryColor,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
          ),
          height: 140,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(homeController.isDarkTheme
                        ? "https://images.voicy.network/Content/Clips/Images/3b412df6-3caa-4fa5-82d1-7dad916d34af-small.jpeg"
                        : data.url),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 140,
                height: 140,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      data.judul,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Expanded(
                      child: Text(
                        data.description,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
