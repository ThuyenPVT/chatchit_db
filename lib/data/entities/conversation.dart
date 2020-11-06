import 'package:cloud_firestore/cloud_firestore.dart';

import 'message.dart';

class Conversation {
  final String id;
  final List members;
  final List<Message> messages;
  final String ownerID;

  Conversation({
    this.id,
    this.members,
    this.ownerID,
    this.messages,
  });

  factory Conversation.fromFireStore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data;
    List _messages = _data()["messages"];
    if (_messages != null) {
      _messages = _messages.map((_m) {
        return Message(
            type: _m["type"] == "text" ? MessageType.Text : MessageType.Image,
            content: _m["message"],
            timestamp: _m["timestamp"],
            senderID: _m["senderID"]);
      }).toList();
    } else {
      _messages = [];
    }
    return Conversation(
        id: _snapshot.id,
        members: _data()["members"],
        ownerID: _data()["ownerID"],
        messages: _messages);
  }
}
