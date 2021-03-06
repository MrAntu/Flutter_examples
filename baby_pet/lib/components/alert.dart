import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

typedef VoidCallBack = void Function();

class Alert {
  // 中间显示的取消/确认弹窗
  static showAlert({
    @required BuildContext context,
    String title,
    String message,
    String leftTitle,
    String rightTitle,
    VoidCallBack leftPressed,
    VoidCallBack rightPressed,
  }) {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) {
            return _CupertinoAlert(
              context: context,
              title: title,
              message: message,
              leftTitle: leftTitle,
              rightTitle: rightTitle,
              leftPressed: leftPressed,
              rightPressed: rightPressed,
            );
          });
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) {
            return _MaterialAlert(
              context: context,
              title: title,
              message: message,
              leftTitle: leftTitle,
              rightTitle: rightTitle,
              leftPressed: leftPressed,
              rightPressed: rightPressed,
            );
          });
    }
  }
}

class _CupertinoAlert extends StatelessWidget {
  final String title;
  final String message;
  final String leftTitle;
  final String rightTitle;
  final VoidCallBack leftPressed;
  final VoidCallBack rightPressed;

  _CupertinoAlert(
      {@required BuildContext context,
      this.title = '',
      this.message = '',
      this.leftTitle = '取消',
      this.rightTitle = '确认',
      this.leftPressed,
      this.rightPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? '',
          style: TextStyle(
              fontSize: 17,
              color: Color(0xFF1a1a1a),
              fontWeight: FontWeight.bold)),
      content: Container(
        padding: EdgeInsets.only(top: 8),
        child: Text(message ?? '',
            style: TextStyle(fontSize: 15, color: Color(0xFF333333))),
      ),
      actions: renderActions(context),
    );
  }

  List<Widget> renderActions(BuildContext context) {
    List<Widget> itemList = [];

    Widget leftItem = CupertinoDialogAction(
      textStyle: TextStyle(fontSize: 16, color: Color(0xFF999999)),
      child: Text(leftTitle ?? '取消'),
      onPressed: () {
        Navigator.of(context).pop();
        if (leftPressed != null) {
          leftPressed();
        }
      },
    );
    itemList.add(leftItem);

    if (rightTitle != null) {
      Widget item = CupertinoDialogAction(
        textStyle:
            TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
        child: Text(rightTitle),
        onPressed: () {
          Navigator.of(context).pop();
          if (rightPressed != null) {
            rightPressed();
          }
        },
      );
      itemList.add(item);
    }

    return itemList;
  }
}

class _MaterialAlert extends StatelessWidget {
  final String title;
  final String message;
  final String leftTitle;
  final String rightTitle;
  final VoidCallBack leftPressed;
  final VoidCallBack rightPressed;

  _MaterialAlert(
      {@required BuildContext context,
      this.title = '',
      this.message = '',
      this.leftTitle = '取消',
      this.rightTitle = '确认',
      this.leftPressed,
      this.rightPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? ''),
      titleTextStyle: TextStyle(
          fontSize: 17, color: Color(0xFF1a1a1a), fontWeight: FontWeight.bold),
      // titlePadding: EdgeInsets.only(top: 8.px),
      content: Text(message ?? ''),
      contentTextStyle: TextStyle(fontSize: 15, color: Color(0xFF333333)),
      // contentPadding: EdgeInsets.only(top: 8.px),
      actions: renderActions(context),
    );
  }

  List<Widget> renderActions(BuildContext context) {
    List<Widget> itemList = [];

    Widget leftItem = FlatButton(
      child: Text(leftTitle ?? '取消',
          style: TextStyle(fontSize: 16, color: Color(0xFF999999))),
      onPressed: () {
        Navigator.of(context).pop();
        if (leftPressed != null) {
          leftPressed();
        }
      },
    );
    itemList.add(leftItem);

    if (rightTitle != null) {
      Widget item = FlatButton(
        child: Text(rightTitle,
            style:
                TextStyle(fontSize: 16, color: Theme.of(context).primaryColor)),
        onPressed: () {
          Navigator.of(context).pop();
          if (leftPressed != null) {
            rightPressed();
          }
        },
      );
      itemList.add(item);
    }

    return itemList;
  }
}
