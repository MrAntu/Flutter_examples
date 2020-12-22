import 'package:flutter/material.dart';
import 'views/home_header.dart';
import '../../exports.dart';
import '../../components/stick_tabbar.dart';
import 'views/home_grass.dart';
import 'package:provider/provider.dart';
import '../../providers/home_grass_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  // 状态栏高度
  double flexHeaderHeight = 210 + ScreenUtil().statusBarHeight;

  final List<String> tabs = ['关注', '关注'];

  bool isScrollTop = false;

  ScrollController _scrollController = ScrollController();
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initStacte
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    final double _marginHeight = flexHeaderHeight - 56;
    _scrollController.addListener(() {
      if (_scrollController.offset > _marginHeight && !isScrollTop) {
        setState(() {
          isScrollTop = true;
        });
      } else if (_scrollController.offset < _marginHeight && isScrollTop) {
        setState(() {
          isScrollTop = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeGrassProvider(),
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (ctx, innerBoxIsScrolled) {
            return <Widget>[
              HomeHeader(scrollTop: isScrollTop),
              _renderCalendarHeader(),
              _renderTabHeader(),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              HomeGrass(),
              Text('2222222'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderTabHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickTabBarDelegate(
        child: TabBar(
          controller: _tabController,
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
          isScrollable: false,
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Color(0xFF5D5D5D),
          unselectedLabelColor: Color(0xFFC6C6C6),
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//          labelPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Widget _renderCalendarHeader() {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              iconSize: 18,
              icon: Image.asset(
                Utils.getImgPath('calendar'),
                color: Color(0xFF1a1a1a),
              ),
              onPressed: () {
                print('123123');
              })
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
