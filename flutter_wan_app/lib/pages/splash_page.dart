import 'package:flutter/material.dart';
import '../tools/utils.dart';
import '../tools/shared_preferences_util.dart';
import '../common/common.dart';
import '../models/models.dart';
import '../tools/http_utils.dart';
import '../tools/object_util.dart';
import 'dart:async';
import '../tools/timer_tool.dart';
import 'main_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../common/colors.dart';
import 'package:flukit/flukit.dart';
import '../tools/route_util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  SplashModel _splashModel;
  TimerTool _timerUtil;
  int _count = 3;

  List<String> _guideList = [
    Utils.getImgPath('guide1'),
    Utils.getImgPath('guide2'),
    Utils.getImgPath('guide3'),
    Utils.getImgPath('guide4'),
  ];

  List<Widget> _bannerList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  _init() async {
    // 加载广告闪屏数据
    _loadSplashData();
    bool isGuide = await SharedPreferencesUtil.getBool(Constant.key_guide);

    Future.delayed(Duration(seconds: 1), () {
      if (isGuide != false && ObjectUtil.isNotEmpty(_guideList)) {
        SharedPreferencesUtil.putBool(Constant.key_guide, false);
        _initBanner();
      } else {
        _initSplash();
      }
    });
  }

  _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }

  _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(Stack(
          children: [
            Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: InkWell(
                  onTap: () {
                    print("点击跳转到首页");
                    _goMain();
                  },
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.indigoAccent,
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Text(
                        '立即体验',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
      } else {
        _bannerList.add(Image.asset(
          _guideList[i],
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ));
      }
    }
  }

  _initSplash() {
    if (_splashModel == null) {
      _goMain();
    } else {
      _doCountDown();
    }
  }

  _goMain() {
    RouteUtil.goMain(context);

//    Navigator.pushAndRemoveUntil(
//        context,
//        MaterialPageRoute(builder: (context) => HomePage()),
//        (route) => route == null);
  }

  _doCountDown() {
    setState(() {
      _status = 1;
    });
    _timerUtil = TimerTool(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  _loadSplashData() async {
    _splashModel = await SharedPreferencesUtil.getObj(
        Constant.key_splash_model, (v) => SplashModel.fromJson(v));

//    _splashModel = SpTool.getObj(
//        Constant.key_splash_model, (v) => SplashModel.fromJson(v));
    if (_splashModel != null) {
      setState(() {});
    }

    HttpUtils httpUtils = HttpUtils();
    httpUtils.getSplash().then((value) {
      if (!ObjectUtil.isEmpty(value.imgUrl)) {
        // 存入沙盒
        if (_splashModel == null || (_splashModel.imgUrl != value.imgUrl)) {
          SharedPreferencesUtil.putObject(Constant.key_splash_model, value);
          setState(() {
            _splashModel = value;
          });
        } else {
          SharedPreferencesUtil.putObject(Constant.key_splash_model, null);
        }
      }
    }).catchError((e) {
      print(2);
      print("!23123");
    });
  }

  @override
  void dispose() {
    if (_timerUtil != null) {
      _timerUtil.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          // 启动页
          Offstage(
            offstage: !(_status == 0),
            child: _buildSplashBg(),
          ),

          //第一次安装引导页
          Offstage(
            offstage: !(_status == 2),
            child: ObjectUtil.isEmpty(_bannerList)
                ? Container()
                : Swiper(
                    children: _bannerList,
                    autoStart: false,
                    circular: false,
                    indicator: CircleSwiperIndicator(
                        radius: 4,
                        padding: EdgeInsets.only(bottom: 30),
                        itemColor: Colors.black26),
                  ),
          ),

          // 广告页
          _buildAdWidget(),

          // 由下角倒计时
          Offstage(
            offstage: !(_status == 1),
            child: new Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  _goMain();
                },
                child: new Container(
                    padding: EdgeInsets.all(12.0),
                    child: new Text(
                      '$_count',
                      style: new TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    decoration: new BoxDecoration(
                        color: Color(0x66000000),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: new Border.all(
                            width: 0.33, color: Colours.divider))),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildSplashBg() {
    return Image.asset(
      Utils.getImgPath('splash_bg'),
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _buildAdWidget() {
    if (_splashModel == null) {
      return Container(
        height: 0,
      );
    }

    return Offstage(
      offstage: !(_status == 1),
      child: Container(
        child: CachedNetworkImage(
          imageUrl: _splashModel.imgUrl,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
          placeholder: (context, url) => _buildSplashBg(),
          errorWidget: (context, url, error) => _buildSplashBg(),
        ),
      ),
    );
  }
}
