import 'dart:convert';

import 'package:hifarm/constants/api_method.dart';
import 'package:http/http.dart' as http;

class ApiRequestSender {
  static Future<Map<String, dynamic>?> sendHttpRequest(
    String method,
    String url,
    Map<String, dynamic>? body,
  ) async {
    final Uri parsedUrl = Uri.parse(url);
    switch (method) {
      case ApiMethod.get:
        final result = await http.get(parsedUrl);
        return jsonDecode(result.body);
      case ApiMethod.delete:
        return null;
      case ApiMethod.post:
        final result = await http.post(parsedUrl, body: body);
        return jsonDecode(result.body);
      case ApiMethod.put:
        return null;
    }
    return null;
  }
}
