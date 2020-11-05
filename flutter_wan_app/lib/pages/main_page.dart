import 'package:flutter/material.dart';
import '../tools/utils.dart';
import 'home_page.dart';
import 'main_left_page.dart';
import '../common/strings.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';
import 'repos_page.dart';
import '../tools/custom_intl/custom_intl.dart';

class _Page {
  final String labelId;

  _Page(this.labelId);
}

final List<_Page> _allPages = <_Page>[
  _Page(Ids.titleHome),
  _Page(Ids.titleRepos),
  _Page(Ids.titleEvents),
  _Page(Ids.titleSystem),
];

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _allPages.length,
        child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(
                    icon: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:
                                  AssetImage(Utils.getImgPath('ali_connors')))),
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    });
              },
            ),
            centerTitle: true,
            title: TabLayout(),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: null)
            ],
          ),
          body: TabBarViewLayout(),
          drawer: Drawer(
            child: MainLeftPage(),
          ),
        ));
  }
}

class TabLayout extends StatelessWidget {
  const TabLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.all(12),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _allPages.map((e) {
        return Tab(
          text: IntlUtil.getString(context, e.labelId),
        );
      }).toList(),
    );
  }
}

class TabBarViewLayout extends StatelessWidget {
  const TabBarViewLayout({Key key}) : super(key: key);

  Widget buildTabView(BuildContext context, _Page page) {
    String labelId = page.labelId;
    switch (labelId) {
      case Ids.titleHome:
        return HomePage(
          labelId: labelId,
        );
      case Ids.titleRepos:
        return ReposPage(
          labelId: labelId,
        );
      case Ids.titleEvents:
        return HomePage(
          labelId: labelId,
        );
      case Ids.titleSystem:
        return HomePage(
          labelId: labelId,
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: TabBarView(
          children: _allPages.map((e) => buildTabView(context, e)).toList()),
    );
  }
}
