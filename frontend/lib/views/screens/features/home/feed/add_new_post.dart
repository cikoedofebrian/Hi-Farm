import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/api_link.dart';
import 'package:hifarm/constants/api_method.dart';
import 'package:hifarm/controllers/home_controller.dart';
import 'package:hifarm/helpers/api_request_sender.dart';

class AddNewPost extends StatelessWidget {
  const AddNewPost({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Test'),
          onPressed: () async {
            final result = await ApiRequestSender.sendHttpRequest(
                ApiMethod.post, "http://10.132.0.238:8000/api/login", {});
          },
        ),
      ),
    );
  }
}
