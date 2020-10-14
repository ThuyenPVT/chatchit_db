import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:structure_flutter/bloc/events/user_event.dart';
import 'package:structure_flutter/bloc/states/user_state.dart';
import 'package:structure_flutter/data/entities/user.dart';
import 'package:structure_flutter/data/source/remote/user_remote_datasource.dart';
import 'package:structure_flutter/di/injection.dart';

@singleton
class UserGitBloc extends Bloc<UserGitEvent, UserGitState> {
  final UserRemoteDataSource _userRepository = getIt<UserRemoteDataSource>();

  UserGitBloc();

  @override
  Stream<UserGitState> transform(Stream<UserGitEvent> events,
      Stream<UserGitState> Function(UserGitEvent event) next) {
    return super.transform(
        (events as Observable<UserGitEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }

  @override
  UserGitState get initialState => UserGitUnInitialized();

  @override
  Stream<UserGitState> mapEventToState(UserGitEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is UserGitUnInitialized) {
          final users = await fetchUserGit(1);
          yield UserGitLoaded(users: users, hasReachMax: false);
        } else if (currentState is UserGitLoaded) {
          var page =
              ((currentState as UserGitLoaded).users.length / 10).ceil() + 1;
          final users = await fetchUserGit(page);
          yield users.length < 10
              ? (currentState as UserGitLoaded).copyWith(hasReachedMax: true)
              : UserGitLoaded(
                  users: (currentState as UserGitLoaded).users + users,
                  hasReachMax: false);
        }
      } catch (_) {
        yield UserGitError();
      }
    }
  }

  bool _hasReachedMax(UserGitState state) =>
      state is UserGitLoaded && state.hasReachMax;

  Future<List<UserGitEntity>> fetchUserGit(int page) async {
    return _userRepository.getUser(page);
  }
}
