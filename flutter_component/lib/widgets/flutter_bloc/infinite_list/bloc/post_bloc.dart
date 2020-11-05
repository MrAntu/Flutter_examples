import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../model/modes.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient}) : super(PostState());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is PostFetched) {
      yield await _mapPostFetchedToState(state);
    }
  }

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
    Stream<PostEvent> events,
    TransitionFunction<PostEvent, PostState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  Future<PostState> _mapPostFetchedToState(PostState state) async {
    if (state.hasReachedMax) {
      return state;
    }

    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts(0, 20);
        return state.copyWith(
            status: PostStatus.success, posts: posts, hasReachedMax: false);
      }

      final posts = await _fetchPosts(state.posts.length, 20);
      return posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false);
    } on Exception {
      return state.copyWith(status: PostStatus.failure);
    }
  }

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get(
      'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit',
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) {
        return Post(
            id: e['id'] as int,
            title: e['title'] as String,
            body: e['body'] as String);
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
