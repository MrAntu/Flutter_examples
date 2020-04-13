import 'package:flutter/material.dart';
import '../model/post.dart';
class ViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridViewBuilderDemo();
  }
}

class GridViewBuilderDemo extends StatelessWidget {

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      child: Text("Item $index",
        style: TextStyle(fontSize: 18, color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: posts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8
        ),
        itemBuilder: _itemBuilder
    );
  }
}


class GridViewDemo extends StatelessWidget {
  List<Widget> _gridViewTail(int count) {
    return List.generate(count, (i) {
      return Container(
        color: Colors.grey,
        alignment: Alignment.center,
        child: Text("Item $i",
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      crossAxisCount: 3,
//      scrollDirection: Axis.horizontal,
      children: _gridViewTail(100),
    );
  }
}


class PageBuilderDemo extends StatelessWidget {

  Widget _itemBuilder(BuildContext context, int index) {
    return Stack(
      children: <Widget>[
        SizedBox.expand(
          child: Image.network(
              posts[index].imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 8,
          bottom: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                posts[index].title,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                posts[index].author
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: posts.length,
      itemBuilder: _itemBuilder,
    );
  }
}

class PageViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
//      pageSnapping: false, //弹性设置
//      reverse: true, //倒置
//      scrollDirection: Axis.vertical, //滚动方向
      onPageChanged: (index){
        debugPrint("$index");
      },
      controller: PageController(
        initialPage: 1, //设置默认滚动的界面
        keepPage: false, //不记住界面
        viewportFraction: 0.85 //占用可视范围的大小
      ),
      children: <Widget>[
        Container(
          color: Colors.brown,
          child: Text(
            "ONE",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white
            ),
          ),
        ),
        Container(
          color: Colors.red,
          child: Text(
            "TWO",
            style: TextStyle(
                fontSize: 32,
                color: Colors.white
            ),
          ),
        ),
        Container(
          color: Colors.green,
          child: Text(
            "THREE",
            style: TextStyle(
                fontSize: 32,
                color: Colors.white
            ),
          ),
        ),
      ],
    );
  }
}

