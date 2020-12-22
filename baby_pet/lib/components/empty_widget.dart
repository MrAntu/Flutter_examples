import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../exports.dart';

class EmptyWidget extends StatelessWidget {
  final String image;
  final String title;
  final double offsetY;
  final bool showReload;
  final VoidCallback onPressed;

  const EmptyWidget({
    Key key,
    this.image = 'empty_data',
    this.title,
    this.offsetY = 200,
    this.showReload = true,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      padding: EdgeInsets.only(left: 32, right: 32, top: offsetY),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _renderItems(context),
      ),
    );
  }

  List<Widget> _renderItems(BuildContext context) {
    List<Widget> itemList = [];
    final String message = title ?? '暂无数据';
    Widget titleItem = Text(message,
        style: TextStyle(fontSize: 16, color: Color(0xFF999999)),
        textAlign: TextAlign.center);

    Widget imageItem = Image.asset(
      Utils.getImgPath(image),
      fit: BoxFit.contain,
      width: 150,
      height: 150,
    );
    itemList.add(imageItem);
    itemList.add(SizedBox(
      height: 20,
    ));
    itemList.add(titleItem);

    Widget button = RaisedButton(
      onPressed: () {
        if (onPressed == null) {
          return;
        }
        onPressed();
      },
      padding: EdgeInsets.symmetric(horizontal: 8),
      textColor: Color(0xFF4b4b4b),
      color: Theme.of(context).primaryColor,
      shape: StadiumBorder(),
      elevation: 1,
      child: Text('点击刷新'),
    );

    if (showReload) {
      itemList.add(SizedBox(
        height: 20,
      ));
      itemList.add(button);
    }
    return itemList;
  }
}
