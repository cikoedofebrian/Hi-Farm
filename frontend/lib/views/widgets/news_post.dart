import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/models/data/news_model.dart';

class NewsPost extends StatelessWidget {
  const NewsPost({
    super.key,
    required this.data,
  });

  final MNews data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        newsDetails,
        arguments: data,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        color: Colors.white,
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
                    image: NetworkImage(data.url),
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
