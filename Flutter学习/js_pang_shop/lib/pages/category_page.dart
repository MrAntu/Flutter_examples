import 'package:flutter/material.dart';
import '../model/category_model.dart';
import '../data/category_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/category_provider.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../common/event_bus.dart';

class CateroryPage extends StatefulWidget {
  @override
  _CateroryPageState createState() => _CateroryPageState();
}

class _CateroryPageState extends State<CateroryPage> with AutomaticKeepAliveClientMixin {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Row(
        children: <Widget>[
          LeftCategoryList(),
          Expanded(
            child: Column(
              children: <Widget>[
                CategoryRightNav(),
                Divider(height: 1, color: Colors.grey,),
                //占满剩余空间
                Expanded(
                  child: CategoryGoodList(),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}


class LeftCategoryList extends StatefulWidget {

  @override
  _LeftCategoryListState createState() => _LeftCategoryListState();
}

class _LeftCategoryListState extends State<LeftCategoryList> {

  int _clickIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
  }

  //模拟数据请求
  void _initializeData() {
    Future.delayed(Duration(milliseconds: 100), () {
      //初始化数据
//      Provide.value<CategoryProvider>(context).getBxMallSubDto(0);
      print("!23123123");
      Provider.of<CategoryProvider>(context, listen: false).getBxMallSubDto(0);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, category, child) {
        return Container(
          width: ScreenUtil().setWidth(180),
          decoration: BoxDecoration(
              border: Border(right: BorderSide(width: 0.5, color: Colors.grey))
          ),
          child: ListView.builder(
            itemCount: category.model.data.length,
            itemBuilder: (context, index) {
              return _leftItem(index);
            },
          ),
        );
      },
    );

  }

  Widget _leftItem(int index) {
    bool _isClick = false;
    _isClick = (index == _clickIndex) ? true : false;

    return Consumer<CategoryProvider>(
      builder: (context, category, child) {
        return InkWell(
          onTap: () {
            setState(() {
              _clickIndex = index;
            });
            category.getBxMallSubDto(index);
            eventBus.fire(CategoryLeftClickEvent(index));
          },

          child: Container(
            height: ScreenUtil().setHeight(100),
            alignment: Alignment.center,
            child: Text(category.model.data[index].mallCategoryName,
            ),
            decoration: BoxDecoration(
                color: _isClick ? Colors.black26 : Colors.white,
                border: Border(bottom: BorderSide(width: 0.5,color: Colors.grey))
            ),
          ),
        );
      },
    );
  }

}

class CategoryRightNav extends StatefulWidget {
  @override
  _CategoryRightNavState createState() => _CategoryRightNavState();
}

class _CategoryRightNavState extends State<CategoryRightNav> {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(750 - 180),
      child: Consumer<CategoryProvider>(
        builder: (context, category,child) {
          print("category --- refresh");
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: category.bxMallSubDto.length,
              itemBuilder: (context, index) {
                return _inkItems(category.bxMallSubDto[index], index, category);
              });
        },
      )
    );
  }

  Widget _inkItems(BxMallSubDto item, int index, CategoryProvider category) {
    bool isClick = (index == category.rightNavigationIndex) ? true : false;
    return InkWell(
      onTap: () {
        category.changeRightNavigationIndex(index);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 15, 5, 15),

        child: Text(
          "${item.mallSubName}",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.pink : Colors.black
          ),
        ),
      ),
    );
  }

}

//商品
class CategoryGoodList extends StatefulWidget {
  @override
  _CategoryGoodListState createState() => _CategoryGoodListState();
}

class _CategoryGoodListState extends State<CategoryGoodList> {
  EasyRefreshController _controller;
  ScrollController _listController;

  int _saveIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
    _listController = ScrollController();
    eventBus.on<CategoryLeftClickEvent>()
        .listen((event) {
          if (event.index == _saveIndex) {
            return;
          }
          _saveIndex = event.index;
          if (Provider.of<CategoryProvider>(context, listen: false).page == 1) {
            _listController.jumpTo(0);
            _controller.resetLoadState();
          }
    });
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _listController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, category, child) {

        return Container(
          child: EasyRefresh(
            enableControlFinishRefresh: false,
            enableControlFinishLoad: true,
            controller: _controller,
            header: ClassicalHeader(),
            footer: ClassicalFooter(),
            onRefresh: () async {
              category.resetPage();
              await Future.delayed(Duration(seconds: 2), () {
                print('onRefresh');
                print("${category.page}");
                category.resetCount();
                _controller.resetLoadState();
              });
            },
            onLoad: () async {
              category.changePage();
              await Future.delayed(Duration(seconds: 2), () {
                print('onLoad');
                print("${category.page}");
                category.changeCount();
                print('${category.count}');

                if (category.count >= 40) {
                  Fluttertoast.showToast(
                    msg: "没有更多了。。。",

                  );
                }
                _controller.finishLoad(noMore: category.count >= 40);
              });
            },
            child: ListView.builder(
              itemCount: category.count,
              controller: _listController,
              itemBuilder: (context, index) {
                return _listCell(index);
              },
            ),
          ),
        );
      },
    );


  }
  
  Widget _listCell(int index) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5,color: Colors.grey))
      ),
//      height: ScreenUtil().setHeight(200),
      child: Row(
        children: <Widget>[
          _imageItem(),
          Expanded(
            child: _textContainer(),
          )
        ],
      ),
    );
  }

  Widget _imageItem() {
    return Container(
      width: ScreenUtil().setWidth(150),
      child: Image.network("https://img10.360buyimg.com/n5/jfs/t1/62590/17/2402/170556/5d0b640dEc3e785ce/f8569fe802c2af6e.jpg"),
    );
  }

  Widget _textContainer() {
    return Column(
      children: <Widget>[
        _topTextContainer(),
        SizedBox(height: 20,),
        _bottomTextContainer()

      ],
    );
  }

  Widget _topTextContainer() {
    return Container(
      child: Text(
        "五粮液52度普五第八代款单瓶500毫升"
      ),
    );
  }

  Widget _bottomTextContainer() {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            "价格￥1399.0",
            style: TextStyle(
              color: Colors.red
            ),
          ),
          Text(
            "1599.0",
            style: TextStyle(
              decoration: TextDecoration.lineThrough
            ),
          )
        ],
      ),
    );
  }

}

