import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/bloc/events/friend_event.dart';
import 'package:structure_flutter/bloc/states/friend_state.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/repositories/friend_repository.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  FriendBloc(FriendState initialState) : super(initialState);
  final _friendRepository = getIt<FriendRepository>();

  @override
  Stream<FriendState> mapEventToState(FriendEvent event) async* {
    if (event is InitializeLoadData) {
      yield* _mapLoadDataToState();
    }
  }

  Stream<FriendState> _mapLoadDataToState() async* {
    yield LoadingData();
    try {
      final _data = await _friendRepository.getListFriendAccount();
      yield Success(_data);
    } catch (_) {
      yield Failure();
    }
  }
}
