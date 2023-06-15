import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';

SnackbarController customSnackBar(
  String title,
  String message,
) {
  return Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: message,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColor.tertiary,
    ),
  );
}
