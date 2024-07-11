import 'package:image_picker/image_picker.dart';

/// Image upload manager
class ImageUploadManager {
  /// Fetch image from gallery
  Future<XFile?> fetchFromLibrary() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    return image;
  }

  /// Fetch image from camera
  Future<XFile?> fetchFromCamera() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    return image;
  }
}
