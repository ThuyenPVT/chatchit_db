import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class AccountRemoteDataSource {
  Future<void> createUser(String uid, String name, String email, String imageURL);
}

@Singleton(as: AccountRemoteDataSource)
class AccountRemoteDataSourceImpl extends AccountRemoteDataSource {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Future<void> createUser(String uid, String name, String email, String imageURL) async {
    try {
      return await users.doc(uid).set({
        "name": name,
        "email": email,
        "image": imageURL,
        "lastSeen": DateTime.now().toUtc(),
      });
    } catch (_) {
    }
  }
}
