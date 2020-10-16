import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:xiecheng_app/model/travel_model.dart';
import 'package:http/http.dart' as http;

//var Params = {
//  "districtId": -1,
//  "groupChannelCode": "RX-OMF",
//  "type": null,
//  "lat": -180,
//  "lon": -180,
//  "locatedDistrictId": 0,
//  "pagePara": {
//    "pageIndex": 1,
//    "pageSize": 10,
//    "sortType": 9,
//    "sortDirection": 0
//  },
//  "imageCutType": 1,
//  "head": {'cid': "09031014111431397988"},
//  "contentType": "json"
//};

class TravelDao {
  static Future<TravelItemModel> fetch(String url,Map params, String groupChannelCode, int pageIndex, int pageSize) async {
    Map paramsMap = params['pagePara'];
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    params['groupChannelCode'] = groupChannelCode;
    final response = await http.post(url, body: jsonEncode(params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print(result);
      //只有当当前输入的内容和服务端返回的内容一致时才渲染
      return TravelItemModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel.json');
    }
  }
}