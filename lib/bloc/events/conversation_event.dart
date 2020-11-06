import 'package:equatable/equatable.dart';

abstract class ConversationEvent extends Equatable {
  ConversationEvent([List props = const []]) : super();
}

class InitRecentConversation extends ConversationEvent {
  final String message = "InitializeLoadData";

  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}

class InitConversation extends ConversationEvent {
  final String message = "InitConversation";

  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}
