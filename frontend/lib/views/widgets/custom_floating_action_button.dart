import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/api_key.dart';
import 'package:hifarm/constants/api_link.dart';
import 'package:hifarm/constants/api_method.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/helpers/api_request_sender.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  // void tryToGetData() async {
  //   const url =
  //       "${mapsGeocode}latlng=40.714224,-73.961452&key=$GOOGLE_MAPS_API_KEY";
  //   // print(url);
  //   final result =
  //       await ApiRequestSender.sendHttpRequest(ApiMethod.get, url, null);
  //   print(result);
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, bottom: 10),
      child: InkWell(
        onTap: () => Get.toNamed(addNewPost),
        child: const CircleAvatar(
          radius: 36,
          backgroundColor: AppColor.secondary,
          child: CircleAvatar(
            radius: 26,
            backgroundColor: AppColor.primary,
            child: Icon(
              Icons.add_rounded,
              size: 30,
              color: AppColor.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
