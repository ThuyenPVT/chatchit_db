import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageRemoteDataSource {
  Future<StorageTaskSnapshot> uploadUserImage(String uid, File image);
}

class StorageRemoteDataSourceImpl extends StorageRemoteDataSource {
  StorageReference _baseRef;

  StorageRemoteDataSourceImpl(this._baseRef);

  String _profileImages = "profile_images";

  @override
  Future<StorageTaskSnapshot> uploadUserImage(String uid, File image) {
    try {
      return _baseRef
          .child(_profileImages)
          .child(uid)
          .putFile(image)
          .onComplete;
    } catch (_) {}
  }
}
