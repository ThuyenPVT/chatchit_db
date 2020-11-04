import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../di/injection.dart';
import '../../repositories/user_repository.dart';
import '../bloc.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _userRepository = getIt<UserRepository>();

  LoginBloc(LoginState initialState) : super(initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGoogle) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentials) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email.trim(),
        password: event.password.trim(),
      );
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _userRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
