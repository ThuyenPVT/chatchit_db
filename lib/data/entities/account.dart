import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class Account {
  final String id;
  final String email;
  final String image;
  final Timestamp lastSeen;
  final String name;

  Account({this.id, this.email, this.name, this.image, this.lastSeen});

  factory Account.fromFireStore(DocumentSnapshot snapshot) {
    var _data = snapshot.data;
    return Account(
      id: snapshot.id,
      lastSeen: _data()["lastSeen"],
      email: _data()["email"],
      name: _data()["name"],
      image: _data()["image"],
    );
  }
}
