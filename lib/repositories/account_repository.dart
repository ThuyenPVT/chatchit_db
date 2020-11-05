import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:structure_flutter/data/entities/account.dart';
import 'package:structure_flutter/data/source/remote/account_remote_datasource.dart';
import 'package:structure_flutter/di/injection.dart';

abstract class AccountRepository {
  Future<void> createUser(
    String uid,
    String name,
    String email,
    String imageURL,
  );

  Future<List<Account>> getUsers(String searchName);

  List<QueryDocumentSnapshot> getAllUsers(AsyncSnapshot<QuerySnapshot> snapshot);

  Future<void> sendFriendRequest(
    String currentID,
    String recipientID,
    String name,
    bool pending,
  );
}

class AccountRepositoryImpl extends AccountRepository {
  final _accountRemoteDataSource = getIt<AccountRemoteDataSource>();

  Future<void> createUser(
    String uid,
    String name,
    String email,
    String imageURL,
  ) {
    return _accountRemoteDataSource.createUser(uid, name, email, imageURL);
  }

  Future<List<Account>> getUsers(String searchName) {
    return _accountRemoteDataSource.getUsers(searchName);
  }

  @override
  List<QueryDocumentSnapshot> getAllUsers(
      AsyncSnapshot<QuerySnapshot> snapshot) {
    return _accountRemoteDataSource.getAllUsers(snapshot);
  }

  @override
  Future<void> sendFriendRequest(
    String currentID,
    String recipientID,
    String name,
    bool pending,
  ) {
    return _accountRemoteDataSource.sendFriendRequest(
        currentID, recipientID, name, pending);
  }
}
