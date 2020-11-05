import 'package:flutter/material.dart';
import '../list_post.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({Key key, @required this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${post.id}', style: Theme.of(context).textTheme.caption),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}
