part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  const PostState(
      {this.status = PostStatus.initial,
      this.posts = const [],
      this.hasReachedMax = false});

  PostState copyWith(
      {PostStatus status, List<Post> posts, bool hasReachedMax}) {
    return PostState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  // TODO: implement props
  List<Object> get props => [status, posts, hasReachedMax];
}
