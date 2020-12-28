import 'dart:async';
import 'package:flutter/material.dart';
import 'common/app_config.dart';
import 'pages/exception/exception_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'pages/splash_page.dart';
import 'utils/route/application.dart';
import 'utils/route/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/cupertino.dart';
import 'providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化配置
  await AppConfig.init();
  //初始化路由
  final router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;

  // 转发至zone的错误收集
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
    // 自定义后台接口收集
  };

  ///出现异常时会进入下方页面（flutter原有的红屏），
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ExceptionPage(
        details.exception.toString(), details.stack.toString());
  };
  runZoned<Future<Null>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    //异常处理
    ///你可以将下面日志上传到服务器，用于release后的错误处理
    debugPrint(error);
    debugPrint(stackTrace.toString());
  });

  //状态栏置透明
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainConfig(
      child: MaterialApp(
        title: '宝贝宠物',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: Color(0xFFF5CA2B),
            splashColor: Colors.transparent),
        home: SplashPage(),
        onGenerateRoute: Application.router.generator,
        builder: EasyLoading.init(),
      ),
    );
  }
}

class MainConfig extends StatelessWidget {
  final Widget child;

  const MainConfig({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProviders()),
      ],
      child: RefreshConfiguration(
        headerTriggerDistance: 100,
        springDescription:
            SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
        enableScrollWhenRefreshCompleted: true,
        enableLoadingWhenFailed: true,
        hideFooterWhenNotFull: false,
        enableBallisticLoad: true,
        headerBuilder: () => ClassicHeader(
          height: 50,
          refreshStyle: RefreshStyle.UnFollow,
          refreshingText: '正在刷新中...',
          releaseText: '松开立即刷新',
          completeText: '数据加载完成',
          idleText: '下拉开始刷新',
          failedText: '数据加载失败',
          releaseIcon: Icon(Icons.arrow_downward, color: Colors.grey),
        ),
        footerBuilder: () => ClassicFooter(
          height: 50,
          loadingText: '正在加载中...',
          canLoadingText: '松开立即加载',
          noDataText: '没有更多数据了',
          idleText: '上拉开始加载',
          failedText: '数据加载失败',
          loadingIcon: CupertinoActivityIndicator(),
          canLoadingIcon: Icon(Icons.arrow_upward, color: Colors.grey),
        ),
        child: child,
      ),
    );
  }
}
