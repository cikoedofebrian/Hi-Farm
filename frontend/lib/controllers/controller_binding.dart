import 'package:get/get.dart';
import 'package:hifarm/controllers/auth_controller.dart';
import 'package:hifarm/controllers/feed_controller.dart';
import 'package:hifarm/controllers/home_controller.dart';
import 'package:hifarm/controllers/news_controller.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(HomeController());
    Get.put(FeedController());
    Get.put(NewsController());
  }
}
