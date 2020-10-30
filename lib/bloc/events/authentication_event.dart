import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();
}

class AppStarted extends AuthenticationEvent {
  final String message = 'AppStarted';

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}

class LoggedIn extends AuthenticationEvent {
  final String message = 'AppStarted';

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}

class LoggedOut extends AuthenticationEvent {
  final String message = 'LoggedOut';

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}
