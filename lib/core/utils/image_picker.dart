import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<List<File>> pickImages() async {
  List<File> listImages = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (final image in imageFiles) {
      listImages.add(File(image.path));
    }
  }
  return listImages;
}

pickImage() async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    return file.readAsBytes();
  }
}
