import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/api_link.dart';
import 'package:hifarm/constants/api_method.dart';
import 'package:hifarm/controllers/auth_controller.dart';
import 'package:hifarm/controllers/base/base_controller.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/helpers/api_request_sender.dart';
import 'package:hifarm/models/data/shop_model.dart';
import 'package:hifarm/models/data/user_model.dart';
import 'package:hifarm/views/widgets/custom_snack_bar.dart';

class UserController extends BaseController {
  Rx<MUser?> _user = null.obs;
  MUser get user => _user.value!;

  final File? photo = null;

  Future<void> fetchUserData() async {
    try {
      final rawData = await ApiRequestSender.sendHttpRequest(
          ApiMethod.get, ApiLink.getProfile, null);
      _user = MUser.fromJson(rawData).obs;

      if (rawData['shop'] != null) {
        final ShopController shopController = Get.find();
        shopController.changeShop(MShop.fromJson(rawData['shop']));
      }
      changeLoading(false);
    } catch (err) {
      final AuthController authController = Get.find();
      authController.logout();
    }
  }

  Future<void> updateUser(
    String email,
    String name,
    File? photo,
  ) async {
    String? imageUrl;

    if (email.isEmpty || name.isEmpty) {
      customSnackBar('Gagal', 'Data tidak valid');
      return;
    } else if (!EmailValidator.validate(email)) {
      customSnackBar('Gagal', 'Email Tidak Valid');
      return;
    } else if (email == user.email && name == user.name && photo == null) {
      customSnackBar('Gagal', 'Data tidak ada yang berubah');
      return;
    }
    if (photo != null) {
      final fStorage =
          FirebaseStorage.instance.ref("/profile_picture/${user.email}.await");
      final upload = await fStorage.putFile(photo);
      imageUrl = await upload.ref.getDownloadURL();
    }

    final sendUpdateRequest =
        await ApiRequestSender.sendHttpRequest(ApiMethod.put, ApiLink.profile, {
      'name': name,
      'email': email,
      'pic': imageUrl,
    });

    _user = MUser.fromJson(sendUpdateRequest['data']).obs;
    customSnackBar('Berhasil', 'Data berhasil dirubah!');
  }
}
