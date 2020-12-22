import 'package:flutter/material.dart';
import '../utils/timer_util.dart';

class AuthCodeButton extends StatefulWidget {
  final int timeCount;
  final VoidCallback onPressed;

  const AuthCodeButton(
      {Key key, @required this.timeCount, @required this.onPressed})
      : super(key: key);

  @override
  AuthCodeButtonState createState() => AuthCodeButtonState();
}

class AuthCodeButtonState extends State<AuthCodeButton> {
  String title = '获取验证码';
  bool isDisable = true;
  TimerUtil _timer;

  starTimer() {
    int counter = widget.timeCount;
    setState(() {
      title = '${counter}s';
      isDisable = false;
    });
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    _timer = TimerUtil(mTotalTime: counter * 1000);
    _timer.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      if (_tick <= 0) {
        setState(() {
          title = '重新获取';
          isDisable = true;
        });
      } else {
        setState(() {
          title = '${_tick.toInt()}s';
        });
      }
    });
    _timer.startCountDown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      child: Center(
        child: Container(
          height: 30,
          child: RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              title,
              style: TextStyle(fontSize: 13),
            ),
            textColor: Color(0xFF4b4b4b),
            disabledTextColor: Color(0xFF6f6f6f),
            color: Theme.of(context).primaryColor,
            disabledColor: Color(0xFFffea9e),
            shape: StadiumBorder(),
            onPressed: isDisable ? widget.onPressed : null,
          ),
        ),
      ),
    );
  }
}
