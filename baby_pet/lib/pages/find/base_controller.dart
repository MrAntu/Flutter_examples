/// 创建时间：12/29/20
/// 作者：weiwei.li
/// 描述：
import 'package:get/get.dart';

import '../../models/error_model.dart';
import 'package:dio/dio.dart';

/// 页面状态
enum BaseViewState {
  idle, // 闲置中
  busy, //加载中
  empty, //无数据
  error, //加载失败
}

class BaseController extends GetxController {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定, 第一次进入页面loading;
  BaseViewState _viewState = BaseViewState.busy;
  BaseViewState get viewState => _viewState;
  set viewState(BaseViewState viewState) {
    _viewState = viewState;
    updateUI();
  }

  // 是否第一次加载数据
  bool _firstLoding;
  bool get firstLoading => _firstLoding;
  set firstLoding(bool firstLoding) {
    _firstLoding = firstLoding;
  }

  ErrorModel _viewStateError;
  ErrorModel get viewStateError => _viewStateError;

  /// 刷新UI时，调用此方法，防止网络请求close后，在进行刷新
  void updateUI([List<String> ids, bool condition = true]) {
    if (!_disposed) {
      update(ids, condition);
    }
  }

  /// set
  void setIdle() {
    viewState = BaseViewState.idle;
  }

  void setBusy() {
    viewState = BaseViewState.busy;
  }

  void setEmpty() {
    viewState = BaseViewState.empty;
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
    viewState = BaseViewState.error;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('BaseController onInit');
  }

  @override
  void onClose() {
    _disposed = true;
    print('BaseController onClose');
    // TODO: implement onClose
    super.onClose();
  }
}
