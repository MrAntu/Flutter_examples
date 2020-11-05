import 'package:flutter/material.dart';
import 'tools/dio_tool/dio_tool.dart';
import 'package:dio/dio.dart';
import 'common/common.dart';
import 'common/colors.dart';
import 'tools/shared_preferences_util.dart';
import 'tools/object_util.dart';
import 'pages/splash_page.dart';
import 'pages/main_page.dart';
import 'provider/application_provider.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'tools/custom_intl/custom_intl.dart';
import 'common/strings.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ApplicationProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _themeColor = Colours.green_1;
  Locale _locale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 初始化配置 dio
    _initDio();
    // 初始化国家化字符串
    setLocalizedValues(localizedValues);

    // 监听语言变化
    context.read<ApplicationProvider>().changeLanguage.listen((value) {
      print("dfsdf： ${value}");
      _loadLocale();
    });
    _loadLocale();
  }

  _loadLocale() {
    SharedPreferencesUtil.getObj(
        Constant.keyLanguage, (v) => LanguageModel.fromJson(v)).then((value) {
      if (value != null) {
        _locale = Locale(value.languageCode, value.countryCode);
      } else {
        // 获取当前默认语言
        Locale myLocale = WidgetsBinding.instance.window.locale;
        print(myLocale);
        //  countryCode为US代表繁体中文，默认设为香港繁体
        if (myLocale.scriptCode == 'Hant' && myLocale.countryCode == 'US') {
          _locale = Locale(myLocale.languageCode, 'HK');
        } else if (myLocale.languageCode == 'zh' &&
            myLocale.scriptCode == 'Hans') {
          // 简体中文
          _locale = Locale(myLocale.languageCode, 'CN');
        } else {
          _locale = myLocale;
        }
        print(CustomLocalizations().locale);
        CustomLocalizations().locale = _locale;
      }
      setState(() {});
    });
  }

  _initDio() {
    Options options = DioTool.getDefOptions();
    options.baseUrl = Constant.server_address;
    SharedPreferencesUtil.getString(BaseConstant.keyAppToken).then((cookie) {
      if (ObjectUtil.isNotEmpty(cookie)) {
        Map<String, dynamic> _headers = Map();
        _headers['Cookie'] = cookie;
        options.headers = _headers;
      }

      HttpConfig config = HttpConfig(options: options);
      DioTool().setConfig(config);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        BaseConstant.routeMain: (ctx) => MainPage(),
      },
//      theme: ThemeData.light().copyWith(
//        primaryColor: _themeColor,
////        accentColor: _themeColor,
////        indicatorColor: Colors.white,
//      ),
      home: SplashPage(),
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate
      ],
      supportedLocales: CustomLocalizations.supportedLocales,
    );
  }
}
