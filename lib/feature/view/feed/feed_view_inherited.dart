import 'package:ct_social/core/mixin/navigator_manager.dart';
import 'package:ct_social/feature/model/post_model.dart';
import 'package:ct_social/feature/model/user_model.dart';
import 'package:ct_social/feature/view/feed/feed_view.dart';
import 'package:ct_social/feature/view/new_post/new_post_view_inherited.dart';
import 'package:ct_social/feature/view/post_detail/post_detail_view_inherited.dart';
import 'package:flutter/material.dart';

class FeedViewInherited extends InheritedWidget {
  const FeedViewInherited({
    required super.child,
    required this.data,
    super.key,
  });

  final FeedViewProviderState data;

  static FeedViewProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<FeedViewInherited>();
    if (result != null) {
      return result.data;
    } else {
      throw Exception('Could not find the inherited widget');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class FeedViewProvider extends StatefulWidget {
  const FeedViewProvider({super.key});

  @override
  State<FeedViewProvider> createState() => FeedViewProviderState();
}

class FeedViewProviderState extends State<FeedViewProvider> with NavigatorManager {
  VoidCallback onPostButtonPressed(PostModel postModel, UserModel state) {
    return () {
      navigateToPage(
        context,
        PostDetailViewProvider(
          post: postModel,
          currentUser: state,
        ),
      );
    };
  }

  VoidCallback onNewPostButtonPressed() {
    return () {
      navigateToPage(context, const NewPostViewProvider());
    };
  }

  @override
  Widget build(BuildContext context) {
    return FeedViewInherited(
      data: this,
      child: FeedView(),
    );
  }
}
