import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../../components/action_sheet.dart';
import 'package:baby_pet/components/growth_alert.dart';
import '../mine/mine_page.dart';
import '../college/college_page.dart';
import '../find/find_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  final List<Widget> _pageList = [
    HomePage(),
    FindPage(),
    Container(),
    CollegePage(),
    MinePage(),
  ];

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _pageList,
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _itemList(),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Color(0xFF868686),
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        unselectedIconTheme: IconThemeData(color: Color(0xFF868686)),
        onTap: (index) {
          if (index == 2) {
//            Toast.showToast("123123123");
            ActionSheet.bottomSheet(context, GrowthAlert());
            return;
          }
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _itemList() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: '首页',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.insert_invitation),
        label: '发现',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.add_circle,
          size: 44,
          color: Theme.of(context).primaryColor,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chrome_reader_mode),
        label: '话题',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: '我的',
      ),
    ];
  }
}
