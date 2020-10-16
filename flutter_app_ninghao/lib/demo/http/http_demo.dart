import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HttpDemo extends StatelessWidget {
  const HttpDemo({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http"),
      ),
      body: HttpHome(),
    );
  }
}

class HttpHome extends StatefulWidget {
  @override
  _HttpHomeState createState() => _HttpHomeState();
}

class _HttpHomeState extends State<HttpHome> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    final post = {
//      "title": "hello",
//      "description": "ssdfsfdsfd"
//    };
//
//    final encodeJson = json.encode(post);
//    print(encodeJson);
//    final decodeJson = json.decode(encodeJson);
//    print(decodeJson);
//
//    final model = Post.fromJson(decodeJson);
//    print(model.title);
//    print(model.description);
//
//    print("${json.encode(model)}");

  }

  Future<List<Post>> fetchPost() async {
    final response = await http.get("https://resources.ninghao.net/demo/posts.json");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List posts = body["posts"];
      List<Post> modelList = posts.map((item) => Post.fromJson(item)).toList();
      return modelList;
    } else {
      throw Exception("erro");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPost(),
      builder: (context, snapshot) {
        final List<Post> posts = snapshot.data;

        print("${snapshot.connectionState}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("waiting....."),
          );
        }

        return ListView(
          children: posts.map<Widget>((item) {
            return ListTile(
              title: Text("${item.title}"),
              subtitle: Text("${item.author}"),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(item.imageUrl),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}


class Post {
  final String title;
  final String description;
  final int id;
  final String author;
  final String imageUrl;
  Post(
      this.title,
      this.description,
      this.id,
      this.author,
      this.imageUrl
      );

  Post.fromJson(Map json)
    : title = json["title"],
      description = json["description"],
      id = json["id"],
      author = json["author"],
        imageUrl = json["imageUrl"];

  Map toJson() => {
    'title': title,
    'description': description,
    'id': id,
    "author": author,
    "imageUrl": imageUrl
  };
}