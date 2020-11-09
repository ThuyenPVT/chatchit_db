import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter/data/source/remote/storage_remote_datasource.dart';
import 'package:structure_flutter/di/injection.dart';

@singleton
class StorageRepository {
  final _storageRemoteDataSource = getIt<StorageRemoteDataSource>();

  Future<StorageTaskSnapshot> uploadUserImage(String uid, File image) {
    return _storageRemoteDataSource.uploadUserImage(uid, image);
  }
}
