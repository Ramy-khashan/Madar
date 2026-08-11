import 'package:image_picker/image_picker.dart';

/// Picks multiple images from the device gallery
/// Returns a list of file paths or null if cancelled/failed
Future<List<String>?> pickImages() async {
  try {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage(
      imageQuality: 85,
    );

    if (images.isEmpty) {
      return null;
    }

    return images.map((xFile) => xFile.path).toList();
  } catch (e) {
    // Handle permission errors or other exceptions
    return null;
  }
}

/// Picks a single image from the device gallery
/// Returns the file path or null if cancelled/failed
Future<String?> pickSingleImage() async {
  try {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    return image?.path;
  } catch (e) {
    // Handle permission errors or other exceptions
    return null;
  }
}
