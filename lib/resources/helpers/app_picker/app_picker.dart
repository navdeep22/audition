import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AppPicker {
  static Future<String> pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      return file.path;
    }
    return "";
  }
}
