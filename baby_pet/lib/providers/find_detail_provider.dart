import 'view_state_provider.dart';
import '../models/comment_model.dart';
import '../models/focus_post_model.dart';
import '../models/detail_model.dart';
export '../models/comment_model.dart';
export '../models/focus_post_model.dart';
export '../models/detail_model.dart';
import '../exports.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
export 'view_state_provider.dart';

class FindDetailProvider extends ViewStateProvider {
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
  void dispose() {
    refreshController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
