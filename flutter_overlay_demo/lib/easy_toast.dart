import 'package:flutter/material.dart';
import 'easy_toast/flutter_easyloading.dart';

class EasyToast extends StatelessWidget {
  const EasyToast({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('toast'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('点击我1111'),
          onPressed: () {
            EasyLoading.showToast("weqeqwe");
          },
        ),
      ),
    );
  }
}
