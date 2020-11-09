import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter/data/entities/account.dart';

abstract class FriendRemoteDataSource {
  Future<void> sendFriendRequest({
    String currentID,
    String recipientID,
    String name,
    bool pending,
  });

  Future<List<Account>> getListFriendAccount();
}

@Singleton(as: FriendRemoteDataSource)
class FriendRemoteDataSourceImpl extends FriendRemoteDataSource {
  final _userCollection = FirebaseFirestore.instance.collection("Users");

  @override
  Future<void> sendFriendRequest({
    String currentID,
    String recipientID,
    String name,
    bool pending,
  }) async {
    try {
      return await _userCollection
          .doc(currentID)
          .collection("Friends")
          .doc(recipientID)
          .set({"name": name, "pending": pending});
    } catch (_) {}
  }

  @override
  Future<List<Account>> getListFriendAccount() async {
    final _snapshot = await _userCollection.get();
    return _snapshot.docs.map((doc) => Account.fromFireStore(doc)).toList();
  }
}
