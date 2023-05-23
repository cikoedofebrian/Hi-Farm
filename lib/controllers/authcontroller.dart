import 'package:get/get.dart';
import 'package:hifarm/constants/routes.dart';

class AuthController extends GetxController {
  RxBool _isVisible = false.obs;
  bool get isVisible => _isVisible.value;
  void changeVisible() {
    _isVisible.value = !_isVisible.value;
  }

  RxBool _isChecked = false.obs;
  bool get isChecked => _isChecked.value;
  void changeChecked() {
    _isChecked.value = !_isChecked.value;
  }

  void register() {
    print(_isChecked.value);
    Get.toNamed(homeScreen);
  }

  void login() {
    print(_isChecked.value);
    Get.toNamed(homeScreen);
  }
}
