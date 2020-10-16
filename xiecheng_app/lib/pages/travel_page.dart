import 'package:flutter/material.dart';
import 'package:xiecheng_app/model/travel_tab_model.dart';
import 'package:xiecheng_app/dao/travle_tab_dao.dart';
import 'package:xiecheng_app/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  TravelPage({Key key}) : super(key: key);

  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  TabController _controller;
  TravelTabModel travelTabModel;
  List<TravelTab> tabs = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    _getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _getData() {
    TravelTabDao.fetch().then((TravelTabModel model) {
      // 必须重新初始化才刷新
      _controller = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        travelTabModel = model;
        tabs = model.tabs;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
              controller: _controller,
              isScrollable: true,
              labelColor: Colors.black,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Color(0xff2fcfbb),
                  width: 3
                ),
                insets: EdgeInsets.only(bottom: 10)
              ),
              tabs: tabs.map((e) => Tab(text: e.labelName,)).toList(),
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: tabs.map((e) => TravelTabPage(
                travelUrl: travelTabModel.url,
                params: travelTabModel.params,
                groupChannelCode: e.groupChannelCode,
              )).toList(),
            ),
          )
        ],
      )
    );
  }
}