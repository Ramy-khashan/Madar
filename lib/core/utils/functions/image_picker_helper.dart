import 'package:image_picker/image_picker.dart';

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
