import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@singleton
class MediaUtil {
  Future<File> getImageFromLibrary() {
    return ImagePicker.pickImage(source: ImageSource.gallery);
  }
}
