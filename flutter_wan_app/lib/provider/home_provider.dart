import 'package:flutter/material.dart';
import '../common/strings.dart';
import '../tools/http_utils.dart';
import '../models/models.dart';
import '../data/protocol/protocols.dart';
import '../data/repository/wan_respository.dart';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';
import 'event.dart';
import '../tools/object_util.dart';

class HomeProvider with ChangeNotifier {
  ComModel hotRecModel;
  VersionModel _versionModel;
  int _reposPage = 0;

  List<ReposModel> _reposList;
  List<ReposModel> get reposList => _reposList;

  List<ReposModel> _wxArticleList;
  List<ReposModel> get wxArticleList => _wxArticleList;

  List<BannerModel> _bannerList;
  List<BannerModel> get bannerList => _bannerList;

  List<ReposModel> _articleList;
  List<ReposModel> get articleList => _articleList;

  WanRepository wanRepository = WanRepository();
  // 网络事件
  var _homeEvent = BehaviorSubject<StatusEvent>();
  Stream<StatusEvent> get homeStream => _homeEvent.stream;

  var _reposEvent = BehaviorSubject<StatusEvent>();
  Stream<StatusEvent> get reposEvent => _reposEvent.stream;

  getData({String lableId, int page}) {
    switch (lableId) {
      case Ids.titleHome:
        getHomeData(lableId);
        break;
      case Ids.titleRepos:
        getArticleListProject(lableId, page);
        break;
      default:
        break;
    }
  }

  Future getArticleListProject(String labelId, int page) {
    return wanRepository.getArticleListProject(page).then((list) {
      if (_articleList == null) {
        _articleList = List();
      }

      StatusEventType type = ObjectUtil.isEmpty(list)
          ? StatusEventType.noMore
          : StatusEventType.success;

      if (page == 0) {
        _articleList.clear();
        _reposEvent.add(
            StatusEvent(labelId, type, loadType: StatusEventLoadType.header));
      } else {
        _reposEvent.add(StatusEvent(labelId, type));
      }
      _articleList.addAll(list);
      notifyListeners();
    }).catchError((e) {
      if (ObjectUtil.isEmpty(_articleList)) {}
      _reposPage--;
      _reposEvent.add(StatusEvent(labelId, StatusEventType.faild));
    });
  }

  getHomeData(String lableId) {
    Future.wait({
      getRecRepos(lableId),
      getBanner(lableId),
      getRecWxArticle(lableId)
    }).then((value) {
      notifyListeners();
      _homeEvent.add(StatusEvent(lableId, StatusEventType.success));
    }).catchError((e) {
      print(e);
      _homeEvent.add(StatusEvent(lableId, StatusEventType.faild));
    });
  }

  Future getBanner(String lableId) {
    return wanRepository.getBanner().then((value) {
      _bannerList = UnmodifiableListView<BannerModel>(value);
    });
  }

  Future getRecRepos(String lableId) {
    ComReq _comReq = ComReq(402);
    return wanRepository.getProjectList(data: _comReq.toJson()).then((list) {
      if (list.length > 6) {
        list = list.sublist(0, 6);
        _reposList = UnmodifiableListView<ReposModel>(list);
      }
    });
  }

  Future getRecWxArticle(String lableId) async {
    int _id = 408;
    return wanRepository.getWxArticleList(id: _id).then((list) {
      if (list.length > 6) {
        list = list.sublist(0, 6);
      }
      _wxArticleList = UnmodifiableListView<ReposModel>(list);
    });
  }

  onRefresh({String lableId, bool isReload}) {
    switch (lableId) {
      case Ids.titleHome:
        break;
      case Ids.titleRepos:
        _reposPage = 0;
        break;
      default:
        break;
    }

    print("onRefresh labelId: $lableId" + "_reposPage: $_reposPage");
    getData(lableId: lableId, page: 0);
  }

  onLoadMore({String labelId}) {
    int _page = 0;
    switch (labelId) {
      case Ids.titleHome:
        break;
      case Ids.titleRepos:
        _page = ++_reposPage;
        break;
      case Ids.titleSystem:
        break;
      default:
        break;
    }
    return getData(lableId: labelId, page: _page);
  }

  getHotRecItem() async {
    HttpUtils.getRecItem().then((value) {
      hotRecModel = value;
      notifyListeners();
    });
  }

  getVersion() async {
    HttpUtils.getVersion().then((model) {
      _versionModel = model;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _homeEvent.close();
    _reposEvent.close();
    // TODO: implement dispose
    super.dispose();
  }
}
