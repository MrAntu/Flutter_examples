import 'package:flutter/material.dart';
import 'package:xiecheng_app/model/home_model.dart';
import 'package:xiecheng_app/util/navigator_util.dart';
import 'webView.dart';
class LocalNav extends StatelessWidget {
  final List<LocalNavList> list;

  const LocalNav({Key key, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        )
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  Widget _items(BuildContext context) {
    if (list == null) {
      return null;
    }
    List<Widget> items = [];
    list.forEach((element) {
      items.add(_item(context, element));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, LocalNavList model) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(context, WebView(
          url: model.url,
          statusBarColor: model.statusBarColor,
          hideAppBar: model.hideAppBar,
        ));
      },
      child: Column(
        children: [
          Image.network(
            model.icon,
            width: 32,
            height: 32,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
