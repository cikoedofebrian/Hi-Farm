import 'package:get/get.dart';
import 'package:hifarm/constants/api_link.dart';
import 'package:hifarm/constants/api_method.dart';
import 'package:hifarm/controllers/base/base_controller.dart';
import 'package:hifarm/helpers/api_request_sender.dart';
import 'package:hifarm/models/data/news_model.dart';

class NewsController extends BaseController {
  final RxList<MNews> _list = <MNews>[].obs;
  List<MNews> get list => _list;

  Future<void> fetchNewsData() async {
    final result = await ApiRequestSender.sendHttpRequest(
        ApiMethod.get, ApiLink.getNews, null);

    for (var i in result) {
      _list.add(MNews.fromJson(i));
    }
    changeLoading(false);
    _list.refresh();
  }
}
