import 'package:ct_social/core/extension/date_time_extension.dart';
import 'package:ct_social/core/extension/theme_getter_extension.dart';
import 'package:ct_social/core/mixin/navigator_manager.dart';
import 'package:ct_social/feature/cubit/post/post_cubit.dart';
import 'package:ct_social/feature/cubit/user/user_model_cubit.dart';
import 'package:ct_social/feature/model/post_model.dart';
import 'package:ct_social/feature/model/user_model.dart';
import 'package:ct_social/feature/view/feed/feed_view_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});
  @override
  Widget build(BuildContext context) {
    final currentState = FeedViewInherited.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<PostCubit>(context),
        ),
        BlocProvider.value(value: BlocProvider.of<UserModelCubit>(context)),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Feed'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: currentState.onNewPostButtonPressed(),
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              Expanded(
                child: BlocSelector<PostCubit, PostState, List<PostModel?>>(
                  selector: (postState) {
                    return postState.posts ?? [];
                  },
                  builder: (context, postState) {
                    return ListView.builder(
                      itemCount: postState.length,
                      itemBuilder: (context, index) {
                        return BlocSelector<UserModelCubit, UserModelState, UserModel>(
                          selector: (userState) {
                            return userState.currentUser!;
                          },
                          builder: (context, userState) {
                            return PostWidget(
                              user: userState,
                              postModel: postState[index]!,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget with NavigatorManager {
  const PostWidget({required this.postModel, required this.user, super.key});
  final PostModel postModel;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final isLiked = postModel.likes?.contains(user) ?? false;
    final currentState = FeedViewInherited.of(context);

    return BlocProvider.value(
      value: BlocProvider.of<PostCubit>(context),
      child: BlocSelector<UserModelCubit, UserModelState, UserModel>(
        selector: (state) {
          return state.currentUser ?? UserModel();
        },
        builder: (context, state) {
          return InkWell(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            onTap: currentState.onPostButtonPressed(postModel, state),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15.sp,
                      backgroundImage: postModel.user.image != null
                          ? NetworkImage(postModel.user.image!)
                          : const AssetImage(
                              'assets/pngs/default-user.png',
                            ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(postModel.user.name ?? 'Anonymous', style: context.theme.textTheme.headlineMedium),
                        Text(postModel.postTime!.timeAgo(), style: context.theme.textTheme.headlineSmall), //todo make extension for time
                      ],
                    ),
                  ],
                ),
                if (postModel.bodyImage != null) SizedBox(height: 2.h) else const SizedBox.shrink(),
                if (postModel.bodyImage != null)
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 40.h),
                    child: Image.memory(
                      postModel.bodyImage!,
                      width: 100.w,
                    ),
                  )
                else
                  const SizedBox(),
                SizedBox(height: 2.h),
                Text(postModel.header ?? 'Title is empty', style: context.theme.textTheme.headlineMedium),
                Tooltip(
                  message: postModel.body,
                  child: Text(
                    postModel.body ?? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: context.theme.textTheme.bodySmall,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 2.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<PostCubit>().toggleLike(postModel, user);
                        },
                        icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                      ),
                      Text(postModel.likes?.length.toString() ?? '0'),
                      SizedBox(width: 2.w),
                      const IconButton(onPressed: null, icon: Icon(Icons.comment)),
                      Text(postModel.comments?.length.toString() ?? '0'),
                    ],
                  ),
                ),
                Divider(
                  thickness: .2.h,
                  height: 2.h,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
