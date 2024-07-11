import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:ct_social/core/database/core/database_hive_manager.dart';
import 'package:ct_social/core/database/operation/post_hive_operation.dart';
import 'package:ct_social/feature/model/comment_model.dart';
import 'package:ct_social/feature/model/post_model.dart';
import 'package:ct_social/feature/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(const PostState());
  final List<PostModel> posts = [];
  final postHiveOperation = PostHiveOperation();

  Future<void> init() async {
    await DatabaseHiveManager().start();
    await postHiveOperation.init();
    if (postHiveOperation.box.isNotEmpty) {
      posts.addAll(postHiveOperation.box.values);
      emit(state.copyWith(posts: List.from(posts)));
    } else {
      dummyPost();
    }
    posts.sort((a, b) => b.postTime!.compareTo(a.postTime!));
    emit(state.copyWith(posts: List.from(posts)));
  }

  void addPost(PostModel post, {XFile? image}) {
    final solid = post.copyWith(id: posts.length, bodyImage: image != null ? _convertedImage(image) : null, postTime: DateTime.now());
    posts.insert(0, solid);
    postHiveOperation.addOrUpdateItem(solid);
    emit(state.copyWith(posts: List.from(posts)));
  }

  void toggleLike(PostModel post, UserModel user) {
    if (isLiked(post, user)) {
      print('remove');
      post.likes?.remove(user);
    } else {
      post.likes?.add(user);
    }
    postHiveOperation.addOrUpdateItem(post);
    final updatedPosts = List<PostModel>.from(posts);
    emit(state.copyWith(posts: []));
    emit(state.copyWith(posts: updatedPosts));
  }

  void addComment(PostModel post, CommentModel comment) {
    post.comments?.add(comment);
    postHiveOperation.addOrUpdateItem(post);
    final updatedPosts = List<PostModel>.from(posts);
    emit(state.copyWith(posts: []));
    emit(state.copyWith(posts: updatedPosts));
  }

  Uint8List _convertedImage(XFile file) {
    final image = File(file.path).readAsBytesSync();
    return image;
  }

  bool isLiked(PostModel post, UserModel user) {
    return post.likes!.contains(user);
  }

  void dummyPost() {
    addPost(
      PostModel(
        header: 'Lorem Ipsum',
        body: 'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
        user: UserModel(name: 'omerkoca'),
        comments: [
          CommentModel(comment: 'Lorem Ipsum', commentedAt: DateTime.now().subtract(const Duration(minutes: 5))),
        ],
        likes: [],
        id: 0,
      ),
    );
    addPost(
      PostModel(
        header: 'Lorem Ipsum',
        body: 'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
        user: UserModel(name: 'omerkoca2'),
        comments: [
          CommentModel(comment: 'Lorem Ipsum', commentedAt: DateTime.now().subtract(const Duration(minutes: 4))),
        ],
        likes: [],
        id: 1,
      ),
    );
    addPost(
      PostModel(
        header: 'Lorem Ipsum',
        body: 'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
        user: UserModel(name: 'omerkoca3'),
        comments: [
          CommentModel(comment: 'Lorem Ipsum', commentedAt: DateTime.now().subtract(const Duration(minutes: 2))),
        ],
        likes: [],
        id: 2,
      ),
    );
    addPost(
      PostModel(
        header: 'Lorem Ipsum',
        body: 'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
        user: UserModel(name: 'omerkoca4'),
        comments: [
          CommentModel(comment: 'Lorem Ipsum', commentedAt: DateTime.now().subtract(const Duration(minutes: 8))),
        ],
        likes: [],
        id: 3,
      ),
    );
    addPost(
      PostModel(
        header: 'Lorem Ipsum',
        body: 'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
        user: UserModel(name: 'omerkoca5'),
        comments: [
          CommentModel(comment: 'Lorem Ipsum', commentedAt: DateTime.now().subtract(const Duration(minutes: 9))),
        ],
        likes: [],
        id: 4,
      ),
    );
    addPost(
      PostModel(
        header: 'Lorem Ipsum',
        body: 'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
        user: UserModel(name: 'omerkoca6'),
        comments: [
          CommentModel(comment: 'Lorem Ipsum', commentedAt: DateTime.now().subtract(const Duration(minutes: 30))),
        ],
        likes: [],
        id: 5,
      ),
    );
    addPost(
      PostModel(
        header: 'Lorem Ipsum',
        body: 'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
        user: UserModel(name: 'omerkoca7'),
        comments: [
          CommentModel(comment: 'Lorem Ipsum', commentedAt: DateTime.now().subtract(const Duration(minutes: 5))),
        ],
        likes: [],
        id: 6,
      ),
    );
    addPost(
      PostModel(
        header: 'Lorem Ipsum',
        body: 'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
        user: UserModel(name: 'omerkoca8'),
        comments: [
          CommentModel(comment: 'Lorem Ipsum', commentedAt: DateTime.now().subtract(const Duration(minutes: 4))),
        ],
        likes: [],
        id: 7,
      ),
    );
    addPost(
      PostModel(
        header: 'Lorem Ipsum',
        body: 'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
        user: UserModel(name: 'omerkoca9'),
        comments: [
          CommentModel(comment: 'Lorem Ipsum', commentedAt: DateTime.now().subtract(const Duration(minutes: 2))),
        ],
        likes: [],
        id: 8,
      ),
    );
    addPost(
      PostModel(
        header: 'Lorem Ipsum',
        body: 'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
        user: UserModel(name: 'omerkoca10'),
        comments: [
          CommentModel(comment: 'Lorem Ipsum', commentedAt: DateTime.now().subtract(const Duration(minutes: 8))),
        ],
        likes: [],
        id: 9,
      ),
    );
  }
}
