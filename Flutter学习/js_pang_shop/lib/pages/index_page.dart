import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:provider/provider.dart";
import '../provide/bottom_tabbar_index.dart';
class IndexPage extends StatelessWidget {

  final List<BottomNavigationBarItem> _bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text("首页")
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        title: Text("分类")
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: Text("购物车")
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: Text("会员中心")
    ),
  ];

  final List<Widget> _tabBodies = [
    HomePage(),
    CateroryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    // 适配不同机型屏幕大小
    // 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.init(context, width: 750, height: 1334);
    print("设备像素密度${ScreenUtil.pixelRatio}");
    print("设备的高${ScreenUtil.screenHeight}");
    print("设备的宽${ScreenUtil.screenWidth}");
    print("设备的状态栏高度${ScreenUtil.statusBarHeight}");
    return Consumer<BottomTabberIndexProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: provider.currentIndex,
            items: _bottomItems,
            onTap: (index) {
              provider.changeIndex(index);
            },
          ),
          body: IndexedStack(  //保持界面状态，必须使用此组件
            index: provider.currentIndex,
            children: _tabBodies,
          ),
        );
      },
    );
  }
}

