import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  void changeIndex(int index) {
    _selectedIndex.value = index;
  }
}
