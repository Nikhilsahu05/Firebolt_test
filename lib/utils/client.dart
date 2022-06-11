import 'dart:convert';

import 'package:firebolt_final/constants/api.dart';
import 'package:http/http.dart' as http;

class FireBoltClient {

  static Map<String, String> getHeaders() {
    return {"Content-Type": "application/json"};
  }

  static Uri getURL(String url) {
    return Uri.parse(url);
  }

  static post(String url, String body) async {
    //HTTP METHOD FOR POST REQUEST

    final http.Response response =
        await http.post(getURL(url), headers: getHeaders(), body: body);

    return jsonDecode(response.body);
  }
}
