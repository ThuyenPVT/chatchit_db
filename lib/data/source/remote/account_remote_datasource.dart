import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter/data/entities/account.dart';

abstract class AccountRemoteDataSource {
  Future<void> createUser(
    String uid,
    String name,
    String email,
    String imageURL,
  );

  Future<List<Account>> getUsersByName(String searchName);

  Future<List<Account>> getUsers(String searchName);
}

@Singleton(as: AccountRemoteDataSource)
class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final _userCollection = FirebaseFirestore.instance.collection("Users");

  @override
  Future<void> createUser(
    String uid,
    String name,
    String email,
    String imageURL,
  ) async {
    try {
      return await _userCollection.doc(uid).set({
        "id": uid,
        "name": name,
        "email": email,
        "image": imageURL,
        "lastSeen": DateTime.now().toUtc(),
      });
    } catch (_) {}
  }

  @override
  Future<List<Account>> getUsersByName(String searchName) async {
    var _userRef = _userCollection
        .where("name", isGreaterThanOrEqualTo: searchName)
        .where("name", isLessThan: searchName + 'z');
    final _snapshot = await _userRef.get();
    return _snapshot.docs.map((doc) => Account.fromFireStore(doc)).toList();
  }

  @override
  Future<List<Account>> getUsers(String searchName) {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
