import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:xiecheng_app/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;


class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http.get('http://www.devio.org/io/flutter_app/json/travel_page.json');
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print(result);
      //只有当当前输入的内容和服务端返回的内容一致时才渲染
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel_tab.json');
    }
  }
}
