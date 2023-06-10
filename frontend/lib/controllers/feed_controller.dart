import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifarm/constants/api_link.dart';
import 'package:hifarm/constants/api_method.dart';
import 'package:hifarm/controllers/auth_controller.dart';
import 'package:hifarm/controllers/base/base_controller.dart';
import 'package:hifarm/helpers/api_request_sender.dart';
import 'package:hifarm/models/data/post_model.dart';
import 'package:hifarm/views/widgets/custom_snack_bar.dart';

class FeedController extends BaseController {
  final RxList<MPost> _list = <MPost>[].obs;
  List<MPost> get list => _list;

  final RxBool _uploadLoading = false.obs;
  bool get uploadLoading => _uploadLoading.value;

  void changeUploadLoading(bool value) {
    _uploadLoading.value = value;
  }

  Future<void> fetchPostData() async {
    try {
      final result = await ApiRequestSender.sendHttpRequest(
          ApiMethod.get, ApiLink.getPosts, null);

      for (var i in result) {
        _list.add(MPost.fromJson(i));
      }

      changeLoading(false);
      _list.refresh();
    } catch (error) {
      final AuthController authController = Get.find();
      authController.logout();
    }
  }

  Future<void> addNewPost(
    String description,
    LatLng? location,
    List<File> photoList,
  ) async {
    if (description.isEmpty) {
      customSnackBar(
        'Deskripsi tidak boleh kosong!',
        'Isi kolom deskripsi.',
      );
      return;
    } else if (location == null) {
      customSnackBar(
        'Lokasi tidak boleh kosong!',
        'Pilih lokasi terlebih dahulu.',
      );
      return;
    } else if (photoList.isEmpty) {
      customSnackBar(
        'Foto tidak boleh kosong!',
        'Upload foto terlebih dahulu.',
      );
      return;
    }

    final AuthController authController = Get.find();
    List<String> imageUrlList = [];
    for (int i = 0; i < photoList.length; i++) {
      final fStorage = FirebaseStorage.instance.ref(
          '/${authController.token}/${DateTime.now().toIso8601String()}$i');
      final upload = await fStorage.putFile(File(photoList[i].path));
      final imageUrl = await upload.ref.getDownloadURL();
      imageUrlList.add(imageUrl);
    }

    await ApiRequestSender.sendHttpRequest(ApiMethod.post, ApiLink.getPosts, {
      'lt': location.latitude,
      'ln': location.longitude,
      'description': description,
      'pics': imageUrlList,
    });

    fetchPostData();
  }
}

Future<void> fetchCommentData(int id) async {}
