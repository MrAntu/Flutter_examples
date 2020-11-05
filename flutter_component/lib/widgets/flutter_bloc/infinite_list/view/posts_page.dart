import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../list_post.dart';
import 'posts_list.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: BlocProvider(
        create: (_) {
          final bloc = PostBloc(httpClient: http.Client());
          bloc.add(PostFetched());
          return bloc;
        },
        child: PostsList(),
      ),
    );
  }
}
