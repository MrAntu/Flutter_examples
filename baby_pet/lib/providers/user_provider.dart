import 'package:flutter/material.dart';
import '../models/login_info.dart';
import '../common/commom_tool.dart';
import '../pages/request/request.dart';
import '../models/pet_model.dart';
import '../components/toast.dart';
import '../models/user_data.dart';

class UserProviders with ChangeNotifier {
  LoginInfo _loginInfo;
  LoginInfo get loginInfo => _loginInfo;

  List<PetModel> _petList;
  List<PetModel> get petList => _petList;

  PetModel _currentPetModel;
  PetModel get petModel => _currentPetModel;

  UserData _userData;
  UserData get userData => _userData;

  UserProviders() {
    _loginInfo = CommonTool.loginInfo;
    _currentPetModel = CommonTool.petModel;
    _userData = CommonTool.userData;
  }

  void loginOutAction() {
    _loginInfo = null;
    _petList = null;
    _currentPetModel = null;
    _userData = null;
    notifyListeners();
  }

  void setLoginInfo(LoginInfo info) {
    _loginInfo = info;
    CommonTool.loginInfo = info;
    // 缓存本地
    CommonTool.saveLoginInfo(info);
    // 请求宠物数据
    loadPetList();
    // 请求用户数据
    loadUserData();
    notifyListeners();
  }

  Future loadUserData() {
    return Request.getUserData(_loginInfo.userId.toString()).then((value) {
      _userData = value;
      CommonTool.saveUserData(value);
      notifyListeners();
    }).catchError((err) {
      Toast.showError(err.toString());
    });
  }

  Future loadPetList() {
    return Request.getPetList(_loginInfo.userId.toString()).then((value) {
      if (value.length > 0) {
        _currentPetModel = value.first;
        _petList = value;
      }
      CommonTool.savePet(_currentPetModel);
      CommonTool.petModel = _currentPetModel;
      notifyListeners();
    }).catchError((err) {
      Toast.showError(err.toString());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
