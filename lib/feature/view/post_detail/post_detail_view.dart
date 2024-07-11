import 'package:ct_social/core/extension/date_time_extension.dart';
import 'package:ct_social/core/extension/theme_getter_extension.dart';
import 'package:ct_social/feature/cubit/post/post_cubit.dart';
import 'package:ct_social/feature/cubit/user/user_model_cubit.dart';
import 'package:ct_social/feature/model/comment_model.dart';
import 'package:ct_social/feature/model/user_model.dart';
import 'package:ct_social/feature/view/post_detail/post_detail_view_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

part 'widget/comments_widget.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // final currentState = PostDetailViewInherited.of(context);
    return BlocProvider.value(
      value: BlocProvider.of<PostCubit>(context),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const _PostDetailWidget(),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostDetailWidget extends StatelessWidget {
  const _PostDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = PostDetailViewInherited.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15.sp,
              backgroundImage: currentState.post.user.image != null ? NetworkImage(currentState.post.user.image!) : const AssetImage('assets/pngs/default-user.png'),
            ),
            SizedBox(width: 1.w),
            Text(currentState.post.user.name!, style: context.theme.textTheme.headlineMedium),
          ],
        ),
        SizedBox(height: 1.h),
        const _PostImage(),
        if (currentState.post.bodyImage != null) const _LikeAndShare() else const SizedBox.shrink(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w), // magic number
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              if (currentState.post.header != null) Text(currentState.post.header!, style: context.theme.textTheme.headlineMedium) else const SizedBox.shrink(),
              Text(currentState.post.body!, style: context.theme.textTheme.bodyMedium),
            ],
          ),
        ),
        if (currentState.post.bodyImage == null) const _LikeAndShare() else const SizedBox.shrink(),
        if (currentState.post.comments?.isNotEmpty ?? false)
          BlocBuilder<PostCubit, PostState>(
            builder: (builderContext, state) {
              return TextButton(
                onPressed: currentState.openCommentProvider(),
                child: Text('See all ${currentState.post.comments!.length} comments', style: context.theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
              );
            },
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}

class _LikeAndShare extends StatelessWidget {
  const _LikeAndShare({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = PostDetailViewInherited.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
        Row(
          children: [
            BlocBuilder<PostCubit, PostState>(
              builder: (context, state) {
                currentState.isLiked = currentState.post.likes!.contains(currentState.currentUser);
                return IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    currentState.isLiked ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: currentState.likeProvider(),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.comment),
              onPressed: currentState.openCommentProvider(),
            ),
          ],
        ),
        BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Text('${currentState.post.likes!.length} likes', style: context.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            );
          },
        ),
      ],
    );
  }
}

class _PostImage extends StatelessWidget {
  const _PostImage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = PostDetailViewInherited.of(context);
    return currentState.post.bodyImage != null
        ? ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 60.h),
            child: Image.memory(currentState.post.bodyImage!),
          )
        : const SizedBox.shrink();
  }
}
