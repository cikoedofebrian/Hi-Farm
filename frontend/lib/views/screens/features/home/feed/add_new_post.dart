import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/controllers/home_controller.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class AddNewPost extends StatefulWidget {
  const AddNewPost({super.key});

  @override
  State<AddNewPost> createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  List<File> _photoList = [];

  String text = 'TEST';
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: AppColor.secondary,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
            child: Stack(
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.navigate_before_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Buat Post',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const RoundedTopPadding(),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.9,
            color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.photo,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Tambahkan Foto',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
