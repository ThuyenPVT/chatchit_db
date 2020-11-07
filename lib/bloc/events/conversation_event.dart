import 'package:equatable/equatable.dart';

abstract class ConversationEvent extends Equatable {
  ConversationEvent([List props = const []]) : super();
}

class InitializeConversation extends ConversationEvent {
  final String message = "InitializeLoadData";

  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}
