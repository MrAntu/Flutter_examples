import 'package:flutter/material.dart';
import '../../../models/grass_model.dart';
import '../../../components/empty_widget.dart';
import '../../../exports.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../providers/home_grass_provider.dart';
import 'package:provider/provider.dart';
import 'home_grid_item.dart';

class HomeGrass extends StatefulWidget {
  const HomeGrass({Key key}) : super(key: key);

  @override
  _HomeGrassState createState() => _HomeGrassState();
}

class _HomeGrassState extends State<HomeGrass>
    with AutomaticKeepAliveClientMixin {
//  List<GrassModel> modelList = [];
  int pageIndex = 1;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (CommonTool.hasLogin()) {
      _refreshData();
    }
  }

  void _refreshData() {
    _refreshController.resetNoData();
    _requestGrass(1);
  }

  void _loadMoreData() {
    pageIndex += 1;
    _requestGrass(pageIndex);
  }

  void _requestGrass(int pageIndex) {
    Request.requestHomeGrass(pageIndex, CommonTool.loginInfo.userId)
        .then((value) {
      HomeGrassProvider homeGrassProvider = context.read<HomeGrassProvider>();
      var list = homeGrassProvider.modelList;
      if (pageIndex == 1) {
        list = value;
      } else {
        list.addAll(value);
      }
      _refreshController.refreshCompleted();
      if (value.length < 10) {
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
      homeGrassProvider.setModelList(list);
      print(value);
    }).catchError((err) {
      Toast.showError(err.toString());
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeGrassProvider>(
      builder: (ctx, model, child) {
        if (model.modelList.length == 0) {
          return EmptyWidget(
            showReload: true,
            offsetY: 16,
            onPressed: () {
              _refreshData();
            },
          );
        }

        return SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: _refreshData,
          onLoading: _loadMoreData,
          child: StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              padding: EdgeInsets.all(8),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemCount: model.modelList.length,
              itemBuilder: (context, index) {
                var grassModel = model.modelList[index];
                return HomeGridItem(
                  model: grassModel,
                  actionCallBack: (model) {
                    print(model.toJson());
                    Map<String, dynamic> map = Map();
                    map['trialId'] = model.trialReportId;
                    map['callBack'] = callBack;
                    RouteUtil.push<Map<String, dynamic>>(
                        context, Routes.grassDetail, map);
                  },
                );
              },
              staggeredTileBuilder: (_) => StaggeredTile.fit(1)),
        );
      },
    );
  }

  void callBack(GrassModel model) {
    print(model);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
