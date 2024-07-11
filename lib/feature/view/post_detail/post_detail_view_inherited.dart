import 'package:ct_social/core/widget/custom_bottom_sheet.dart';
import 'package:ct_social/feature/cubit/post/post_cubit.dart';
import 'package:ct_social/feature/model/comment_model.dart';
import 'package:ct_social/feature/model/post_model.dart';
import 'package:ct_social/feature/model/user_model.dart';
import 'package:ct_social/feature/view/post_detail/post_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class PostDetailViewInherited extends InheritedWidget {
  const PostDetailViewInherited({
    required super.child,
    required this.data,
    super.key,
  });
  final PostDetailViewProviderState data;

  static PostDetailViewProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<PostDetailViewInherited>();
    if (result != null) {
      return result.data;
    } else {
      throw Exception('Could not find the inherited widget');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

final class PostDetailViewProvider extends StatefulWidget {
  const PostDetailViewProvider({required this.post, required this.currentUser, super.key});
  final PostModel post;
  final UserModel currentUser;

  @override
  State<PostDetailViewProvider> createState() => PostDetailViewProviderState();
}

class PostDetailViewProviderState extends State<PostDetailViewProvider> {
  late final PostModel post;
  late final UserModel currentUser;
  final commentController = TextEditingController();
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    post = widget.post;
    currentUser = widget.currentUser;
    isLiked = post.likes!.contains(currentUser);
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  /// This method is used to toggle the like of the post
  VoidCallback likeProvider() {
    return () {
      context.read<PostCubit>().toggleLike(post, currentUser);
    };
  }

  /// This method is used to add a comment to the post
  VoidCallback addCommentProvider() {
    return () {
      context.read<PostCubit>().addComment(
            post,
            CommentModel(
              comment: commentController.text,
              commentedAt: DateTime.now(),
              user: currentUser,
            ),
          );
    };
  }

  /// this method is used to open comment bottom sheet
  VoidCallback openCommentProvider() {
    return () {
      CustomBottomSheet.show(
        context,
        child: CommentsWidget(
          currentState: this,
        ),
        title: 'Comments',
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return PostDetailViewInherited(data: this, child: const PostDetailView());
  }
}
