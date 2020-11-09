import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/bloc/events/conversation_event.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/repositories/conversation_repository.dart';
import 'package:structure_flutter/repositories/user_repository.dart';

import '../bloc.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc(ConversationState initialState) : super(initialState);
  final _conversationRepository = getIt<ConversationRepository>();
  final _userRepository = getIt<UserRepository>();

  @override
  Stream<ConversationState> mapEventToState(ConversationEvent event) async* {
    if (event is InitRecentConversation) {
      yield* _mapRecentConversationToState();
    }
    if (event is InitConversation) {
      yield* _mapConversationToState();
    }
  }

  Stream<ConversationState> _mapRecentConversationToState() async* {
    yield LoadingConversation();
    try {
      final _getCurrentUser = await _userRepository.getUser();
      final _lastConversation = await _conversationRepository
          .getLastConversations(_getCurrentUser.uid);
      yield SuccessConversation(lastConversation: _lastConversation);
    } catch (_) {
      yield FailureConversation();
    }
  }

  Stream<ConversationState> _mapConversationToState() async* {
    yield LoadingConversation();
    try {

      final _getCurrentUser = await _conversationRepository.getConversations("vt2hUshij0Q0Nj8UtYptGQbduYN2");
      yield SuccessConversation(conversation: _getCurrentUser);
    } catch (_) {
      yield FailureConversation();
    }
  }
}
