import 'package:get/get.dart';
import 'package:hifarm/constants/api_link.dart';
import 'package:hifarm/constants/api_method.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/helpers/api_request_sender.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final RxBool _isVisible = false.obs;
  bool get isVisible => _isVisible.value;
  void changeVisible() {
    _isVisible.value = !_isVisible.value;
  }

  final RxString _token = ''.obs;
  String get token => _token.value;

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final String? getToken = prefs.getString('token');
    if (getToken != null) {
      _token.value = getToken;
    }
  }

  final RxBool _isChecked = false.obs;
  bool get isChecked => _isChecked.value;
  void changeChecked() {
    _isChecked.value = !_isChecked.value;
  }

  Future<void> register(String name, String password, String email,
      String confirmationPassword) async {
    print(email);
    print(password);
    print(confirmationPassword);
    if (password != confirmationPassword) {
      Get.showSnackbar(
        const GetSnackBar(
            title: 'Password tidak sama!',
            message:
                'Pastikan password konfirmasi harus sesuai dengan password.',
            duration: Duration(seconds: 2),
            backgroundColor: AppColor.tertiary),
      );
      return;
    }
    final result = await ApiRequestSender.sendHttpRequest(
      ApiMethod.post,
      ApiLink.register,
      {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
    );
    if (result!['email'] != null) {
      Get.showSnackbar(
        const GetSnackBar(
            title: 'Email sudah ada!',
            message: 'Pilih email yang lain',
            duration: Duration(seconds: 2),
            backgroundColor: AppColor.tertiary),
      );
    } else if (result['auth_token'] != null) {
      _token.value = result['auth_token'];
      Get.offNamed(homeScreen);
    }
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    final result =
        await ApiRequestSender.sendHttpRequest(ApiMethod.post, ApiLink.login, {
      'email': email,
      'password': password,
    });
    if (result!['email'] != null) {
      Get.showSnackbar(
        const GetSnackBar(
            title: 'Email tidak ditemukan!',
            message: 'Silahkan daftarkan email anda.',
            duration: Duration(seconds: 2),
            backgroundColor: AppColor.tertiary),
      );
    } else if (result['password'] != null) {
      Get.showSnackbar(
        const GetSnackBar(
            title: 'Password salah!',
            message: 'Pastikan password yang anda gunakan sudah benar.',
            duration: Duration(seconds: 2),
            backgroundColor: AppColor.tertiary),
      );
    } else if (result['auth_token'] != null) {
      _token.value = result['auth_token'];
      if (isChecked) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', _token.value);
      }
      Get.offNamed(homeScreen);
    }
  }

  Future<void> logout() async {
    _token.value = '';
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.clear();
    Get.offNamed(loginScreen);
  }
}
