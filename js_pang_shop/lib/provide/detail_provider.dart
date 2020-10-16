import 'package:flutter/material.dart';

class DetailModel {
  final String title;
  DetailModel(this.title);

}

class DetailProvider with ChangeNotifier {

  //模拟数据
  DetailModel detail = null;
  bool isLeft = true;
  bool isRight = false;

  changeTabbarDirection(String direction) {
    if (direction == "left") {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  getGoodsInfo(String id) async {
    print("getGoodsInfo--id -- ${id}");
    //模拟请求
    await Future.delayed(Duration(seconds: 2), () {
      detail = DetailModel("123123");
      notifyListeners();
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}