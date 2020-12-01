import 'package:flutter/material.dart';

/**
 *  说实话，我觉得expansion panel list一点都不好用
 *  所以不想写注释。
 *  这里样例代码来自于flutter开发者
 *  他会经常更新一些flutter教程，写的挺不错的，有兴趣自己去看看吧
 *  https://mp.weixin.qq.com/s/Qv08V42LgEr8IATUSfVVHg
 *
 *  需要注意几点：
 *  ExpansionPanelList必须放在可滑动组件中使用
 *  ExpansionPanel只能在ExpansionPanelList中使用
 *  除了ExpansionPanel还有一种特殊的ExpansionPanelRadio
 *  也是只能在ExpansionPanelList中使用的
 */


class ExpansionTileListDemo extends StatefulWidget {
  const ExpansionTileListDemo({Key key}) : super(key: key);

  @override
  _ExpansionTileListDemoState createState() => _ExpansionTileListDemoState();
}

class _ExpansionTileListDemoState extends State<ExpansionTileListDemo> {
  var currentPanelIndex = -1;
  List<int> mList;
  //用来保存expansionPanel的状态
  List<ExpandStateBean> expandStateList;

  _setCurrentIndex(int index, isExpand) {
    setState(() {
      expandStateList.forEach((element) {
        if (element.index == index) {
          element.isOpen = !isExpand;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mList = new List();
    expandStateList = new List();
    for (int i = 0; i < 10; i++) {
      mList.add(i);
      expandStateList.add(ExpandStateBean(i, false));
    }
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('expansion tile demo'),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            expansionCallback: (index, bol) {
              _setCurrentIndex(index, bol);
            },
            children: mList.map((index) {
              return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text('this is No. $index'),
                    );
                  },
                  body: ListTile(
                    title: Text('expansion no. $index'),
                  ),
                  isExpanded: expandStateList[index].isOpen
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}


class ExpandStateBean {
  var isOpen;
  var index;
  ExpandStateBean(this.index, this.isOpen);
}