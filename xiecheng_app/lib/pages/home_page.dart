import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiecheng_app/dao/home_dao.dart';
import 'package:xiecheng_app/model/home_model.dart';
import 'package:xiecheng_app/widget/local_nav.dart';
import 'package:xiecheng_app/widget/grid_nav.dart';
import 'package:xiecheng_app/widget/sub_nav.dart';
import 'package:xiecheng_app/widget/loading_container.dart';
import 'package:xiecheng_app/util/navigator_util.dart';
import 'package:xiecheng_app/widget/webView.dart';
import 'package:xiecheng_app/widget/Search_bar.dart';
import 'package:xiecheng_app/pages/search_page.dart';
const APPBAR_SCROLL_OFFSET = 100.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  double _appBarAlpha = 0;
  List<BannerList> _bannerList = [];

//  List<String> _bannerList = [
//    'https://w4.hoopchina.com.cn/feedback_api/3c/ec/d6/3cecd619c5b3ebb95bf8fbda2ea6186c001.jpg',
//    'https://w4.hoopchina.com.cn/feedback_api/3c/ec/d6/3cecd619c5b3ebb95bf8fbda2ea6186c001.jpg',
//    'https://w4.hoopchina.com.cn/feedback_api/3c/ec/d6/3cecd619c5b3ebb95bf8fbda2ea6186c001.jpg',
//  ];
  List<LocalNavList> localNavList;
  GridNavModel gridNavModel;
  List<SubNavList> subNavList;
  bool isLoading = true;
  ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      print(_controller.offset);
      _onScroll(_controller.offset);
    });
      _getData();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Future<Null> _getData() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        _bannerList = model.bannerList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      print(e);
    }

    return null;
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1 ) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });

    print(alpha);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
      // 移除顶部安全区域
        body: LoadingContainer(
            child: Stack(
              children: [
                MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    // 监听listView的滚动
                    child: RefreshIndicator(
                        onRefresh: _getData,
                        child: _listView(),
//                        child: NotificationListener(
//                            onNotification: (scrolNotification) {
//                              // 过滤多余的监听,只监听更新的通知，只监听第0个元素，就是listView，不需要监听banner的横向滚动
//                              if (scrolNotification is ScrollUpdateNotification &&
//                                  scrolNotification.depth == 0 ) {
//                                _onScroll(scrolNotification.metrics.pixels);
//                              }
//                              return true;
//                            },
//                            child: _listView()
//                        ),
                    )
                ),

                _appBar()
              ],
            ),
            isLoading: isLoading
        )
    );
  }

  _appBar() {
    return Column(
//      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((_appBarAlpha * 255).toInt(), 255, 255, 255)
            ),
            child: SearchBar(
              searchBarType: _appBarAlpha > 0.2
                ? SearchBarType.homeLight : SearchBarType.home,
              inputBoxClick: _jumpSearch,
              speakButtonClick: () {
                print('speakButtonClick');
              },
              defaultText: '水电费就开始京东方开局亏',
              leftButtonClick: () {
                print("leftButtonClick");
              },
            ),
          )
        ),
        Container(
          height: _appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        )
      ],
    );

  }

  _jumpSearch() {
    NavigatorUtil.push(context, SearchPage(
      hint: '水电费水电费',
      hideLeft: false,
    ));
  }

  _listView() {
    return ListView(
      controller: _controller,
      children: [
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(list: localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(model: gridNavModel),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(list: subNavList),
        ),
        Container(
          height: 800,
          child: ListTile(
            title: Text('哈还是12312'),
          ),
        )
      ],
    );
  }

  Widget get _banner {
    return Container(
      height: 160,
      color: Colors.yellow,
      child: Swiper(
        itemCount: _bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              BannerList model = _bannerList[index];
              NavigatorUtil.push(context, WebView(
                url: model.url,
                title: "",
                hideAppBar: false,
              ));
            },
            child: Image.network(
              _bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
