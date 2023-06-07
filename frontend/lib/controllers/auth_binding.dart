import 'package:get/get.dart';
import 'package:hifarm/controllers/auth_controller.dart';
import 'package:hifarm/controllers/feedcontroller.dart';
import 'package:hifarm/controllers/home_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(HomeController());
    Get.put(FeedController());
  }
}
