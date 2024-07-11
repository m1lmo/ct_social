part of 'post_cubit.dart';

class PostState extends Equatable {
  const PostState({
    this.posts,
  });
  final List<PostModel>? posts;

  PostState copyWith({
    List<PostModel>? posts,
  }) {
    return PostState(
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object?> get props => [posts];
}
