part of '../post_detail_view.dart';

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({required this.currentState, super.key});
  final PostDetailViewProviderState currentState;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<PostCubit, PostState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: currentState.post.comments?.length ?? 0,
                  itemBuilder: (context, index) {
                    return _Comment(comment: currentState.post.comments![index]!);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 3.h),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: currentState.commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                BlocSelector<UserModelCubit, UserModelState, UserModel>(
                  selector: (state) {
                    if (state.currentUser == null) {
                      throw Exception('User not found');
                    }
                    return state.currentUser!;
                  },
                  builder: (context, state) {
                    return IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: currentState.addCommentProvider(),
                      icon: const Icon(Icons.send),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Comment extends StatelessWidget {
  const _Comment({required this.comment, super.key});
  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: comment.user?.image != null ? NetworkImage(comment.user!.image!) : const AssetImage('assets/pngs/default-user.png'),
        ),
        SizedBox(width: 1.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (comment.user?.email != null)
                  Text(comment.user!.email!, style: context.theme.textTheme.headlineMedium)
                else
                  Text('Anonymous', style: context.theme.textTheme.headlineMedium),
                SizedBox(
                  width: 2.w,
                ),
                Text(comment.commentedAt!.timeAgo(), style: context.theme.textTheme.bodySmall),
              ],
            ),
            Text(
              comment.comment!,
              style: context.theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
