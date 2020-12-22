import 'dart:convert';
import 'dart:io';
import 'base_resp.dart';
import 'package:dio/dio.dart';

class DioPath {
  static String baseUrl = 'https://gate.ieasydog.com/api/';
  /*
   * 登录注册相关接口
   */
  /// 上传设备信息
  static const String imei = 'user/imei/v2006/wjt/imei';

  /// 用户信息埋点
  static const String putEventBase = 'user/eventBase/v1908/wjt/putEventBase';

  /// 获取验证码, get, phone=13456789417
  static const String sendCode = 'user/common/sendCode';

  /// 密码登录
  static const String applogin = 'user/user/applogin';

  /// 获取用户信息
  static const String userIndex = 'user/user/userIndex';

  /*
   * 宠物相关接口
   */
  /// 获取宠物列表: https://gate.ieasydog.com/api/user/pet/selectUserId?userId=136899
  static const String selectUserId = 'user/pet/selectUserId';

  /// 获取宠物和问答信息: /api/user/pet/v2001/lt/getHomePagePetList?pageIndex=1&pageSize=1&petId=19572&userId=136899
  static const String getHomePagePetList =
      'api/user/pet/v2001/lt/getHomePagePetList';

  /// 保存宠物信息: /api/user/pet/save
  static const String pet_save = 'user/pet/save';

  /*
   * 首页相关接口
   */
  /// 轮播图: discover/advertUnit/selectPageList?locationName=2&locationPage=1
  static const String selectPageList = 'discover/advertUnit/selectPageList';

  /// 首页种草列表: auditStatus=1&pageIndex=1&pageSize=10&userLoginId=136899
  static const String getTrialReportList =
      'user/trialReport/getTrialReportList';

  /// 首页推荐列表: messageTotal=0&pageIndex=1&reportTotal=0&thirtyPieces=1&userLoginId=136899
  static const String selectMessageRecommendList =
      'user/message/selectMessageRecommendList';

  /// 首页种草列表: post: /user/trialReport/getTrialReportInfo
  static const String getTrialReportInfo =
      'user/trialReport/getTrialReportInfo';

  /// 首页种草点赞: post: user/agree/updateTrialReportAgree
  static const String updateTrialReportAgree =
      'user/agree/updateTrialReportAgree';

  /// 首页种草收藏: post: user/collections/update
  static const String collectionApi = 'user/collections/update';
}

/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

///Http配置.
class HttpConfig {
  /// constructor.
  HttpConfig({
    this.status,
    this.code,
    this.msg,
    this.data,
    this.options,
    this.pem,
    this.pKCSPath,
    this.pKCSPwd,
  });

  /// BaseResp [String status]字段 key, 默认：status.
  String status;

  /// BaseResp [int code]字段 key, 默认：errorCode.
  String code;

  /// BaseResp [String msg]字段 key, 默认：errorMsg.
  String msg;

  /// BaseResp [T data]字段 key, 默认：data.
  String data;

  /// Options.
  BaseOptions options;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PEM证书内容.
  String pem;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书路径.
  String pKCSPath;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书密码.
  String pKCSPwd;
}

/// 单例 DioUtil.
/// debug模式下可以打印请求日志. DioUtil.openDebug().
/// dio详细使用请查看dio官网(https://github.com/flutterchina/dio).
class DioTool {
  static final DioTool _singleton = DioTool._init();
  static Dio _dio;

  /// BaseResp [String status]字段 key, 默认：status.
  String _statusKey = "status";

  /// BaseResp [int code]字段 key, 默认：errorCode.
  String _codeKey = "statusCode";

  /// BaseResp [String msg]字段 key, 默认：message.
  String _msgKey = "statusMessage";

  /// BaseResp [T data]字段 key, 默认：data.
  String _dataKey = "data";

  /// Options.
  BaseOptions _options = getDefOptions();

  /// PEM证书内容.
  String _pem;

  /// PKCS12 证书路径.
  String _pKCSPath;

  /// PKCS12 证书密码.
  String _pKCSPwd;

  /// 是否是debug模式.
  static bool _isDebug = true;

  static DioTool getInstance() {
    return _singleton;
  }

  factory DioTool() {
    return _singleton;
  }

  DioTool._init() {
    _dio = new Dio(_options);
  }

  /// 打开debug模式.
  static void openDebug() {
    _isDebug = true;
  }

  void setCookie(String cookie) {
    Map<String, dynamic> _headers = new Map();
    _headers["Cookie"] = cookie;
    _dio.options.headers.addAll(_headers);
  }

  /// set Config.
  void setConfig(HttpConfig config) {
    _statusKey = config.status ?? _statusKey;
    _codeKey = config.code ?? _codeKey;
    _msgKey = config.msg ?? _msgKey;
    _dataKey = config.data ?? _dataKey;
    _mergeOption(config.options);
    _pem = config.pem ?? _pem;
    if (_dio != null) {
      _dio.options = _options;
//      if (_pem != null) {
//        _dio.onHttpClientCreate = (HttpClient client) {
//          client.badCertificateCallback =
//              (X509Certificate cert, String host, int port) {
//            if (cert.pem == _pem) {
//              // 证书一致，则放行
//              return true;
//            }
//            return false;
//          };
//        };
//      }
//      if (_pKCSPath != null) {
//        _dio.onHttpClientCreate = (HttpClient client) {
//          SecurityContext sc = new SecurityContext();
//          //file为证书路径
//          sc.setTrustedCertificates(_pKCSPath, password: _pKCSPwd);
//          HttpClient httpClient = new HttpClient(context: sc);
//          return httpClient;
//        };
//      }
    }
  }

  /// GET
  Future<BaseResp<T>> get<T>(String path,
      {Map<String, dynamic> params,
      Options options,
      CancelToken cancelToken}) async {
    return request(Method.get, path,
        queryParameters: params, options: options, cancelToken: cancelToken);
  }

  /// POST
  Future<BaseResp<T>> post<T>(String path,
      {Map<String, dynamic> params,
      Options options,
      CancelToken cancelToken}) async {
    return request(Method.post, path,
        queryParameters: params, options: options, cancelToken: cancelToken);
  }

  /// Make http request with options.
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  /// <BaseResp<T> 返回 status code msg data .
  Future<BaseResp<T>> request<T>(String method, String path,
      {data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken}) async {
    Response response = await _dio.request(path,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    _printHttpLog(response);
    String _status;
    int _code;
    String _msg;
    T _data;
    bool _isSuccess;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          Map<String, dynamic> result = response.data;
          _code = response.statusCode;
          _msg = response.statusMessage;
          if (result.containsKey(_statusKey)) {
            _status = result[_statusKey].toString();
          }
          if (result.containsKey(_dataKey)) {
            _data = result[_dataKey];
          }
          if (result.containsKey('rel')) {
            _isSuccess = (result['rel'] is bool) ? result['rel'] : false;
          }
        } else {
          Map<String, dynamic> _dataMap = _decodeData(response);
          _status = (_dataMap[_statusKey] is int)
              ? _dataMap[_statusKey].toString()
              : _dataMap[_statusKey];
          _code = (_dataMap[_codeKey] is String)
              ? int.tryParse(_dataMap[_codeKey])
              : _dataMap[_codeKey];
          _msg = _dataMap[_msgKey];
          _data = _dataMap[_dataKey];
        }
        return BaseResp(_status, _code, _msg, _data, _isSuccess);
      } catch (e) {
        return Future.error(new DioError(
          response: response,
          error: "data parsing exception...",
          type: DioErrorType.RESPONSE,
        ));
      }
    }
    return new Future.error(new DioError(
      response: response,
      error: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }

  /// Make http request with options.
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  /// <BaseRespR<T> 返回 status code msg data  Response.
  Future<BaseRespR<T>> requestR<T>(String method, String path,
      {data, Options options, CancelToken cancelToken}) async {
    Response response = await _dio.request(path,
        data: data,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    _printHttpLog(response);
    String _status;
    int _code;
    String _msg;
    T _data;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          _status = (response.data[_statusKey] is int)
              ? response.data[_statusKey].toString()
              : response.data[_statusKey];

          _code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_codeKey];

          _msg = response.data[_msgKey];
          _data = response.data[_dataKey];
        } else {
          Map<String, dynamic> _dataMap = _decodeData(response);
          _status = (_dataMap[_statusKey] is int)
              ? _dataMap[_statusKey].toString()
              : _dataMap[_statusKey];
          _code = (_dataMap[_codeKey] is String)
              ? int.tryParse(_dataMap[_codeKey])
              : _dataMap[_codeKey];
          _msg = _dataMap[_msgKey];
          _data = _dataMap[_dataKey];
        }
        return new BaseRespR(_status, _code, _msg, _data, response);
      } catch (e) {
        return new Future.error(new DioError(
          response: response,
          error: "data parsing exception...",
          type: DioErrorType.RESPONSE,
        ));
      }
    }
    return new Future.error(new DioError(
      response: response,
      error: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }

  /// Download the file and save it in local. The default http method is "GET",you can custom it by [Options.method].
  /// [urlPath]: The file url.
  /// [savePath]: The path to save the downloading file later.
  /// [onProgress]: The callback to listen downloading progress.please refer to [OnDownloadProgress].
  Future<Response> download(
    String urlPath,
    savePath, {
    ProgressCallback onProgress,
    CancelToken cancelToken,
    data,
    Options options,
  }) {
    return _dio.download(urlPath, savePath,
        onReceiveProgress: onProgress,
        cancelToken: cancelToken,
        data: data,
        options: options);
  }

  /// decode response data.
  Map<String, dynamic> _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return new Map();
    }
    return json.decode(response.data.toString());
  }

  /// check Options.
  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  /// merge Option.
  void _mergeOption(BaseOptions opt) {
    _options.method = opt.method ?? _options.method;
    _options.headers = (new Map.from(_options.headers))..addAll(opt.headers);
    _options.baseUrl = opt.baseUrl ?? _options.baseUrl;
    _options.connectTimeout = opt.connectTimeout ?? _options.connectTimeout;
    _options.receiveTimeout = opt.receiveTimeout ?? _options.receiveTimeout;
    _options.responseType = opt.responseType ?? _options.responseType;
//    _options.data = opt.data ?? _options.data;
    _options.extra = (new Map.from(_options.extra))..addAll(opt.extra);
    _options.contentType = opt.contentType ?? _options.contentType;
    _options.validateStatus = opt.validateStatus ?? _options.validateStatus;
    _options.followRedirects = opt.followRedirects ?? _options.followRedirects;
  }

  /// print Http Log.
  void _printHttpLog(Response response) {
    if (!_isDebug) {
      return;
    }
    try {
      print("----------------Http Log----------------" +
          "\n[statusCode]:   " +
          response.statusCode.toString() +
          "\n[request   ]:   " +
          _getOptionsStr(response.request));
      _printDataStr("reqdata ", response.request.data);
      _printDataStr("queryParameters ", response.request.queryParameters);
      _printDataStr("response", response.data);
    } catch (ex) {
      print("Http Log" + " error......");
    }
  }

  /// get Options Str.
  String _getOptionsStr(RequestOptions request) {
    return "method: " +
        request.method +
        "  baseUrl: " +
        request.baseUrl +
        "  path: " +
        request.path;
  }

  /// print Data Str.
  void _printDataStr(String tag, Object value) {
    String da = value.toString();
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("[$tag  ]:   " + da.substring(0, 512));
        da = da.substring(512, da.length);
      } else {
        print("[$tag  ]:   " + da);
        da = "";
      }
    }
  }

  /// get dio.
  Dio getDio() {
    return _dio;
  }

  /// create new dio.
  static Dio createNewDio([BaseOptions options]) {
    options = options ?? getDefOptions();
    Dio dio = new Dio(options);
    return dio;
  }

  /// get Def Options.
  static BaseOptions getDefOptions() {
    BaseOptions options = new BaseOptions();
    options.contentType = 'application/x-www-form-urlencoded';
    options.connectTimeout = 1000 * 30;
    options.receiveTimeout = 1000 * 30;
    return options;
  }
}
