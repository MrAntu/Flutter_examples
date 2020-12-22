import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../utils/dio_tool/dio_tool.dart';
import '../../utils/dio_tool/base_resp.dart';

import '../../models/login_info.dart';
import '../../models/pet_model.dart';
import '../../models/user_data.dart';
import '../../common/commom_tool.dart';
import '../../models/grass_model.dart';
import '../../models/focus_model.dart';
import '../../models/focus_post_model.dart';
import '../../models/error_model.dart';
import '../../models/detail_model.dart';
import '../../models/comment_model.dart';

class FindURL {
  /// 发现轮播图: /user/messageLabel/v2006/lt/selectMessageLabelList?pageIndex=1&pageSize=5
  static const String selectMessageLabelList =
      'user/messageLabel/v2006/lt/selectMessageLabelList';

  /// 发现--推荐接口: user/message/selectMessageRecommendList?messageTotal=8022&pageIndex=2&reportTotal=483&userLoginId=136899
  static const String selectMessageRecommendList =
      'user/message/selectMessageRecommendList';

  /// 发现-附近: /user/message/getMessageNearby?latitude=30.285382&longitude=120.036424&pageIndex=1&pageSize=10&total=0&userLoginId=136899
  static const String getMessageNearby = 'user/message/getMessageNearby';

  /// 发现-动态详情: user/message/detail?messageId=29720&userId=136899
  static const String find_detail = 'user/message/detail';

  /// 发现关注-推荐关注列表: user/relation/selectNotRelation?pageIndex=1&pageSize=3&userLoginId=136899
  static const String selectNotRelation = 'user/relation/selectNotRelation';

  /// 发现关注-动态列表: user/message/selectPageList?listType=2&pageIndex=2&pageSize=10&total=388&userLoginId=136899
  static const String user_selectNotRelation = 'user/message/selectPageList';

  /// 发现-点赞: user/agree/updateAgree?agreeStatus=0&messageId=29720&userId=136899
  /// 点赞评论: agreeStatus=0&commentId=34161&userId=136899
  /// agreeStatus: 0点赞, 1: 取消
  static const String updateAgree = 'user/agree/updateAgree';

  /// 发现-收藏(post): user/collections/update
  /// collectionsStatus=0&messageId=29716&token=&userId=136899
  /// collectionsStatus: 0收藏, 1取消
  static const String user_collection = 'user/collections/update';

  /// 发现-评论列表: user/comment/selectCommentPage?messageId=29716&pageIndex=1&pageSize=10&replySize=5&userId=136899&userLoginId=136899
  static const String selectCommentPage = 'user/comment/selectCommentPage';

  /// 发现-评论内容(post): user/comment/save
  /// commentInfo=&messageId=29716&token=&userId=136899
  static const String comment_save = 'user/comment/save';

  /// 发现-评论-二级评论内容(post): user/commentReply/save
  /// beReplyedUserId=120987&commentId=35318&commentInfo=&replyUserId=136899&token=
  static const String comment_reply_save = 'user/commentReply/save';

  /// 发现-删除评论: user/comment/delete?commentId=35327&userLoginId=136899
  static const String comment_delete = 'user/comment/delete';

  /// 发现-关注: user/relation/UpdateAttation?isFlag=0&userByid=147280&userId=136899
  /// isFlag: 0关注, 1取消关注
  static const String updateAttation = 'user/relation/UpdateAttation';

  /// 发现-关注列表: user/relation/selectMyAttention?pageIndex=1&pageSize=15&userId=136899&userLoginId=136899
  static const String selectMyAttention = 'user/relation/selectMyAttention';

  /// 发现--视频列表: user/message/selectCurrentVideoPage?messageId=29801&orderColumn=create_time&pageIndex=1&pageSize=10&userLoginId=136899
  static const String selectCurrentVideoPage =
      'user/message/selectCurrentVideoPage';

  /// 话题讨论: user/messageLabel/getMessageAndReportBylabel?messageLabelId=399&orderType=1&pageIndex=1&pageSize=10&userLoginId=136899
  /// orderType: 热门1, 最新2
  static const String getMessageBylabel =
      'user/messageLabel/getMessageAndReportBylabel';
}

class Request {
  static Future<LoginInfo> getLoginInfo(Map<String, dynamic> params) async {
    BaseResp<Map<String, dynamic>> baseResp =
        await DioTool().post(DioPath.applogin, params: params);
    if (!baseResp.isSuccess) {
      return Future.error(ErrorModel(baseResp.msg,
          code: baseResp.code, errorType: ErrorModelType.defaultError));
    }
    LoginInfo loginInfo;
    if (baseResp.data != null) {
      loginInfo = LoginInfo.fromJson(baseResp.data);
    }
    return loginInfo;
  }

  static Future<List<PetModel>> getPetList(String userId) async {
    Map<String, dynamic> params = Map();
    params['userId'] = userId ?? " ";
    BaseResp<List> baseResp =
        await DioTool().get(DioPath.selectUserId, params: params);
    if (!baseResp.isSuccess) {
      return Future.error(ErrorModel(baseResp.msg,
          code: baseResp.code, errorType: ErrorModelType.defaultError));
    }
    List<PetModel> list;
    if (baseResp.data != null) {
      list = baseResp.data.map((e) {
        return PetModel.fromJson(e);
      }).toList();
    }
    return list;
  }

  static Future<UserData> getUserData(String userId) async {
    Map<String, dynamic> params = Map();
    params['userId'] = userId ?? " ";
    params['token'] = CommonTool.loginInfo.token ?? "";
    BaseResp<Map<String, dynamic>> baseResp =
        await DioTool().get(DioPath.userIndex, params: params);
    if (!baseResp.isSuccess) {
      return Future.error(ErrorModel(baseResp.msg,
          code: baseResp.code, errorType: ErrorModelType.defaultError));
    }
    UserData data;
    if (baseResp.data != null) {
      data = UserData.fromJson(baseResp.data);
    }
    return data;
  }

  static Future<List<GrassModel>> requestHomeGrass(
      int pageIndex, int userId) async {
    final token = CommonTool.loginInfo.token;
    final url =
        '${DioPath.getTrialReportList}?auditStatus=1&pageIndex=$pageIndex&pageSize=10&userLoginId=${userId}&token=${token}';

    BaseResp<Map<String, dynamic>> baseResp = await DioTool().get(url);
    if (!baseResp.isSuccess) {
      return Future.error(ErrorModel(baseResp.msg,
          code: baseResp.code, errorType: ErrorModelType.defaultError));
    }
    List<GrassModel> list = [];
    if (baseResp.data != null) {
      List<dynamic> jsonArr = baseResp.data['records'] ?? [];
      for (var json in jsonArr) {
        Map<String, dynamic> mapJson = json;
        GrassModel model = GrassModel.fromJson(mapJson);
        list.add(model);
      }
    }
    return list;
  }

  static Future<GrassModel> loadGrassDetail(int trialId) async {
    Map<String, dynamic> params = Map();
    final token = CommonTool.loginInfo.token;
    final userId = CommonTool.loginInfo.userId;

    params['loginUserId'] = userId ?? " ";
    params['token'] = token ?? "";
    params['trialReportId'] = trialId;

    BaseResp<Map<String, dynamic>> baseResp =
        await DioTool().post(DioPath.getTrialReportInfo, params: params);
    if (!baseResp.isSuccess) {
      return Future.error(ErrorModel(baseResp.msg,
          code: baseResp.code, errorType: ErrorModelType.defaultError));
    }
    GrassModel data;
    if (baseResp.data != null) {
      data = GrassModel.fromJson(baseResp.data);
    }
    return data;
  }

  // 发现-关注-推荐关注
  static Future<List<FocusModel>> requestRecomFouc() async {
    final token = CommonTool.loginInfo.token;
    final userId = CommonTool.loginInfo.userId;
    final url =
        '${FindURL.selectNotRelation}?pageIndex=1&pageSize=3&userLoginId=${userId}&token=${token}';

    BaseResp<Map<String, dynamic>> baseResp = await DioTool().get(url);
    if (!baseResp.isSuccess) {
      return Future.error(ErrorModel(baseResp.msg,
          code: baseResp.code, errorType: ErrorModelType.defaultError));
    }
    List<FocusModel> list = [];
    if (baseResp.data != null) {
      List<dynamic> jsonArr = baseResp.data['records'] ?? [];
      for (var json in jsonArr) {
        Map<String, dynamic> mapJson = json;
        FocusModel model = FocusModel.fromJson(mapJson);
        list.add(model);
      }
    }
    return list;
  }

  // 发现-关注-动态列表
  static Future<List<FocusPostModel>> requestFoucsPostList(
      int pageIndex) async {
    final token = CommonTool.loginInfo.token;
    final userId = CommonTool.loginInfo.userId;
    final url =
        '${FindURL.user_selectNotRelation}?listType=2&total=388&pageIndex=${pageIndex}&pageSize=10&userLoginId=${userId}&token=${token}';

    BaseResp<Map<String, dynamic>> baseResp = await DioTool().get(url);
    if (!baseResp.isSuccess) {
      return Future.error(ErrorModel(baseResp.msg,
          code: baseResp.code, errorType: ErrorModelType.defaultError));
    }
    List<FocusPostModel> list = [];
    if (baseResp.data != null) {
      List<dynamic> jsonArr = baseResp.data['records'] ?? [];
      for (var json in jsonArr) {
        Map<String, dynamic> mapJson = json;
        FocusPostModel model = FocusPostModel.fromJson(mapJson);
        list.add(model);
      }
    }
    return list;
  }

  // 详情
  static Future<DetailModel> requestFindDetail(int messageId) async {
    Map<String, dynamic> params = Map();
    final token = CommonTool.loginInfo.token;
    final userId = CommonTool.loginInfo.userId;

    params['userId'] = userId ?? " ";
    params['token'] = token ?? "";
    params['messageId'] = messageId;

    BaseResp<Map<String, dynamic>> baseResp =
        await DioTool().get(FindURL.find_detail, params: params);
    if (!baseResp.isSuccess) {
      return Future.error(ErrorModel(baseResp.msg,
          code: baseResp.code, errorType: ErrorModelType.defaultError));
    }
    DetailModel data;
    if (baseResp.data != null) {
      data = DetailModel.fromJson(baseResp.data);
    }
    return data;
  }

  /// 发现-动态详情-评论列表
  static Future<List<CommentModel>> requestCommentList(
      int messageId, int pageIndex) async {
    Map<String, dynamic> params = Map();
    final token = CommonTool.loginInfo.token;
    final userId = CommonTool.loginInfo.userId;

    params['userId'] = userId ?? " ";
    params['userLoginId'] = userId ?? " ";
    params['token'] = token ?? "";
    params['messageId'] = messageId;
    params['pageIndex'] = pageIndex;
    params['pageSize'] = 10;
    params['replySize'] = 5;

    BaseResp<Map<String, dynamic>> baseResp =
        await DioTool().get(FindURL.selectCommentPage, params: params);
    if (!baseResp.isSuccess) {
      return Future.error(ErrorModel(baseResp.msg,
          code: baseResp.code, errorType: ErrorModelType.defaultError));
    }
    List<CommentModel> list = [];
    if (baseResp.data != null) {
      List<dynamic> jsonArr = baseResp.data['records'] ?? [];
      for (var json in jsonArr) {
        Map<String, dynamic> mapJson = json;
        CommentModel model = CommentModel.fromJson(mapJson);
        list.add(model);
      }
    }
    return list;
  }
}
