import 'package:equatable/equatable.dart';
import 'package:structure_flutter/data/entities/conversation_snippet.dart';

abstract class ConversationState extends Equatable {
  ConversationState([List props = const []]) : super();
}

class LoadingConversation extends ConversationState {
  final String message = "loading";

  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}

class FailureConversation extends ConversationState {
  final String message = "Failure!";

  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}

class SuccessConversation extends ConversationState {
  final List<ConversationSnippet> lastConversation;

  SuccessConversation(this.lastConversation);

  @override
  List<Object> get props => [lastConversation];
}
