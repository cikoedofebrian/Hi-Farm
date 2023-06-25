import 'package:get/get.dart';
import 'package:hifarm/views/screens/features/home/feed/feed.dart';
import 'package:hifarm/views/screens/features/home/news/news.dart';
import 'package:hifarm/views/screens/features/home/profile/profile.dart';
import 'package:hifarm/views/screens/features/home/shop/shop.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final List _pageList = const [
    Feed(),
    Shop(),
    News(),
    Profile(),
  ];

  final RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  void changeIndex(int index) {
    _selectedIndex.value = index;
  }

  Widget getPage() {
    return _pageList[selectedIndex];
  }

  final RxBool _isDarkTheme = false.obs;
  bool get isDarkTheme => _isDarkTheme.value;
  changeTheme() {
    _isDarkTheme.value = !_isDarkTheme.value;
  }
}
