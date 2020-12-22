import 'package:flutter/material.dart';
import '../common/strings.dart';
import '../utils/shared_preferences_util.dart';
import '../utils/utils.dart';
import '../utils/timer_util.dart';
import '../utils/route_util.dart';
import '../common/commom_tool.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

enum SplashState { welcom, ads }

class _SplashPageState extends State<SplashPage> {
  SplashState _state;
  int _count = 3;
  TimerUtil _timer;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    final isWelcom = SpUtil.getBool(UserdefaultKey.kIsWelcom);
    // 开启定时器
    if (isWelcom) {
      _starTimer();
    } else {
      _configImageList();
    }
    setState(() {
      _state = isWelcom ? SplashState.ads : SplashState.welcom;
    });
  }

  _configImageList() {
    _controller = PageController();
  }

  _starTimer() {
    if (_timer != null) {
      return;
    }

    _timer = TimerUtil(mTotalTime: 3 * 1000);
    _timer.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _timer.cancel();
        _goMain();
      }
    });
    _timer.startCountDown();
  }

  _goMain() {
    SpUtil.putBool(UserdefaultKey.kIsWelcom, true);
    CommonTool.initUserInfo();

    RouteUtil.pushAndRemoveUntil(
      context,
      Routes.main,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return Material(
      color: Colors.white,
      child: Stack(
        children: [
          Offstage(
            offstage: _state != SplashState.ads,
            child: _buildAdsWidget(),
          ),
          Offstage(
            offstage: _state != SplashState.welcom,
            child: _buildWelcom(),
          )
        ],
      ),
    );
  }

  Widget _buildWelcom() {
    return PageView(
      controller: _controller,
      children: [1, 2, 3, 4].map((e) {
        var asset = Utils.getImgPath('guideX$e');
        return GestureDetector(
          child: Image.asset(
            asset,
            fit: BoxFit.cover,
          ),
          onTap: () {
            if (e == 4) {
              _goMain();
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildAdsWidget() {
    return Stack(
      children: [
        Image.asset(
          Utils.getImgPath('launch_image'),
          fit: BoxFit.cover,
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 20,
          child: _buildCountDown(),
        )
      ],
    );
  }

  Widget _buildCountDown() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(10), right: Radius.circular(10))),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text('跳过 $_count'),
    );
  }
}
