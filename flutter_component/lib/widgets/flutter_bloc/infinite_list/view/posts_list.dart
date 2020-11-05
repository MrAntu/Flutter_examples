import 'package:flutter/material.dart';
import '../list_post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsList extends StatefulWidget {
  const PostsList({Key key}) : super(key: key);

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();
  PostBloc _postBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_isBottom) {
        _postBloc.add(PostFetched());
      }
    });

    _postBloc = context.bloc<PostBloc>();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (!state.hasReachedMax && _isBottom) {
//            _postBloc.add(PostFetched());
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.failure:
              return Center(
                child: Text('faild to fetch posts'),
              );
            case PostStatus.success:
              if (state.posts.isEmpty) {
                return Center(
                  child: Text('no datas'),
                );
              }
              return ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return index >= state.posts.length
                      ? BottomLoader()
                      : PostListItem(
                          post: state.posts[index],
                        );
                },
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
              );
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
