import 'dart:convert';
import 'package:get/get.dart';
import 'package:hifarm/constants/api_method.dart';
import 'package:hifarm/controllers/auth_controller.dart';
import 'package:http/http.dart' as http;

class ApiRequestSender {
  static Future<dynamic> sendHttpRequest(
    String method,
    String url,
    Map<String, dynamic>? body,
  ) async {
    final AuthController authController = Get.find();
    final Uri parsedUrl = Uri.parse(url);
    late final dynamic result;
    // print(authController.token);
    // print(parsedUrl);
    // print(jsonEncode(body));
    switch (method) {
      case ApiMethod.get:
        result = await http.get(parsedUrl,
            headers: {'Authorization': 'Bearer ${authController.token}'});
        break;
      case ApiMethod.delete:
        return null;
      case ApiMethod.post:
        result = await http.post(
          parsedUrl,
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authController.token}',
          },
        );
        break;
      case ApiMethod.put:
        result = await http.put(
          parsedUrl,
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${authController.token}',
          },
        );
        break;
    }
    final decodedBody = jsonDecode(result.body);
    return decodedBody;
  }
}
