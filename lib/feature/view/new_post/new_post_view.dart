import 'dart:io';

import 'package:ct_social/core/extension/theme_getter_extension.dart';
import 'package:ct_social/feature/cubit/post/post_cubit.dart';
import 'package:ct_social/feature/cubit/user/user_model_cubit.dart';
import 'package:ct_social/feature/model/user_model.dart';
import 'package:ct_social/feature/view/new_post/new_post_view_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class NewPostView extends StatelessWidget {
  const NewPostView({super.key});
  @override
  Widget build(BuildContext context) {
    final currentState = NewPostViewInherited.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<UserModelCubit>(context),
        ),
        BlocProvider.value(
          value: BlocProvider.of<PostCubit>(context),
        ),
      ],
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'camera',
              onPressed: currentState.imageUploadFromCamProvider(),
              child: const Icon(Icons.camera_alt),
            ),
            SizedBox(height: 2.h),
            FloatingActionButton(
              heroTag: 'gallery',
              onPressed: currentState.imageUploadFromGalleryProvider(),
              child: const Icon(Icons.image),
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text('New Post'),
          actions: [
            BlocSelector<UserModelCubit, UserModelState, UserModel>(
              selector: (state) {
                return state.currentUser ?? UserModel();
              },
              builder: (context, state) {
                return TextButton(
                  onPressed: currentState.postProvider(state),
                  child: Text('Post', style: context.theme.textTheme.headlineMedium?.copyWith(color: Colors.green)),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocSelector<UserModelCubit, UserModelState, UserModel>(
                selector: (state) {
                  if (state.currentUser == null) {
                    return UserModel();
                  }
                  return state.currentUser!;
                },
                builder: (context, state) {
                  return CircleAvatar(
                    radius: 15.sp,
                    backgroundImage: state.image != null ? NetworkImage(state.image!) : const AssetImage('assets/pngs/default-user.png'),
                  );
                },
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: currentState.postHeader,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: currentState.postBody,
                      decoration: const InputDecoration(hintText: "What's on your mind?", border: InputBorder.none),
                      minLines: 2,
                      maxLines: 10,
                    ),
                    ValueListenableBuilder(
                      valueListenable: currentState.image,
                      builder: (context, value, child) {
                        if (value != null) return Image.file(File(value.path));
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
