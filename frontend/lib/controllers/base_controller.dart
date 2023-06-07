import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends ChangeNotifier {
  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  void changeLoading() {
    _isLoading.value = !_isLoading.value;
  }
}
