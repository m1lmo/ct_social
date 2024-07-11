import 'package:ct_social/core/enum/notify_type.dart';
import 'package:ct_social/core/helper/image_upload_manager.dart';
import 'package:ct_social/core/widget/custom_notify.dart';
import 'package:ct_social/feature/cubit/post/post_cubit.dart';
import 'package:ct_social/feature/model/post_model.dart';
import 'package:ct_social/feature/model/user_model.dart';
import 'package:ct_social/feature/view/new_post/new_post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final class NewPostViewInherited extends InheritedWidget {
  const NewPostViewInherited({
    required super.child,
    required this.data,
    super.key,
  });
  final NewPostViewProviderState data;

  static NewPostViewProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<NewPostViewInherited>();
    if (result != null) {
      return result.data;
    } else {
      throw Exception('Could not find the inherited widget');
    }
  }

  @override
  bool updateShouldNotify(covariant NewPostViewInherited oldWidget) => false;
}

class NewPostViewProvider extends StatefulWidget {
  const NewPostViewProvider({super.key});

  @override
  State<NewPostViewProvider> createState() => NewPostViewProviderState();
}

class NewPostViewProviderState extends State<NewPostViewProvider> with TickerProviderStateMixin {
  final ValueNotifier<XFile?> image = ValueNotifier<XFile?>(null);
  final postBody = TextEditingController();
  final postHeader = TextEditingController();
  late final OverlayState overlayState;
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  /// This method is used for add a image from gallery to post
  VoidCallback imageUploadFromGalleryProvider() {
    return () async {
      final response = await ImageUploadManager().fetchFromLibrary();
      if (response == null) return;
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: response.path,
      );
      if (croppedImage == null) return;
      image.value = XFile(croppedImage.path);
    };
  }

  /// This method is used for add a image from camera to post
  VoidCallback imageUploadFromCamProvider() {
    return () async {
      final response = await ImageUploadManager().fetchFromCamera();
      if (response == null) return;
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: response.path,
      );
      if (croppedImage == null) return;
      image.value = XFile(croppedImage.path);
    };
  }

  /// This method is used to add a post
  VoidCallback postProvider(UserModel state) {
    return () async {
      if (postHeader.text.isEmpty || postBody.text.isEmpty) {
        return CustomNotify(overlayState, tickerProviderService: this, title: 'Error', message: 'Please fill the blanks').show();
      }
      context.read<PostCubit>().addPost(
            PostModel(
              user: state,
              comments: const [],
              likes: const [],
              header: postHeader.text,
              body: postBody.text,
            ),
            image: image.value,
          );
      await CustomNotify(overlayState, tickerProviderService: this, type: NotifyType.success, title: 'Success', message: 'Post added').show();
      Navigator.pop(context);
    };
  }

  @override
  void initState() {
    super.initState();
    overlayState = Overlay.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    postBody.dispose();
    postHeader.dispose();
    image.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NewPostViewInherited(data: this, child: const NewPostView());
  }
}
