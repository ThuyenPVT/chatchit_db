import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/data/source/remote/user_remote_datasource.dart';

class UserRepository {
  final _userRemoteDataSource = getIt<UserRemoteDataSource>();

  Future<User> signInWithGoogle() {
    return _userRemoteDataSource.signInWithGoogle();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _userRemoteDataSource.signInWithCredentials(email, password);
  }

  Future<String> signUp(String email, String password) {
    return _userRemoteDataSource.signUp(email, password);
  }

  Future<void> signOut() {
    return _userRemoteDataSource.signOut();
  }

  Future<bool> isSignedIn() {
    return _userRemoteDataSource.isSignedIn();
  }

  Future<User> getUser() {
    return _userRemoteDataSource.getUser();
  }
}
