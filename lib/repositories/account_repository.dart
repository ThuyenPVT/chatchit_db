import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:structure_flutter/data/entities/account.dart';
import 'package:structure_flutter/data/entities/conversation.dart';
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

  List<Account> getAllAccountWithoutMe(
    AsyncSnapshot<QuerySnapshot> snapshot,
    String id,
  );

  Future<void> sendFriendRequest({
    String currentID,
    String recipientID,
    String name,
    bool pending,
  });

  Future<void> createLastConversation(
    String currentID,
    String recipientID,
    String conversationID,
    String image,
    String lastMessage,
    String name,
    int unseenCount,
  );

  Stream<Conversation> getConversation(String conversationID);

  Stream<List<ConversationSnippet>> getUserConversations(String userID);

  Future<void> createConversation(
    String currentID,
    String recipientID,
    Future<void> Function(String conversationID) onSuccess,
  );

  Future<List<Account>> parseToObject(String id);

  Future<List<Account>> getUsersByName(String searchName);
}

class AccountRepositoryImpl extends AccountRepository {
  final _accountRemoteDataSource = getIt<AccountRemoteDataSource>();

  @override
  Future<void> createConversation(
    String _currentID,
    String _recipientID,
    Future<void> _onSuccess(String _conversationID),
  ) {
    return _accountRemoteDataSource.createConversation(
      _currentID,
      _recipientID,
      (_conversationID) => null,
    );
  }

  @override
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
  Future<List<Account>> getUsersByName(String searchName) {
    return _accountRemoteDataSource.getUsersByName(searchName);
  }

  @override
  Future<List<Account>> parseToObject(String id) async {
    var _accounts = await _accountRemoteDataSource.parseToObject(id);
    _accounts.removeWhere((element) => element.id == id);
    return _accounts;
  }

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

  @override
  List<Account> getAllAccountWithoutMe(
    AsyncSnapshot<QuerySnapshot> snapshot,
    String id,
  ) {
    var accounts = _accountRemoteDataSource.getAllAccount(snapshot, id);
    accounts.removeWhere((element) => element.id == id);
    return accounts;
  }

  @override
  Future<void> createLastConversation(
    String currentID,
    String recipientID,
    String conversationID,
    String image,
    String lastMessage,
    String name,
    int unseenCount,
  ) {
    return _accountRemoteDataSource.createLastConversation(currentID,
        recipientID, conversationID, image, lastMessage, name, unseenCount);
  }

  @override
  Stream<Conversation> getConversation(String conversationID) {
    return _accountRemoteDataSource.getConversation(conversationID);
  }

  @override
  Stream<List<ConversationSnippet>> getUserConversations(String userID) {
    return _accountRemoteDataSource.getUserConversations(userID);
  }
}
