import 'package:cloud_firestore/cloud_firestore.dart';
import 'message.dart';

class ConversationSnippet {
  final String recipientID;
  final String conversationID;
  final String lastMessage;
  final String name;
  final String image;
  final MessageType type;
  final int unseenCount;
  final Timestamp timestamp;

  ConversationSnippet(
      {this.conversationID,
      this.recipientID,
      this.lastMessage,
      this.unseenCount,
      this.timestamp,
      this.name,
      this.image,
      this.type});

  factory ConversationSnippet.fromFireStore(DocumentSnapshot snapshot) {
    var _data = snapshot.data;
    var _messageType = MessageType.Text;
    if (_data()["type"] != null) {
      switch (_data()["type"]) {
        case "text":
          break;
        case "image":
          _messageType = MessageType.Image;
          break;
        default:
      }
    }
    return ConversationSnippet(
      recipientID: snapshot.id,
      conversationID: _data()["conversationID"],
      lastMessage: _data()["lastMessage"] != null ? _data()["lastMessage"] : "",
      unseenCount: _data()["unseenCount"],
      timestamp: _data()["timestamp"] != null ? _data()["timestamp"] : null,
      name: _data()["name"],
      image: _data()["image"],
      type: _messageType,
    );
  }
}
