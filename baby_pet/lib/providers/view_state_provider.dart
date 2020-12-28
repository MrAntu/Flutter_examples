import 'package:flutter/material.dart';
import '../exports.dart';
import 'package:dio/dio.dart';

/// 页面状态
enum ViewState {
  idle, // 闲置中
  busy, //加载中
  empty, //无数据
  error, //加载失败
}

class ViewStateProvider extends ChangeNotifier {
  // 加载分页，默认为1
  int pageIndex = 1;

  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定, 第一次进入页面loading;
  ViewState _viewState = ViewState.busy;
  ViewState get viewState => _viewState;

  ErrorModel _viewStateError;
  ErrorModel get viewStateError => _viewStateError;

  // 是否第一次加载数据
  bool _firstLoding;
  bool get firstLoading => _firstLoding;
  set firstLoding(bool firstLoding) {
    _firstLoding = firstLoding;
  }

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  /// set
  void setIdle() {
    viewState = ViewState.idle;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  void setError(e, stackTrace, {String message}) {
    ErrorModelType errorType = ErrorModelType.defaultError;
    int code = 0;
    if (e is DioError) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.SEND_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorType = ErrorModelType.networkTimeOutError;
        message = e.error;
      } else if (e.type == DioErrorType.RESPONSE ||
          e.type == DioErrorType.CANCEL) {
        message = e.error;
      } else {
        e = e.error;
        message = e.message;
//        if (e is UnAuthorizedException) {
//          stackTrace = null;
//          errorType = ViewStateErrorType.unauthorizedError;
//        } else if (e is NotSuccessException) {
//          errorType = ViewStateErrorType.networkTimeOutError;
//          message = e.message;
//        } else {
//          message = e.message;
//        }
      }
    } else if (e is ErrorModel) {
      code = e.code;
      message = e.message;
      errorType = e.errorType;
    } else {
      message = e.toString();
    }

    _viewStateError = ErrorModel(message, code: code, errorType: errorType);
    viewState = ViewState.error;
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _disposed = true;
    print("object3");
    super.dispose();
  }
}
