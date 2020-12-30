/// 创建时间：12/29/20
/// 作者：weiwei.li
/// 描述：

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../models/detail_model.dart';
import '../../models/comment_model.dart';
import '../../components/toast.dart';
import '../request/request.dart';
import 'base_controller.dart';
import 'package:get/get.dart';
export 'base_controller.dart';

class DetailController extends BaseController {
  int pageIndex = 1;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  DetailModel detailModel;
  List<CommentModel> commentList = [];

  Future refreshData(int messageId, {bool first = false}) async {
    firstLoding = first;
    pageIndex = 1;
    refreshController.resetNoData();
    try {
      var data = await Future.wait<dynamic>(
          [requestFindDetail(messageId), requestCommentList(messageId)]);
      refreshController.refreshCompleted();
      if (commentList.isEmpty) {
        setEmpty();
      } else {
        setIdle();
      }
      return data;
    } catch (e, s) {
      refreshController.refreshCompleted();
      setError(e, s);
      return null;
    }
  }

  Future<List<CommentModel>> loadMoreData(int messageId) async {
    pageIndex += 1;
    try {
      var data = await requestCommentList(messageId);
      refreshController.loadComplete();
      setIdle();
      return data;
    } catch (e, s) {
      refreshController.loadComplete();
      setError(e, s);
      Toast.showError(e.toString());
      return null;
    }
  }

  Future<DetailModel> requestFindDetail(int messageId) {
    return Request.requestFindDetail(messageId).then((value) {
      detailModel = value;
      return Future.value(value);
    });
  }

  Future<List<CommentModel>> requestCommentList(int messageId) {
    return Request.requestCommentList(messageId, pageIndex).then((value) {
      if (pageIndex == 1) {
        commentList = value;
      } else {
        commentList.addAll(value);
      }
      if (value.length < 10) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      return Future.value(value);
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('DetailController onInit');
  }

  @override
  void onClose() {
    // TODO: implement onClose
    // refreshController.dispose();
    print('DetailController onClose');
    super.onClose();
  }
}
