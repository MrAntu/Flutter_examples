import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/status_widget.dart';
import '../tools/utils.dart';
import '../provider/event.dart';
import '../data/protocol/protocols.dart';
import 'package:flukit/flukit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/repos_item_widget.dart';
import '../widgets/header_item.dart';
import '../common/strings.dart';
import '../widgets/article_item.dart';

class ReposPage extends StatefulWidget {
  final String labelId;

  const ReposPage({Key key, this.labelId}) : super(key: key);

  @override
  _ReposPageState createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController();
  ScrollController _scrollController;
  bool isShowFloatBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _requestData();
    context.read<HomeProvider>().reposEvent.listen((event) {
      if (event.loadType == StatusEventLoadType.header) {
        _refreshController.refreshCompleted();
        return;
      }

      if (event.status == StatusEventType.noMore) {
        _refreshController.loadNoData();
      } else if (event.status == StatusEventType.success) {
        _refreshController.loadComplete();
      } else {
        _refreshController.loadComplete();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        int offset = _scrollController.offset.toInt();
        if (offset < 480 && isShowFloatBtn) {
          isShowFloatBtn = false;
          setState(() {});
        } else {
          isShowFloatBtn = true;
          setState(() {});
        }
      });
    });
  }

  _requestData() {
    context.read<HomeProvider>().onRefresh(lableId: widget.labelId);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("pull up load");
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("release to load more");
                    } else {
                      body = Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: _refreshController,
//                scrollController: _scrollController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (ctx, index) {
                    return ReposItem(
                        model: model.articleList[index],
                        labelId: widget.labelId,
                        isHome: false);
                  },
                  itemCount: model.articleList?.length ?? 0,
                ),
              ),
              StatusViews(
                Utils.getLoadStatus(false, model.bannerList),
                onTap: () {
                  print('重新请求网络');
                },
              )
            ],
          ),
          floatingActionButton: buildFloatingActionButton(),
        );
      },
    );
  }

  Widget buildFloatingActionButton() {
    if (!_scrollController.hasClients) {
      return null;
    }
    if (_scrollController == null || _scrollController.offset < 480) {
      return null;
    }

    return new FloatingActionButton(
        heroTag: widget.labelId,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.keyboard_arrow_up,
        ),
        onPressed: () {
          //_controller.scrollTo(0.0);
          _scrollController.animateTo(0.0,
              duration: new Duration(milliseconds: 300), curve: Curves.linear);
        });
  }

  void _onRefresh() async {
    context.read<HomeProvider>().onRefresh(lableId: widget.labelId);
//    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    context.read<HomeProvider>().onLoadMore(labelId: widget.labelId);
//    _refreshController.loadComplete();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(top: 10, right: 5),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Text(
        '${++index}/$itemCount',
        style: TextStyle(color: Colors.white70, fontSize: 11),
      ),
    );
  }
}
