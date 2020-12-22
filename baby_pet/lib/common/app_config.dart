import 'dart:io';

import '../utils/shared_preferences_util.dart';
import '../components/toast.dart';
import 'package:device_info/device_info.dart';
import '../common/commom_tool.dart';
import '../models/device_info.dart';
import '../utils/dio_tool/dio_tool.dart';
import 'package:dio/dio.dart';

class AppConfig {
  static init() async {
    // 初始化本地缓存
    await SpUtil.getInstance();
    // 初始化toast样式
    Toast.setToastStyle();
    // 初始化网络请求
    _initDio();
    // 获取设备信息
    await _initPlugin();
  }

  static _initDio() {
    BaseOptions options = DioTool.getDefOptions();
    options.baseUrl = DioPath.baseUrl;
    HttpConfig config = HttpConfig(options: options);
    DioTool().setConfig(config);
  }

  static _initPlugin() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await plugin.androidInfo;
      handleDeviceInfo(androidDeviceInfo, null);
    } else {
      IosDeviceInfo ios = await plugin.iosInfo;
      handleDeviceInfo(null, ios);
    }
  }

  static handleDeviceInfo(AndroidDeviceInfo android, IosDeviceInfo iOSInfo) {
    final isIOS = Platform.isIOS;
    Map<String, dynamic> jsonMap = {
      "mobileType": isIOS ? iOSInfo.name : android.device,
      "mobileVersion": isIOS ? iOSInfo.systemVersion : android.version,
      "mobileSystem": isIOS ? iOSInfo.systemName : android.device,
      "modelType": isIOS ? iOSInfo.model : android.model,
      "localizedModel": isIOS ? iOSInfo.localizedModel : android.androidId,
      "mobileUid": isIOS ? iOSInfo.identifierForVendor : android.device,
      "isPhysicalDevice":
          isIOS ? iOSInfo.isPhysicalDevice : android.isPhysicalDevice,
    };

    CommonTool.deviceInfo = DeviceInfoModel.fromJson(jsonMap);
    CommonTool.saveDeviceInfo();
  }
}
