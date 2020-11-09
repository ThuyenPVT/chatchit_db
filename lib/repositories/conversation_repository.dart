import 'package:injectable/injectable.dart';
import 'package:structure_flutter/data/entities/conversation.dart';
import 'package:structure_flutter/data/entities/conversation_snippet.dart';
import 'package:structure_flutter/data/entities/message.dart';
import 'package:structure_flutter/data/source/remote/conversation_remote_datasource.dart';
import 'package:structure_flutter/di/injection.dart';

abstract class ConversationRepository {
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

  Future<List<Conversation>> getConversations(String conversationID);
}

@Singleton(as: ConversationRepository)
class ConversationRepositoryImpl extends ConversationRepository {
  final _conversationRemoteDataSource = getIt<ConversationRemoteDataSource>();

  @override
  Future<void> createConversation(
    String _currentID,
    String _recipientID,
    Future<void> _onSuccess(String _conversationID),
  ) {
    return _conversationRemoteDataSource.createConversation(
      _currentID,
      _recipientID,
      (_conversationID) => null,
    );
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
    return _conversationRemoteDataSource.createLastConversation(currentID,
        recipientID, conversationID, image, lastMessage, name, unseenCount);
  }

  @override
  Future<void> sendMessage(String conversationID, Message message) {
    return _conversationRemoteDataSource.sendMessage(conversationID, message);
  }

  @override
  Future<void> updateUserLastSeenTime(String userID) {
    return _conversationRemoteDataSource.updateUserLastSeenTime(userID);
  }

  @override
  Future<List<ConversationSnippet>> getLastConversations(String userID) {
    return _conversationRemoteDataSource.getLastConversations(userID);
  }

  @override
  Future<List<Conversation>> getConversations(String conversationID) {
    return _conversationRemoteDataSource.getConversations(conversationID);
  }
}
