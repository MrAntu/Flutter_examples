import 'package:flutter/material.dart';
import '../../common/commom_tool.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../utils/route_util.dart';
import '../../utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../components/toast.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _loadData() {
    UserProviders userProviders = context.read<UserProviders>();
    Future.wait({
      userProviders.loadUserData(),
      userProviders.loadPetList(),
    }).then((value) {
      print(value);
      _refreshController.refreshCompleted();
    }).catchError((err) {
      Toast.showError(err.toString());
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = CommonTool.hasLogin();
    UserProviders userProviders = context.watch<UserProviders>();

    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        elevation: 0, // 不添加底部阴影
        centerTitle: true,
        actions: _renderActions(),
      ),
      body: Container(
        color: Color(0xFFF1F1F1),
        child: SmartRefresher(
          controller: _refreshController,
          enablePullUp: false,
          enablePullDown: true,
          onRefresh: () {
            if (!isLogin) {
              _refreshController.refreshCompleted();
              return;
            }
            _loadData();
          },
          child: CustomScrollView(
            slivers: [
              _renderHeader(userProviders),
              _renderMiddleInfo(userProviders),
              _renderAnimalTitle(),
              _renderAnimalList(userProviders),
              _renderMineList(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _renderActions() {
    bool isLogin = CommonTool.hasLogin();
    List<Widget> actions = [];

    Widget message = IconButton(
        icon: Icon(Icons.notifications_active),
        onPressed: () {
          _refreshController.refreshCompleted();
        });
    actions.add(message);

    Widget setting = IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          if (isLogin) {
            RouteUtil.push(context, Routes.setting);
          } else {
            RouteUtil.push(context, Routes.login);
          }
        });
    actions.add(setting);
    return actions;
  }

  Widget _renderHeader(UserProviders userProviders) {
    bool isLogin = CommonTool.hasLogin();
    String imagePath = isLogin ? (userProviders.loginInfo.headImg ?? "") : "";
    String name = isLogin ? userProviders.loginInfo.nickname : '未登录';
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 110,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColor, BlendMode.srcOver),
              child: Image.asset(
                Utils.getImgPath('home_back'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isLogin) {
                RouteUtil.push(context, Routes.setting);
              } else {
                RouteUtil.push(context, Routes.login);
              }
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.fromLTRB(16, 16, 8, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ClipRRect(
                          child: CachedNetworkImage(
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                            imageUrl: imagePath,
//                            placeholder: (context, url) =>
//                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Image.asset(Utils.getImgPath('find_empty_img')),
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 30,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _renderMiddleInfo(UserProviders userProviders) {
    bool isLogin = CommonTool.hasLogin();
    final userData = userProviders.userData;
    if (!isLogin || userData == null) {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
    final titles = ['获赞', '粉丝', '关注'];
    final numbers = [
      userData.agreeCount,
      userData.fansCount,
      userData.followCount
    ];

    return SliverToBoxAdapter(
        child: Container(
      margin: EdgeInsets.all(16),
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(3, 3), blurRadius: 4),
            BoxShadow(
                color: Colors.black12, offset: Offset(-1, -1), blurRadius: 4),
          ]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: titles.map((e) {
            final index = titles.indexOf(e);
            final number = numbers[index];
            return GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$number',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF5D5D5D),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    e,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5D5D5D),
                    ),
                  )
                ],
              ),
            );
          }).toList()),
    ));
  }

  Widget _renderAnimalTitle() {
    bool isLogin = CommonTool.hasLogin();
    if (!isLogin) {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }

    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '我的宠物',
              style: TextStyle(fontSize: 15, color: Color(0xFF5D5D5D)),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: Color(0xFF868686),
              size: 18,
            )
          ],
        ),
      ),
    );
  }

  Widget _renderAnimalList(UserProviders userProviders) {
    bool isLogin = CommonTool.hasLogin();
    final petModel = userProviders.petModel;

    if (!isLogin || petModel == null) {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(right: 15),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Card(
              elevation: 0,
              color: Colors.transparent,
              margin: EdgeInsets.only(left: 16, bottom: 8),
              child: Container(
                width: 200,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        imageUrl: petModel.petImg,
//                        placeholder: (context, url) =>
//                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Image.asset(Utils.getImgPath('find_empty_img')),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            petModel.petName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF5D5D5D)),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            child: Text(
                              petModel.age ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFF5D5D5D)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _renderMineList() {
    final titls = ['设置主题', '设置语言', 'Tools'];
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: titls.map((e) {
            final index = titls.indexOf(e);
            final isLast = index == titls.length - 1;

            return GestureDetector(
              child: Container(
                height: 56,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color(0xFFEEEEEE),
                            width: isLast ? 0.001 : 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e,
                      style: TextStyle(fontSize: 16, color: Color(0xFF5D5D5D)),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Color(0xFFEEEEEE),
                      size: 18,
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
