import 'package:get/get.dart';
import 'package:hifarm/constants/api_link.dart';
import 'package:hifarm/constants/api_method.dart';
import 'package:hifarm/controllers/auth_controller.dart';
import 'package:hifarm/controllers/base_controller.dart';
import 'package:hifarm/helpers/api_request_sender.dart';
import 'package:hifarm/models/data/post_model.dart';

class FeedController extends BaseController {
  final RxList<MPost> _list = <MPost>[].obs;
  List<MPost> get list => _list;

  Future<void> fetchPostData() async {
    try {
      final result = await ApiRequestSender.sendHttpRequest(
          ApiMethod.get, ApiLink.getPosts, null);

      for (var i in result) {
        _list.add(MPost.fromJson(i));
      }

      changeLoading();
      _list.refresh();
    } catch (error) {
      final AuthController authController = Get.find();
      authController.logout();
    }
  }

  Future<void> fetchCommentData(int id) async {}
}
