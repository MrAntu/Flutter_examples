

import 'package:flutter/material.dart';
import '../model/post.dart';
import 'postShow.dart';
class ListViewDemo extends StatelessWidget {
  Widget _itemBuilder(BuildContext context, int index) {
    var post = posts[index];

    return Container(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16/9,
                child: Image.network("${post.imageUrl}", fit: BoxFit.cover,),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                post.title,
                style: Theme.of(context).textTheme.title,
              ),
              Text(
                post.author,
                style: Theme.of(context).textTheme.subhead,
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),

          // 设置点击水纹效果
          Positioned.fill(
            child: Material(
              color: Colors.transparent, //设置透明色
              child: InkWell(
                splashColor: Colors.white.withOpacity(0.3),
                highlightColor: Colors.white.withOpacity(0.1),
                onTap: () {
                  debugPrint("水电费水电费");
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PostShow(post: posts[index],))
                  );
                },
              ),
            )
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: _itemBuilder
    );
  }
}
