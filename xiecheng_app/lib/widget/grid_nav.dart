import 'package:flutter/material.dart';
import 'package:xiecheng_app/model/home_model.dart';
import 'package:xiecheng_app/util/navigator_util.dart';
import 'webView.dart';

class GridNav extends StatelessWidget {
  final GridNavModel model;

  const GridNav({Key key, @required this.model}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent, // 透明色
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),

      ),

    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (model == null) {
      return items;
    }
    if (model.hotel != null) {
      items.add(_gridNavItem(context, model.hotel, true));
    }
    if (model.flight != null) {
      items.add(_gridNavItem(context, model.flight, false));
    }
    if (model.travel != null) {
      items.add(_gridNavItem(context, model.travel, false));
    }
    return items;
  }

  _gridNavItem(BuildContext context, Hotel gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    List<Widget> expandItems = [];
    items.forEach((element) {
      expandItems.add(Expanded(child: element, flex: 1,));
    });
    Color startColor = Color(int.parse('0xff' + gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff' + gridNavItem.endColor));
    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(children: expandItems,),
    );
  }

  _doubleItem(BuildContext context, LocalNavList topItem, LocalNavList bottomItem) {

    return Column(
      children: [
        Expanded(
          child: _item(context, topItem, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        )
      ],
    );
  }

  _item(BuildContext context, LocalNavList item, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      // 撑满父布局的宽度
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: first ? borderSide : BorderSide.none
          )
        ),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
            , item),
      ),
    );

  }

  _mainItem(BuildContext context, LocalNavList mainItem) {

    return _wrapGesture(context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.network(
              mainItem.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Text(
                mainItem.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        )
        , mainItem);
  }

  _wrapGesture(BuildContext context, Widget widget, LocalNavList item) {

    return GestureDetector(
      child: widget,
      onTap: () {
        NavigatorUtil.push(context,
          WebView(
            url: item.url,
            statusBarColor: item.statusBarColor,
            title: item.title,
            hideAppBar: item.hideAppBar,
          )
        );
      },
      // ignore: argument_type_not_assignable
    );
  }

}