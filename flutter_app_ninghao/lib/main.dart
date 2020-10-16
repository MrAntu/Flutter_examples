import 'package:flutter/material.dart';
import 'demo/listViewDemo.dart';
import 'demo/drawerDemo.dart';
import 'demo/BottomNavagitonBarDemo.dart';
import 'demo/basicDemo.dart';
import 'demo/layoutDemo.dart';
import 'demo/viewDemo.dart';
import 'demo/sliverDemo.dart';
import 'demo/navigatorDemo.dart';
import 'demo/formDemo.dart';
import 'demo/materialComponents.dart';
import 'demo/stateManagerDemo.dart';
import 'demo/streamDemo.dart';
import 'demo/rxdartDemo.dart';
import 'demo/bloc/blocDemo.dart';
import 'demo/http/http_demo.dart';
import 'demo/animation/animationDemo.dart';
import 'demo/i18n/i18nDemo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'demo/i18n/map/MapLocalizations.dart';
import 'demo/i18n/intl/intlLocalizations.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      locale: Locale("zh", "CN"),  //设置当前应用的语言
//        typedef LocaleListResolutionCallback = Locale Function(List<Locale> locales, Iterable<Locale> supportedLocales);

      localeResolutionCallback: (locale, supportedLocales) {
        print("${locale.toString()}");
        return Locale('zh', 'CN');
      },

      localizationsDelegates: [
//        MapLocalizationsDelegate(), //自定义
        IntlLocationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
      title: 'Flutter Demo',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
//      showSemanticsDebugger: true,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        highlightColor: Color.fromRGBO(255, 255, 255, 0.5), //按钮选中高亮颜色
        splashColor: Colors.white70, //点击按钮后，水波纹的颜色。material风格,
        accentColor: Colors.green
      ),

//      initialRoute: "/stm",
//      routes: {
//        '/form': (context) => FormDemo(),
//        '/mtc' : (context) => MaterialComponentDemo(),
//        '/stm' : (contenxt) => StateManagerDemo(),
//        '/stream': (contenxt) => StreamDemo(),
//        '/rxdart': (contenxt) => RxDartDemo(),
//        '/bloc': (contenxt) => BlocDemo(),
//        '/http': (contenxt) => HttpDemo(),
//        '/animation': (contenxt) => AnimationDemo(),
//        '/i18n': (contenxt) => I18nDemo(),
//      },
//      home: Home()
//        home: NavigatorDemo(),
      home: SliverDemo(),
    );
  }
}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Liweiwei"),
            elevation: 5.0, //导航栏底部阴影
//            leading: IconButton( //设置导航栏左边按钮
//              icon: Icon(Icons.menu),
//              onPressed: () => debugPrint("icon press"),
//              tooltip: "navigation", //只是个说明属性
//            ),
            actions: <Widget>[  //设置导航栏右边按钮
              IconButton( //设置导航栏左边按钮
                icon: Icon(Icons.search),
                onPressed: () => debugPrint("search press"),
                tooltip: "navigation", //只是个说明属性
              ),
            ],
            bottom: TabBar(
              unselectedLabelColor: Colors.black38,
              indicatorColor: Colors.black54,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 5.0,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.local_florist),),
                Tab(icon: Icon(Icons.change_history),),
                Tab(icon: Icon(Icons.directions_bike),),
                Tab(icon: Icon(Icons.pool),),

              ],
            ),
          ),
          
          body: TabBarView(
            children: <Widget>[
              ListViewDemo(),
              BasicDemo(),
              LayoutDemo(),
//              ViewDemo(),
              SliverDemo(),
            ],
          ),
          drawer: DrawerComponent(),
          bottomNavigationBar: BottomNavigationBarDemo() ,
        )
    );
  }
}
