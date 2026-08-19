import 'package:image_picker/image_picker.dart';

/// Picks multiple images from the device gallery.
/// Returns a list of file paths or null if cancelled/failed.
Future<List<String>?> pickImages() async {
  try {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage(imageQuality: 85);

    if (images.isEmpty) {
      return null;
    }

    return images.map((xFile) => xFile.path).toList();
  } catch (e) {
    return null;
  }
}

/// Picks a single image from the device gallery.
/// Returns the file path or null if cancelled/failed.
Future<String?> pickSingleImage() async {
  try {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    return image?.path;
  } catch (e) {
    return null;
  }
}

/// Picks a video from the gallery.
///
/// [maxDuration] is enforced by the picker when the platform supports it
/// (regular listing videos are capped at 60 seconds).
Future<String?> pickVideo({Duration? maxDuration}) async {
  try {
    final picker = ImagePicker();
    final video = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: maxDuration,
    );
    return video?.path;
  } catch (e) {
    return null;
  }
}
