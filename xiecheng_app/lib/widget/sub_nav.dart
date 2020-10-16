import 'package:flutter/material.dart';
import 'package:xiecheng_app/model/home_model.dart';
import 'package:xiecheng_app/util/navigator_util.dart';
import 'webView.dart';
class SubNav extends StatelessWidget {
  final List<SubNavList> list;

  const SubNav({Key key, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
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
    //计算出第一行显示的数量
    int separate = (list.length / 2 + 0.5).toInt();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, list.length),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, SubNavList model) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
            onTap: () {
              NavigatorUtil.push(
                  context,
                  WebView(
                    url: model.url,
                    statusBarColor: 'ffffff',
                    hideAppBar: model.hideAppBar,
                  )
              );
            },
            child: Column(
                children: [
                  Image.network(
                    model.icon,
                    width: 18,
                    height: 18,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      model.title,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ])
        )

    );
  }
}