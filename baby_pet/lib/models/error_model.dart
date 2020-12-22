import 'package:flutter/material.dart';

/// 错误类型
enum ErrorModelType {
  defaultError,
  networkTimeOutError, //网络错误
  unauthorizedError //为授权(一般为未登录)
}

class ErrorModel {
  String message;
  ErrorModelType errorType;
  int code;

  ErrorModel(this.message, {this.code, this.errorType}) {
    errorType ??= ErrorModelType.defaultError;
  }

  String toString() {
    var msg =
        'ErrorModel code: $code, message:$message, errorType: ${errorType}';
    return msg;
  }
}
