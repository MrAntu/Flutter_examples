import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provide/detail_provider.dart';
import '../provide/bottom_tabbar_index.dart';
import 'detail_pages/detail_top_area.dart';
import 'detail_pages/detail_explain.dart';
import 'detail_pages/detail_tabbar.dart';
import 'detail_pages/detai_web.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);


  @override
  Widget build(BuildContext context) {
    print("detail --- build");
    return Scaffold(
      appBar: AppBar(
        title: Text("商品详情"),
      ),
      body: FutureBuilder(
        future: getGoodsInfo(context),
        builder: (context, snapshot) {
          print("${snapshot.connectionState}");
          if (snapshot.hasData == false) {
            return Text("正在加载中。。。。");
          }
          return Stack(
            children: <Widget>[
              ListView(
//                shrinkWrap: true, //可以无限高度
                children: <Widget>[
                    DetailTopArea(),
                DetailExplain(),
                DetailTabbar(),
                DetailWeb(),
                ],
              ),



              //底部按钮.固定在最下面
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  color: Colors.green,
                  child: SafeArea(
                    child: Container(
                      width: ScreenUtil().setWidth(750),
                      color: Colors.white,
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child:  InkWell(
                              onTap: () {
                                Provider.of<BottomTabberIndexProvider>(context, listen: false).changeIndex(2);
                                Navigator.of(context).popUntil(ModalRoute.withName("/"));
                              },
                              child: Text("查看购物车",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 24
                                ),
                              ),
                            )
                          ),

                          Expanded(
                            child: Text("加入购物车",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 24
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                )
              )
            ],
          );
        },
      )
    );
  }

  Future getGoodsInfo(BuildContext context) async {
    print("准备请求数据。。。。。");
    await Provider.of<DetailProvider>(context, listen: false).getGoodsInfo(goodsId);
//    //没有多大左右，任意返回，通过provider刷新数据即可
    return "请求完毕";

  }
}
