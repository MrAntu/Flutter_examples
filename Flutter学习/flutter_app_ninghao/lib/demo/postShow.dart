import 'package:flutter/material.dart';
import '../model/post.dart';

class PostShow extends StatelessWidget {
  final Post post;
  const PostShow({
    Key key,
    this.post
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${post.title}"),
      ),
      body: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16/9,
            child: Image.network(post.imageUrl,fit: BoxFit.cover,),
          ),
          Container(
            padding: EdgeInsets.all(32),
            width: double.infinity, //占满所有可用的宽度
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${post.title}"),
                Text("${post.author}"),
                SizedBox(height: 32,),
                Text("${post.description}"),

              ],
            ),
          )
        ],
      ),
    );
  }
}
