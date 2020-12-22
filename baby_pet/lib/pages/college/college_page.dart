import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import '../../components/stick_tabbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CollegePage extends StatefulWidget {
  const CollegePage({Key key}) : super(key: key);

  @override
  _CollegePageState createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  TabController primaryTC;
  ScrollController sc = ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _itemCount = 50;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    primaryTC = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    primaryTC.dispose();
    sc.dispose();
    _refreshController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final double statusBarHeight = ScreenUtil().statusBarHeight;
    final double pinnerHeaderHeight = statusBarHeight + kToolbarHeight;
    return NestedScrollView(
      headerSliverBuilder: (ctx, bool f) {
        return [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            title: Text('红薯粉丝'),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                color: Colors.black,
              ),
            ),
          ),
//          SliverToBoxAdapter(
//            child: Container(
//              height: 50,
//              color: Colors.green,
//            ),
//          )
        ];
      },
      pinnedHeaderSliverHeightBuilder: () {
        return pinnerHeaderHeight;
      },
      innerScrollPositionKeyBuilder: () {
        String index = 'Tab';
        index += primaryTC.index.toString();
        return Key(index);
      },
      body: Column(
        children: [
          TabBar(
            controller: primaryTC,
            tabs: [
              Tab(text: 'Tab0'),
              Tab(text: 'Tab1'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: primaryTC,
              children: [
                NestedScrollViewInnerScrollPositionKeyWidget(
                  const Key('Tab0'),
                  SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: false,
                    enablePullUp: false,
                    onRefresh: () {
                      Future.delayed(Duration(seconds: 3)).then((value) {
                        _refreshController.refreshCompleted();
                        _itemCount = 50;
                        setState(() {});
                      });
                    },
                    onLoading: () {
                      Future.delayed(Duration(seconds: 3)).then((value) {
                        _refreshController.loadComplete();
                        _itemCount += 20;
                        setState(() {});
                      });
                    },
                    child: ListView.builder(
                      key: const PageStorageKey<String>('Tab0'),
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return Container(
                          height: 100,
                          color: Colors.green,
                          child: Text('$index -- tab0'),
                        );
                      },
                      itemCount: _itemCount,
                      padding: const EdgeInsets.all(0.0),
                    ),
                  ),
                ),
                NestedScrollViewInnerScrollPositionKeyWidget(
                  const Key('Tab1'),
                  ListView.builder(
                    key: const PageStorageKey<String>('Tab1'),
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return Container(
                        height: 100,
                        color: Colors.green,
                        child: Text('$index -- tab1'),
                      );
                    },
                    itemCount: 50,
                    padding: const EdgeInsets.all(0.0),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
