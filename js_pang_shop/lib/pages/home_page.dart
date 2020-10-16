import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../router/application.dart';
import '../router/navigator_util.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  List _hotItemsList = [1,1,1,1,1,1,1,1,1,1];
  // 保持页面的状态，不会每次都重新加载一遍
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
        title: Text("home"),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
//          if(snapshot.hasData == false) {
//            return Text("暂无数据");
//          }
          return EasyRefresh(
            footer: ClassicalFooter(
              bgColor: Colors.white,
              textColor: Colors.black,
              showInfo: false,
              loadingText: "加载中...",
            ),
            onLoad: () async {
              await Future.delayed(Duration(milliseconds: 2000), () {
                setState(() {
                  _hotItemsList.addAll([1,1,1,1,1,1,1]);
                });
              });
            },
            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 2000), (){

              });
            },
            child:  ListView(
              children: <Widget>[
                SwiperDiy(),
                NavigatorGrid(),
                AdBanner(),
                LeaderPhone(),
                SizedBox(height: 10,),
                Recommend(),
                FloorTitle(),
                FloorContent(),
                _hotWrap(),
              ],
            ),
          );
        },
      ),
    );
  }
  
  
  // 火爆专区标题
  
  Widget _hotTitle = Container(
    child: Text("火爆专区"),
  );
  
  //火爆商品
  Widget _hotItem() {

    if(_hotItemsList.isEmpty == false) {
      List<Widget> _wrapList = _hotItemsList.map((value){
        return InkWell(
          onTap: () {
            NavigatorUtil.jump(context, '/detail?id=${123123123}');
          },
          child: Container(
            width: ScreenUtil().setWidth((750.0)/2.0 - 2),
//            margin: EdgeInsets.all(3),
            child: Column(
              children: <Widget>[
                Image.network("https://img20.360buyimg.com/mobilecms/s300x300_jfs/t8626/219/2101457934/193075/2955b709/59c4bf87N20b6b192.jpg!q70.jpg",
                  fit: BoxFit.cover,
                ),
                Text("HouseOfHello链条手提",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text("23444.0"),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )
        );

      }).toList();

      return Wrap(
        spacing: 2.0,
        children: _wrapList,
      );
    }

    return Text("");
  }

  Widget _hotWrap() {
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle,
          _hotItem()
        ],
      ),
    );
  }

  
  
  
}

// 轮播图
class SwiperDiy extends StatelessWidget {
  List _images = [
    'http://newimg.jspang.com/TaroLogo.jpg',
    'http://newimg.jspang.com/react_blog_demo.jpg',
    'http://newimg.jspang.com//next_blog.jpg',
    'http://newimg.jspang.com/ReactHooks01.png'
  ];
  @override
  Widget build(BuildContext context) {
    print(ScreenUtil().setHeight(244));
    print(ScreenUtil().setWidth(750));
    return Container(
      height: ScreenUtil().setHeight(244),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: _images.length,
        itemBuilder: (context,index) {
          return Image.network(_images[index], fit: BoxFit.cover);
        },
        autoplay: true,
        pagination: SwiperPagination(),
      ),
    );
  }
}

//顶部九宫格
class NavigatorGrid extends StatelessWidget {
  final List _gridList = [
    'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=24316228,2287216943&fm=26&gp=0.jpg',
    'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=24316228,2287216943&fm=26&gp=0.jpg',
    'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=24316228,2287216943&fm=26&gp=0.jpg',
    'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=24316228,2287216943&fm=26&gp=0.jpg',
    'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=24316228,2287216943&fm=26&gp=0.jpg',
    'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=24316228,2287216943&fm=26&gp=0.jpg',
    'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=24316228,2287216943&fm=26&gp=0.jpg',
    'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=24316228,2287216943&fm=26&gp=0.jpg',
    'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=24316228,2287216943&fm=26&gp=0.jpg',
    'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=24316228,2287216943&fm=26&gp=0.jpg',
  ];

  Widget _gridViewItem(BuildContext context, String imageUrl) {

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child:  Container(
//              color: Colors.red,
              child: Image.network(imageUrl, fit: BoxFit.cover,),
            ),
          ),

          Text("生活馆")
        ],
      ),
    );
//    return InkWell(
//      onTap: (){},
//      child: Container(
////        color: Colors.red,
//        height: 20.0,
//        child: Column(
////          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
////            Image.network(imageUrl, height: ScreenUtil().setHeight(100),),
//            SizedBox(height: 80,),
//            Text("生活馆")
//          ],
//        ),
//      )
//    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      height: ScreenUtil().setHeight(300),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(), //禁止滚动
        crossAxisCount: 5,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 1 / 1.2,
        children: _gridList.map((item) {
          return _gridViewItem(context, item);
        }).toList(),
      ),

    );
  }
}

//广告
class AdBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network("http://newimg.jspang.com/React_Router.png"),
    );
  }
}

//拨打电话
class LeaderPhone extends StatelessWidget {

  void _launchURL() async {
    const url = "tel:" + "123123123";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchURL,
      child: Stack(
        children: <Widget>[
          Image.network("http://newimg.jspang.com/Redux_index.png"),
          Positioned(
            right: 10,
            top: 10,
            child: Text("点击拨打电话",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.red
              ),
            ),
          )
        ],
      ),
    );
  }
}

//商品推荐
class Recommend extends StatelessWidget {

  Widget _titleWidget() {

    return Container(
      padding: EdgeInsets.only(left: 12),
      height: ScreenUtil().setHeight(60),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey)
        )
      ),
      child: Text(
        "商品推荐",
        style: TextStyle(
          color: Colors.red,
          fontSize: 18
        ),
      ),
    );
  }

  Widget _item(int index) {
    return InkWell(
      onTap: (){
        print("sfsdfsdf---${index}");
      },
      child: Container(
        width: ScreenUtil().setWidth(750.0 / 3.0),
        decoration:BoxDecoration(
            color:Colors.white,
            border:Border(
                left: BorderSide(width:1,color:Colors.black12)
            )
        ),
        child: Column(
          children: <Widget>[
            Image.network("https://img10.360buyimg.com/mobilecms/s600x600_jfs/t12682/186/1896616485/24823/fc4b09f7/5a2ccf65N9214a278.jpg!q70.jpg",
              height: ScreenUtil().setHeight(200),
              fit: BoxFit.fitWidth,
            ),
            Text("29.0",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text("58.9",
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              ),
            )

          ],
        ),
      )
    );
  }

  Widget _listContainer() {
    return Container(
      height: ScreenUtil().setHeight(260),
      color: Colors.red,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _listContainer()
        ],
      ),
    );
  }
}

//楼层标题
class FloorTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(180),
      child: Image.network("http://newimg.jspang.com/TaroLogo.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}

class FloorContent extends StatelessWidget {

  Widget _firtFloor() {
    return Container(
      height: ScreenUtil().setHeight(300),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FloorItem(),
          ),

          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: FloorItem(),
                ),
                Expanded(
                  child: FloorItem(),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget _secondFloor() {
    return Container(
      child: Row(
        children: <Widget>[
          FloorItem(),
          FloorItem(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firtFloor(),
//          _secondFloor()
        ],
      ),
    );
  }
}

class FloorItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print("11111");
      },
      child: Image.network("https://img12.360buyimg.com/mobilecms/s600x600_jfs/t12505/6/1973442087/46443/929693d1/5a30befbNdd0f76b1.jpg!q70.jpg",
        fit: BoxFit.fill,
      ),
    );
  }
}


