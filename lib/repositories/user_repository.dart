import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:structure_flutter/data/source/remote/user_remote_datasources.dart';
import 'package:structure_flutter/di/injection.dart';

class UserRepository {
  final _userRemoteDataSource = getIt<UserRemoteDataSource>();

  Future<FirebaseUser> signInWithGoogle() {
    return _userRemoteDataSource.signInWithGoogle();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _userRemoteDataSource.signInWithCredentials(email, password);
  }

  Future<void> signUp(String email, String password) {
    return _userRemoteDataSource.signUp(email, password);
  }

  Future<void> signOut() {
    return _userRemoteDataSource.signOut();
  }

  Future<bool> isSignedIn() {
    return _userRemoteDataSource.isSignedIn();
  }

  Future<FirebaseUser> getUser() {
    return _userRemoteDataSource.getUser();
  }
}
