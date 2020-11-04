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

  Future<void> sendFriendRequest({
    String currentID,
    String recipientID,
    String name,
    bool pending,
  });

  Future<List<Account>> getUsersByName(String searchName);

  List<QueryDocumentSnapshot> getAllUsers(
    AsyncSnapshot<QuerySnapshot> snapshot,
  );

  Future<List<Account>> parseToObject();
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
    return _accountRemoteDataSource.getUsersByName(searchName);
  }

  @override
  List<QueryDocumentSnapshot> getAllUsers(
      AsyncSnapshot<QuerySnapshot> snapshot) {
    return _accountRemoteDataSource.getAllUsers(snapshot);
  }

  @override
  Future<List<Account>> getUsersByName(String searchName) {
    return _accountRemoteDataSource.getUsersByName(searchName);
  }

  @override
  Future<List<Account>> parseToObject() {
    return _accountRemoteDataSource.parseToObject();
  }

  @override
  Future<void> sendFriendRequest({
    String currentID,
    String recipientID,
    String name,
    bool pending,
  }) {
    return _accountRemoteDataSource.sendFriendRequest(
        currentID: currentID,
        recipientID: recipientID,
        name: name,
        pending: pending);
  }
}
