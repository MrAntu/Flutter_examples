import 'package:baby_pet/models/user_data.dart';

import 'strings.dart';
import '../utils/shared_preferences_util.dart';
import '../utils/object_util.dart';
import '../models/config_info.dart';
import '../models/login_info.dart';
import '../models/user_data.dart';
import '../models/pet_model.dart';
import '../models/device_info.dart';

class CommonTool {
  static ConfigInfo configInfo = ConfigInfo();
  static LoginInfo loginInfo = LoginInfo();
  static UserData userData = UserData();
  static PetModel petModel = PetModel();
  static DeviceInfoModel deviceInfo = DeviceInfoModel();
  // 判断是否登录
  static bool hasLogin() {
    bool isLogin = loginInfo.userId != null &&
        loginInfo.userId > 0 &&
        loginInfo.token != null &&
        loginInfo.token.length > 0;
    return isLogin;
  }

  // 初始化用户信息
  static initUserInfo() {
    // 用户配置
    var config = _getConfigInfoLocal();
    if (!ObjectUtil.isEmpty(config)) {
      configInfo = config;
    }
    // 用户登录
    var login = _getLoginInfoLocal();
    if (!ObjectUtil.isEmpty(login)) {
      loginInfo = login;
    }
    // 用户信息
    var data = _getUserDataLocal();
    if (!ObjectUtil.isEmpty(data)) {
      userData = data;
    }
    // 宠物信息
    var model = _getPetInfoLocal();
    if (!ObjectUtil.isEmpty(model)) {
      petModel = model;
    }

    var device = _getDeviceInfoLocal();
    if (!ObjectUtil.isEmpty(device)) {
      deviceInfo = device;
    }
  }

// set
  static saveDeviceInfo() {
    // SpUtil.setString("deviceInfo", jsonEncode(deviceInfo?.toJson()));
    SpUtil.putObject(UserdefaultKey.kDeviceInfo, deviceInfo);
  }

// get
  static ConfigInfo _getConfigInfoLocal() {
    var info = SpUtil.getObj(
        UserdefaultKey.kConfigInfo, (v) => ConfigInfo.fromJson(v));
    return info;
  }

  static LoginInfo _getLoginInfoLocal() {
    var info =
        SpUtil.getObj(UserdefaultKey.kLogInfo, (v) => LoginInfo.fromJson(v));
    return info;
  }

  static UserData _getUserDataLocal() {
    var info =
        SpUtil.getObj(UserdefaultKey.kUserData, (v) => UserData.fromJson(v));
    return info;
  }

  static PetModel _getPetInfoLocal() {
    var info =
        SpUtil.getObj(UserdefaultKey.kPetInfo, (v) => PetModel.fromJson(v));
    return info;
  }

  static DeviceInfoModel _getDeviceInfoLocal() {
    var info = SpUtil.getObj(
        UserdefaultKey.kDeviceInfo, (v) => DeviceInfoModel.fromJson(v));
    return info;
  }

  static saveLoginInfo(LoginInfo info) {
    SpUtil.putObject(UserdefaultKey.kLogInfo, info);
  }

  static saveConfigInfo(ConfigInfo info) {
    SpUtil.putObject(UserdefaultKey.kConfigInfo, info);
  }

  static savePet(PetModel pet) {
    SpUtil.putObject(UserdefaultKey.kPetInfo, pet);
  }

  static saveUserData(UserData data) {
    SpUtil.putObject(UserdefaultKey.kUserData, data);
  }

  // 退出登录
  static loginOutAction() {
    configInfo = ConfigInfo();
    loginInfo = LoginInfo();
    userData = UserData();
    petModel = PetModel();
    saveLoginInfo(null);
    savePet(null);
    saveUserData(null);
    saveConfigInfo(null);
  }
}
