import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/focus_model.dart';
import '../models/focus_post_model.dart';
import '../pages/request/request.dart';
import '../exports.dart';
import 'view_state_provider.dart';
export 'view_state_provider.dart';
export '../models/focus_model.dart';
export '../models/focus_post_model.dart';
export '../models/comment_model.dart';

class FindFocusProvider extends ViewStateProvider {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  List<FocusModel> recomFocusList = [];
  List<FocusPostModel> focusPostList = [];
  int _pageIndex = 1;

  Future refreshData({bool first = false}) async {
    firstLoding = first;
    if (!CommonTool.hasLogin()) {
      return Future.value(null);
    }

    _pageIndex = 1;
    _refreshController.resetNoData();
    try {
      var data =
          await Future.wait<dynamic>([loadRecomFocus(), loadFocusList()]);
      _refreshController.refreshCompleted();
      if (focusPostList.isEmpty) {
        setEmpty();
      } else {
        setIdle();
      }
      return data;
    } catch (e, s) {
      _refreshController.refreshCompleted();
      setError(e, s);
      return null;
    }
  }

  Future<List<FocusPostModel>> loadMoreData() async {
    _pageIndex += 1;
    try {
      var data = await loadFocusList();
      _refreshController.loadComplete();
      setIdle();
      return data;
    } catch (e, s) {
      _refreshController.loadComplete();
      setError(e, s);
      Toast.showError(e.toString());
      return null;
    }
  }

  Future<List<FocusModel>> loadRecomFocus() {
    return Request.requestRecomFouc().then((value) {
      recomFocusList = value;
      return Future.value(value);
    });
  }

  Future<List<FocusPostModel>> loadFocusList() {
    return Request.requestFoucsPostList(_pageIndex).then((value) {
      if (_pageIndex == 1) {
        focusPostList = value;
      } else {
        focusPostList.addAll(value);
      }
      if (value.length < 10) {
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
      return Future.value(value);
    });
  }

  @override
  @mustCallSuper
  void dispose() {
    // TODO: implement dispose
    _refreshController.dispose();
    print("object2");
    super.dispose();
  }
}
