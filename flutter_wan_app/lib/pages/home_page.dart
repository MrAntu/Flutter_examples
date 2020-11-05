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

class HomePage extends StatefulWidget {
  final String labelId;

  const HomePage({Key key, this.labelId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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
    context.read<HomeProvider>().homeStream.listen((event) {
      _refreshController.refreshCompleted();
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
                enablePullUp: false,
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
                child: ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom),
                  children: [
                    buildBanner(context, model.bannerList),
                    // 推荐项目
                    buildRepos(context, model.reposList),
                    // 推荐公众号
                    buildWxArticle(context, model.wxArticleList),
                  ],
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
//    context.read<HomeProvider>().onRefresh(lableId: widget.labelId);
//    _refreshController.loadComplete();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Widget buildBanner(BuildContext context, List<BannerModel> list) {
    if (list == null || list.isEmpty) {
      return Container(
        height: 0,
      );
    }
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Swiper(
        indicatorAlignment: AlignmentDirectional.topEnd,
        circular: true,
        interval: Duration(seconds: 3),
        indicator: NumberSwiperIndicator(),
        children: list.map((model) {
          return InkWell(
            onTap: () {
              print('点击了banner');
            },
            child: CachedNetworkImage(
              imageUrl: model.imagePath,
              fit: BoxFit.fill,
              placeholder: (context, url) => ProgressView(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildRepos(BuildContext context, List<ReposModel> list) {
    if (list == null || list.isEmpty) {
      return Container(
        height: 0,
      );
    }

    List<Widget> _children = list.map((model) {
      return ReposItem(model: model, labelId: widget.labelId, isHome: true);
    }).toList();

    List<Widget> children = List();
    children.add(HeaderItem(
      leftIcon: Icons.book,
      titleId: Ids.recRepos,
      onTap: () {
        print("点击推荐项目");
      },
    ));
    children.addAll(_children);

    return Column(
      children: children,
    );
  }

  Widget buildWxArticle(BuildContext context, List<ReposModel> list) {
    if (list == null || list.isEmpty) {
      return Container(
        height: 0,
      );
    }
    List<Widget> _children = list.map((model) {
      return new ArticleItem(
        model,
        isHome: true,
      );
    }).toList();

    List<Widget> children = new List();
    children.add(new HeaderItem(
      titleColor: Colors.green,
      leftIcon: Icons.library_books,
      titleId: Ids.recWxArticle,
      onTap: () {
        print('推荐公众号');
      },
    ));
    children.addAll(_children);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
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
