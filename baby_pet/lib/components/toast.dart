import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Toast {
  static void showToast(String msg) {
    // setToastStyle();
    EasyLoading.instance..userInteractions = true;
    EasyLoading.showToast(msg);
  }

  static void showLoading() {
    // setToastStyle();
    EasyLoading.instance..userInteractions = true;
    EasyLoading.show(status: '加载中...');
  }

  static void showSuccess(String msg) {
    // setToastStyle();
    EasyLoading.instance..userInteractions = true;
    EasyLoading.showSuccess(msg);
  }

  static void showError(String msg) {
    // setToastStyle();
    EasyLoading.instance..userInteractions = true;
    EasyLoading.showError(msg);
  }

  static void showWarn(String msg) {
    // setToastStyle();
    EasyLoading.instance..userInteractions = true;
    EasyLoading.showInfo(msg);
  }

  static void showProgress(double value, {String status = '正在保存...'}) {
    // setToastStyle();
    EasyLoading.showProgress(value, status: status);
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }

  static void setToastStyle() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Color(0xCC000000)
      ..indicatorColor = Colors.white
      ..progressColor = Colors.white
      ..textColor = Colors.white
      ..fontSize = 15
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..userInteractions = false;
  }
}
