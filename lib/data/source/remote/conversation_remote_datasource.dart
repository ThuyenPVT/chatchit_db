import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter/data/entities/conversation.dart';
import 'package:structure_flutter/data/entities/conversation_snippet.dart';
import 'package:structure_flutter/data/entities/message.dart';

abstract class ConversationRemoteDataSource {
  Future<void> updateUserLastSeenTime(String userID);

  Future<void> createConversation(
    String currentID,
    String recipientID,
    Future<void> Function(String conversationID) onSuccess,
  );

  Future<void> createLastConversation(
      String currentID,
      String recipientID,
      String conversationID,
      String image,
      String lastMessage,
      String name,
      int unseenCount);

  Future<void> sendMessage(String conversationID, Message message);

  Future<List<ConversationSnippet>> getLastConversations(String userID);

  Future<List<Conversation>> getConversations(String userID);
}

@Singleton(as: ConversationRemoteDataSource)
class ConversationRemoteDataSourceImpl extends ConversationRemoteDataSource {
  final _userCollection = FirebaseFirestore.instance.collection("Users");
  final _conversationCollection =
      FirebaseFirestore.instance.collection("Conversations");

  @override
  Future<void> createConversation(
    String currentID,
    String recipientID,
    Future<void> Function(String conversationID) onSuccess,
  ) async {
    var _conversationRef =
        _userCollection.doc(currentID).collection("Conversations");
    try {
      var _lastConversation = await _conversationRef.doc(recipientID).get();
      if (_lastConversation.data != null) {
        return onSuccess(_lastConversation.data()["conversationID"]);
      } else {
        var _conversationRef = _conversationCollection.doc();
        await _conversationRef.set(
          {
            "members": [currentID, recipientID],
            "ownerID": currentID,
            'messages': [],
          },
        );
        return onSuccess(_conversationRef.id);
      }
    } catch (_) {}
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
  ) async {
    return await _userCollection
        .doc(currentID)
        .collection("Conversations")
        .doc(recipientID)
        .set({
      "conversationID": conversationID,
      "image": image,
      "lastMessage": lastMessage,
      "name": name,
      "timestamp": DateTime.now().toUtc(),
      "unseenCount": unseenCount,
    });
  }

  @override
  Future<void> updateUserLastSeenTime(String userID) {
    var _ref = _userCollection.doc(userID);
    return _ref.update({"lastSeen": Timestamp.now()});
  }

  @override
  Future<void> sendMessage(String conversationID, Message message) {
    var _ref = _conversationCollection.doc(conversationID);
    var _messageType = "";
    switch (message.type) {
      case MessageType.Text:
        _messageType = "text";
        break;
      case MessageType.Image:
        _messageType = "image";
        break;
      default:
    }
    return _ref.update({
      "messages": FieldValue.arrayUnion(
        [
          {
            "message": message.content,
            "senderID": message.senderID,
            "timestamp": message.timestamp,
            "type": _messageType,
          },
        ],
      ),
    });
  }

  @override
  Future<List<ConversationSnippet>> getLastConversations(
      String recipientID) async {
    final _lastConversation = await _userCollection
        .doc(recipientID)
        .collection("Conversations")
        .get();
    return _lastConversation.docs
        .map((doc) => ConversationSnippet.fromFireStore(doc))
        .toList();
  }

  @override
  Future<List<Conversation>> getConversations(String conversationID) async {
    try {
      final _docsSnapshot =
          _conversationCollection.doc(conversationID).snapshots();
      final list = await _docsSnapshot
          .map((event) => Conversation.fromFireStore(event))
          .toList();
      return list;
    } catch (_) {
      return [];
    }
  }
}
