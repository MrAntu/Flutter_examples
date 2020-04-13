import 'package:flutter/material.dart';
import '../model/post.dart';
class SliverDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("NINGHAO"),
//            pinned: true, //固定在顶部
//            floating: true, //只要往下拉，就显示出来
            expandedHeight: 100, //扩展高度
            flexibleSpace: FlexibleSpaceBar(
              title: Text("HSDFJJJ"),
              background: Image.network("https://resources.ninghao.org/images/dragon.jpg",
                fit: BoxFit.cover,
              ),

            ),
          ),
          SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.all(8),
              sliver: SliverListDemo(),
            ),
          )

        ],
      ),
    );
  }
}

class SliverListDemo extends StatelessWidget {
  Widget _itemBuilder(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 32),
      child:  Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(0, 0),
              blurRadius: 10
            )
          ]
        ),
        child: ClipRRect(  //切圆角。如果jpg使用decoration麻烦，
          borderRadius: BorderRadius.circular(12),
          child: Stack(
             children: <Widget>[
               AspectRatio(
                   aspectRatio: 16/9,
                 child: Image.network(
                   posts[index].imageUrl,
                   fit: BoxFit.cover,
                 ),
               ),

               Positioned(
                 top: 32,
                 left: 32,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text(
                       posts[index].title,
                       style: TextStyle(
                           fontSize: 20,
                         color: Colors.white
                       ),
                     ),
                     Text(
                       posts[index].author,
                       style: TextStyle(
                           fontSize: 13,
                           color: Colors.white
                       ),
                     )
                   ],
                 ),
               )
             ],
          )
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
              _itemBuilder,
          childCount: posts.length
      ),
    );
  }
}


class SliverGridDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8
      ),
      delegate: SliverChildBuilderDelegate(
              (context, index) {
            return Container(
              child: Image.network(
                posts[index].imageUrl,
                fit: BoxFit.cover,
              ),
            );
          },
          childCount: posts.length
      ),
    );
  }
}

