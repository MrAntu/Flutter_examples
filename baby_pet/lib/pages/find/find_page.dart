import 'package:baby_pet/main.dart';
import 'package:flutter/material.dart';
import 'find_focus_page.dart';
import 'find_recommend_page.dart';

class FindPage extends StatefulWidget {
  const FindPage({Key key}) : super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final List<String> tabs = ['关注', '推荐', '话题'];
  List<Widget> tabViews = [
    FindFocusPage(),
    FindRecommendPage(),
    Text('555'),
  ];
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
          isScrollable: true,
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 2.5,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Color(0xFFEDF2FA),
          unselectedLabelColor: Color(0xFFA2ACBF),
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          labelPadding: EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabViews,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
