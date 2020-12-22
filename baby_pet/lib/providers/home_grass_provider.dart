import 'package:flutter/material.dart';
import '../models/grass_model.dart';

class HomeGrassProvider with ChangeNotifier {
  List<GrassModel> _modelList = [];
  List<GrassModel> get modelList => _modelList;

  void setModelList(List<GrassModel> list) {
    _modelList = list;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
