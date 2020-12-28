import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'provide/counter.dart';
import 'provide/category_provider.dart';
import 'package:fluro/fluro.dart';
import 'router/routes.dart';
import 'router/application.dart';
import 'package:provider/provider.dart';
import 'provide/detail_provider.dart';
import 'provide/bottom_tabbar_index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // //初始化路由
    // final router = Router();
    // Routes.configureRoutes(router);
    // Application.router = router;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => DetailProvider()),
        ChangeNotifierProvider(create: (_) => BottomTabberIndexProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        // onGenerateRoute: Application.router.generator,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';
//import 'dart:convert';
////import 'package:flutter/services.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Welcome to Flutter',
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Welcome to Flutter'),
//        ),
//        body: WebViewPage()
//      ),
//    );
//  }
//}
//
//class WebViewPage extends StatefulWidget {
//  @override
//  _WebViewPageState createState() => _WebViewPageState();
//}
//
//class _WebViewPageState extends State<WebViewPage> {
//  WebViewController _controller;
//  String _title = "webview";
//  double _height = 100;
//  @override
//  Widget build(BuildContext context) {
//    return Container(
////              width: _width,
//        height: MediaQuery.of(context).size.height,
//        child: WebView(
//            initialUrl: "https://flutterchina.club/",
//            //JS执行模式 是否允许JS执行
//            javascriptMode: JavascriptMode.unrestricted,
//            onWebViewCreated: (controller) {
//              _controller = controller;
////                      controller.loadUrl(Uri.dataFromString(htmlStr,
////                          mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
////                          .toString());
//            },
//            onPageFinished: (url) {
//              //调用JS得到实际高度
//              _controller.evaluateJavascript("document.body.scrollHeight;").then((result){
//                setState(() {
//                  _height = double.parse(result);
//                  print("高度$_height");
//                });
//              }
//              );
//            }
//        )
//    );
//  }
//}

//
// import 'package:flutter/material.dart';
// import 'dart:ui';
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   TabController primaryTC;
//   bool showTextField = false;
//
//   @override
//   void initState() {
//     primaryTC = new TabController(length: 2, vsync: this);
//     primaryTC.addListener(tabControlerListener);
//
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     primaryTC.removeListener(tabControlerListener);
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   //when primary tabcontroller tab,rebuild headerSliverBuilder
//   //click fire twice ,gesture fire onetime
//   int index;
//   void tabControlerListener() {
// //    if (index != primaryTC.index)
// //    //if(primaryTC.indexIsChanging)
// //    //if(primaryTC.previousIndex!=primaryTC.index)
// //    {
// //      setState(() {});
// //    }
// //    index = primaryTC.index;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildScaffoldBody(),
//     );
//   }
//
//   Widget _buildScaffoldBody() {
//     //final double statusBarHeight = MediaQuery.of(context).padding.top;
//     var primaryTabBar = new TabBar(
//       controller: primaryTC,
//       labelColor: Colors.blue,
//       indicatorColor: Colors.blue,
//       indicatorSize: TabBarIndicatorSize.label,
//       indicatorWeight: 2.0,
//       isScrollable: false,
//       unselectedLabelColor: Colors.grey,
//       tabs: [
//         Tab(text: "Tab0"),
//         Tab(text: "Tab1"),
//       ],
//     );
//     return NotificationListener<ScrollNotification>(
//       onNotification: onNotification,
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//             top: top,
//             left: 0.0,
//             right: 0.0,
//             bottom: 0.0,
//             child: Column(
//               children: <Widget>[
//                 getTextField(color: Colors.red),
//                 primaryTabBar,
//                 Expanded(
//                   child: TabBarView(
//                     controller: primaryTC,
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
// //                          Container(
// //                            height: 60.0,
// //                            color: Colors.red,
// //                            child: Text("我是固定的广告"),
// //                          ),
//                           Expanded(
//                             child: ListView.builder(
//                               //store Page state
//                               key: PageStorageKey("Tab1"),
//                               physics: ClampingScrollPhysics(),
//                               itemBuilder: (c, i) {
//                                 return Container(
//                                   alignment: Alignment.center,
//                                   height: 60.0,
//                                   child: Text(
//                                       Key("Tab0").toString() + ": ListView$i"),
//                                 );
//                               },
//                               itemCount: 50,
//                             ),
//                           ),
//                         ],
//                       ),
//                       ListView.builder(
//                         //store Page state
//                         key: PageStorageKey("Tab2"),
//                         physics: ClampingScrollPhysics(),
//                         itemBuilder: (c, i) {
//                           return Container(
//                             alignment: Alignment.center,
//                             height: 60.0,
//                             child:
//                             Text(Key("Tab1").toString() + ": ListView$i"),
//                           );
//                         },
//                         itemCount: 50,
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   double top = 0.0;
//   bool onNotification(ScrollNotification notification) {
//     if (notification.depth == 1) {
//       if (notification is ScrollUpdateNotification) {
//         print("ScrollUpdateNotification-- scrollDelta: ${notification.scrollDelta}");
//         var temp = (top - notification.scrollDelta).clamp(-50.0, 0.0);
//         print("ScrollUpdateNotification-- temp: ${temp}");
//         print("ScrollUpdateNotification-- pixels: ${notification.metrics.pixels}");
//
//         if (temp != top) {
//           setState(() {
//             top = temp;
//           });
//         }
//       } else if (notification is OverscrollNotification) {
//         print(notification.overscroll);
//         var temp = (top - notification.overscroll).clamp(-50.0, 0.0);
//         if (temp != top) {
//           setState(() {
//             top = temp;
//           });
//         }
//       }
//     }
//     return false;
//   }
// }
//
// Widget getTextField({Color color}) {
//   return Container(
//     alignment: Alignment.center,
//     child: Text("我是输入框"),
//     height: 50.0 + 100,
//     color: color ?? Colors.yellow,
//   );
// }
//
