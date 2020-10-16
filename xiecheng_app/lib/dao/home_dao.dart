import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xiecheng_app/model/home_model.dart';

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {

  static Future<HomeModel> fetch() async {
    final response = await http.get(HOME_URL);
    if (response.statusCode == 200) {
      Utf8Decoder _utf8 = Utf8Decoder();
      var result = json.decode(_utf8.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Failed to load homeData');
    }
  }



}