import 'package:flutter/material.dart';
import '../model/category_model.dart';
import '../data/category_data.dart';

class CategoryProvider with ChangeNotifier {
  CategoryModel model = CategoryModel.fromJson(categoryJson);
  List<BxMallSubDto> bxMallSubDto = [];
  int rightNavigationIndex = 0;
  int page = 1;
  int count = 20;
  String nomoreText = '';


  // 获取右边头部数据
  void getBxMallSubDto(int index)  {
    // 每次切换大类，重置为0
    rightNavigationIndex = 0;
    page = 1;
    count = 20;
    // 创建全部分类
    BxMallSubDto subDto = BxMallSubDto();
    subDto.mallSubName = "全部";
    subDto.mallCategoryId = "0";
    subDto.mallSubId = "0";
    subDto.comments = "0";
    bxMallSubDto = [subDto];
    bxMallSubDto.addAll(model.data[index].bxMallSubDto);
    notifyListeners();
  }

  changeRightNavigationIndex(int index) {
    rightNavigationIndex = index;
    notifyListeners();
  }

  changePage() {
    page++;
    notifyListeners();
  }

  changeCount() {
    count += 10;
    notifyListeners();
  }

  resetCount() {
    count = 20;
    notifyListeners();
  }

  resetPage() {
    page = 1;
    notifyListeners();
  }

  changeNomoreText(String text) {
    nomoreText = text;
    notifyListeners();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}