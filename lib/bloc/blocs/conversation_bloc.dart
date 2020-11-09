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
    if (event is InitializeConversation) {
      yield* _mapLoadDataToState();
    }
  }

  Stream<ConversationState> _mapLoadDataToState() async* {
    yield LoadingConversation();
    try {
      final _getCurrentUser = await _userRepository.getUser();
      final _lastConversation = await _conversationRepository
          .getLastConversation(_getCurrentUser.uid);
      yield SuccessConversation(_lastConversation);
    } catch (_) {
      yield FailureConversation();
    }
  }
}
